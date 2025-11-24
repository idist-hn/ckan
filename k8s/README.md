# CKAN Kubernetes Deployment

Hướng dẫn triển khai CKAN lên Kubernetes cluster.

## Yêu cầu

- Kubernetes cluster (v1.24+)
- kubectl CLI
- Helm (optional, for cert-manager)
- Docker registry (để lưu CKAN image)
- Storage class hỗ trợ ReadWriteMany (cho CKAN storage)

## Cấu trúc thư mục

```
k8s/
├── namespace.yaml              # Namespace cho CKAN
├── configmap.yaml              # ConfigMap cho biến môi trường
├── secrets.yaml                # Secrets cho passwords và keys
├── ckan-ini-configmap.yaml     # ConfigMap cho CKAN production.ini
├── postgres-pvc.yaml           # PVC cho PostgreSQL
├── postgres-deployment.yaml    # PostgreSQL deployment & service
├── redis-deployment.yaml       # Redis deployment & service
├── solr-pvc.yaml              # PVC cho Solr
├── solr-deployment.yaml        # Solr deployment & service
├── ckan-pvc.yaml              # PVC cho CKAN storage
├── ckan-deployment.yaml        # CKAN deployment & service
├── ingress.yaml               # Ingress cho external access
├── hpa.yaml                   # Horizontal Pod Autoscaler
├── db-init-job.yaml           # Job để khởi tạo database
└── README.md                  # File này
```

## Bước 1: Build và Push CKAN Docker Image

```bash
# Build image
docker build -t your-registry/ckan:latest .

# Push to registry
docker push your-registry/ckan:latest
```

## Bước 2: Cập nhật cấu hình

### 2.1. Cập nhật secrets.yaml

**QUAN TRỌNG**: Thay đổi tất cả passwords và secret keys!

```bash
# Generate random secrets
python -c 'import secrets; print(secrets.token_urlsafe(32))'
```

Cập nhật các giá trị trong `secrets.yaml`:
- `CKAN_SYSADMIN_PASSWORD`
- `POSTGRES_PASSWORD`
- `CKAN_DB_PASSWORD`
- `DATASTORE_READ_PASSWORD`
- `CKAN___BEAKER__SESSION__SECRET`
- `CKAN___API_TOKEN__JWT__ENCODE__SECRET`

### 2.2. Cập nhật configmap.yaml

Thay đổi:
- `CKAN_SITE_URL`: URL của website (vd: https://data.yourdomain.com)
- `CKAN_LOCALE_DEFAULT`: Ngôn ngữ mặc định

### 2.3. Cập nhật ingress.yaml

Thay đổi:
- `host`: Domain name của bạn
- `secretName`: Tên secret cho TLS certificate

### 2.4. Cập nhật ckan-deployment.yaml

Thay đổi:
- `image`: Đường dẫn đến CKAN image của bạn

### 2.5. Cập nhật Storage Class

Trong các file PVC, thay đổi `storageClassName` phù hợp với cluster của bạn:
- `postgres-pvc.yaml`
- `solr-pvc.yaml`
- `ckan-pvc.yaml` (cần RWX storage class)

## Bước 3: Deploy lên Kubernetes

### 3.1. Tạo namespace

```bash
kubectl apply -f k8s/namespace.yaml
```

### 3.2. Tạo secrets và configmaps

```bash
kubectl apply -f k8s/secrets.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/ckan-ini-configmap.yaml
```

### 3.3. Deploy PostgreSQL

```bash
kubectl apply -f k8s/postgres-pvc.yaml
kubectl apply -f k8s/postgres-deployment.yaml
```

Đợi PostgreSQL ready:
```bash
kubectl wait --for=condition=ready pod -l app=postgres -n ckan --timeout=300s
```

### 3.4. Khởi tạo database

```bash
kubectl apply -f k8s/db-init-job.yaml
```

Kiểm tra job hoàn thành:
```bash
kubectl logs -f job/ckan-db-init -n ckan
```

### 3.5. Deploy Redis

```bash
kubectl apply -f k8s/redis-deployment.yaml
```

### 3.6. Deploy Solr

```bash
kubectl apply -f k8s/solr-pvc.yaml
kubectl apply -f k8s/solr-deployment.yaml
```

Đợi Solr ready:
```bash
kubectl wait --for=condition=ready pod -l app=solr -n ckan --timeout=300s
```

### 3.7. Deploy CKAN

```bash
kubectl apply -f k8s/ckan-pvc.yaml
kubectl apply -f k8s/ckan-deployment.yaml
```

Đợi CKAN ready:
```bash
kubectl wait --for=condition=ready pod -l app=ckan -n ckan --timeout=600s
```

### 3.8. Deploy Ingress

```bash
kubectl apply -f k8s/ingress.yaml
```

### 3.9. Deploy HPA (Optional)

```bash
kubectl apply -f k8s/hpa.yaml
```

## Bước 4: Tạo CKAN sysadmin user

```bash
# Get CKAN pod name
CKAN_POD=$(kubectl get pods -n ckan -l app=ckan -o jsonpath='{.items[0].metadata.name}')

# Create sysadmin user
kubectl exec -it $CKAN_POD -n ckan -- ckan -c /etc/ckan/production.ini sysadmin add admin \
  email=admin@yourdomain.com \
  name=admin
```

## Bước 5: Kiểm tra deployment

```bash
# Kiểm tra tất cả pods
kubectl get pods -n ckan

# Kiểm tra services
kubectl get svc -n ckan

# Kiểm tra ingress
kubectl get ingress -n ckan

# Xem logs CKAN
kubectl logs -f deployment/ckan -n ckan

# Xem logs PostgreSQL
kubectl logs -f deployment/postgres -n ckan
```

## Quản lý

### Scale CKAN pods

```bash
kubectl scale deployment ckan --replicas=5 -n ckan
```

### Update CKAN image

```bash
# Build và push image mới
docker build -t your-registry/ckan:v2 .
docker push your-registry/ckan:v2

# Update deployment
kubectl set image deployment/ckan ckan=your-registry/ckan:v2 -n ckan

# Hoặc edit deployment
kubectl edit deployment ckan -n ckan
```

### Backup database

```bash
# Get PostgreSQL pod
POSTGRES_POD=$(kubectl get pods -n ckan -l app=postgres -o jsonpath='{.items[0].metadata.name}')

# Backup
kubectl exec $POSTGRES_POD -n ckan -- pg_dump -U ckan_default ckan_default > ckan_backup.sql
```

### Restore database

```bash
# Restore
kubectl exec -i $POSTGRES_POD -n ckan -- psql -U ckan_default ckan_default < ckan_backup.sql
```

### Xem metrics (nếu có metrics-server)

```bash
kubectl top pods -n ckan
kubectl top nodes
```

## Troubleshooting

### CKAN pod không start

```bash
# Xem logs
kubectl logs deployment/ckan -n ckan

# Xem events
kubectl describe pod <ckan-pod-name> -n ckan

# Kiểm tra init container
kubectl logs <ckan-pod-name> -n ckan -c init-db
```

### Database connection error

```bash
# Kiểm tra PostgreSQL
kubectl exec -it deployment/postgres -n ckan -- psql -U postgres -c "\l"

# Test connection từ CKAN pod
kubectl exec -it <ckan-pod-name> -n ckan -- pg_isready -h postgres-service -p 5432
```

### Storage issues

```bash
# Kiểm tra PVC
kubectl get pvc -n ckan

# Kiểm tra PV
kubectl get pv

# Xem chi tiết PVC
kubectl describe pvc ckan-storage-pvc -n ckan
```

## Monitoring (Optional)

### Install Prometheus & Grafana

```bash
# Add Prometheus Helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install Prometheus
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring --create-namespace
```

### Access Grafana

```bash
# Port forward
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80

# Default credentials: admin / prom-operator
```

## SSL/TLS với cert-manager

### Install cert-manager

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml
```

### Tạo ClusterIssuer

```bash
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: admin@yourdomain.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
EOF
```

## Uninstall

```bash
# Xóa tất cả resources
kubectl delete -f k8s/

# Hoặc xóa namespace (sẽ xóa tất cả)
kubectl delete namespace ckan
```

## Lưu ý

1. **Storage**: CKAN cần ReadWriteMany storage class cho PVC nếu chạy nhiều replicas
2. **Database**: Nên dùng managed database service (CloudSQL, RDS) cho production
3. **Backup**: Thiết lập backup tự động cho database và storage
4. **Monitoring**: Cài đặt monitoring và alerting
5. **Security**: 
   - Thay đổi tất cả default passwords
   - Sử dụng NetworkPolicies
   - Enable RBAC
   - Scan images cho vulnerabilities
6. **Performance**: Tune PostgreSQL và Solr parameters cho workload của bạn

## Tài liệu tham khảo

- [CKAN Documentation](https://docs.ckan.org/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Helm Documentation](https://helm.sh/docs/)

