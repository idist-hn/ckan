# CKAN Kubernetes Deployment Guide

## Tổng Quan

Hướng dẫn này mô tả cách deploy CKAN lên Kubernetes cluster với domain `ckan.idist.dev` và SSL Let's Encrypt.

## Kiến Trúc

- **Namespace**: `ckan`
- **Domain**: `ckan.idist.dev`
- **SSL**: Let's Encrypt (tự động)
- **Ingress**: Nginx Ingress Controller (NodePort 30080/30443)
- **Storage**: Local storage class

### Components

1. **PostgreSQL** - Database chính và datastore
2. **Redis** - Cache layer
3. **Solr** - Search engine
4. **CKAN** - Application (2 replicas)

## Trạng Thái Hiện Tại

✅ **Đã Hoàn Thành:**
- Namespace `ckan` đã tạo
- ConfigMap với domain `ckan.idist.dev` đã cấu hình
- Secrets đã tạo
- PostgreSQL đang chạy
- Redis đang chạy
- Solr đang chạy
- Let's Encrypt ClusterIssuer đã tạo (production & staging)
- Ingress manifest đã cấu hình với SSL

⚠️ **Cần Hoàn Thành:**
- Load CKAN Docker image vào worker nodes
- Deploy CKAN application
- Deploy Ingress
- Cấu hình DNS

## Các Bước Deploy

### Bước 1: Load CKAN Image vào Worker Nodes

CKAN image đã được build và save tại: `ckan-image.tar`

**Option A: Nếu có SSH access tới worker nodes**

```bash
# Copy image tới các worker nodes
scp ckan-image.tar user@worker-01:/tmp/
scp ckan-image.tar user@worker-02:/tmp/
scp ckan-image.tar user@worker-03:/tmp/

# SSH vào từng worker và load image
ssh user@worker-01
docker load -i /tmp/ckan-image.tar
exit

ssh user@worker-02
docker load -i /tmp/ckan-image.tar
exit

ssh user@worker-03
docker load -i /tmp/ckan-image.tar
exit
```

**Option B: Nếu registry đã fix**

```bash
docker push registry.idist.dev/ckan:latest
```

### Bước 2: Deploy CKAN Application

```powershell
$env:KUBECONFIG = "E:\cdsqg\ckan\sources\ckan\k8s\kubeconfig.yaml"

# Deploy CKAN
kubectl apply -f k8s/ckan-deployment.yaml

# Kiểm tra pods
kubectl get pods -n ckan -w
```

Đợi cho tới khi tất cả CKAN pods ở trạng thái `Running` và `READY 1/1`.

### Bước 3: Deploy Ingress

```powershell
kubectl apply -f k8s/ingress.yaml
```

### Bước 4: Cấu Hình DNS

Ingress controller đang dùng **NodePort**:
- HTTP: Port 30080
- HTTPS: Port 30443

**Cấu hình DNS:**

Point domain `ckan.idist.dev` tới một trong các IP sau:
- Master nodes: 172.29.106.20 (hoặc master-02, master-03)
- Worker nodes: IP của worker-01, worker-02, hoặc worker-03

**Ví dụ DNS record:**

```
Type: A
Name: ckan.idist.dev
Value: 172.29.106.20
```

**Hoặc nếu có Load Balancer:**

Tạo Load Balancer trỏ tới các worker nodes port 30443 (HTTPS) và 30080 (HTTP).

### Bước 5: Kiểm Tra SSL Certificate

Let's Encrypt sẽ tự động issue certificate khi:
1. DNS đã trỏ đúng
2. Ingress đã deploy
3. Domain accessible từ internet (cho HTTP-01 challenge)

**Kiểm tra certificate:**

```powershell
# Xem certificate status
kubectl get certificate -n ckan

# Chi tiết certificate
kubectl describe certificate ckan-tls-secret -n ckan

# Xem cert-manager logs
kubectl logs -n ingress-nginx -l app=cert-manager
```

**Certificate states:**
- `Pending`: Đang request certificate
- `Ready`: Certificate đã issue thành công
- `Failed`: Có lỗi (check describe để xem chi tiết)

### Bước 6: Truy Cập CKAN

Sau khi certificate ready:

```
https://ckan.idist.dev
```

**Nếu certificate chưa ready, có thể truy cập qua HTTP:**

```
http://ckan.idist.dev:30080
```

Hoặc truy cập trực tiếp qua NodePort:

```
https://<worker-ip>:30443
```

## Troubleshooting

### 1. CKAN Pods không start

```powershell
# Xem logs
kubectl logs -f deployment/ckan -n ckan

# Xem events
kubectl describe pod <pod-name> -n ckan
```

**Lỗi thường gặp:**
- `ImagePullBackOff`: Image chưa load vào worker node
- `CrashLoopBackOff`: Database chưa ready hoặc config sai

### 2. Certificate không issue

```powershell
# Xem certificate status
kubectl describe certificate ckan-tls-secret -n ckan

# Xem challenge
kubectl get challenges -n ckan

# Xem cert-manager logs
kubectl logs -n ingress-nginx -l app=cert-manager -f
```

**Nguyên nhân thường gặp:**
- DNS chưa trỏ đúng
- Port 80 không accessible từ internet
- Rate limit của Let's Encrypt (dùng staging issuer để test)

### 3. Không truy cập được domain

```powershell
# Kiểm tra ingress
kubectl get ingress -n ckan
kubectl describe ingress ckan-ingress -n ckan

# Kiểm tra service
kubectl get svc -n ckan

# Test từ trong cluster
kubectl run -it --rm debug --image=curlimages/curl --restart=Never -- curl http://ckan-service.ckan.svc.cluster.local:5000
```

### 4. Database connection errors

```powershell
# Kiểm tra PostgreSQL
kubectl logs -f deployment/postgres -n ckan

# Test connection từ CKAN pod
kubectl exec -it deployment/ckan -n ckan -- pg_isready -h postgres-service -p 5432 -U ckan
```

## Useful Commands

```powershell
# Set kubeconfig
$env:KUBECONFIG = "E:\cdsqg\ckan\sources\ckan\k8s\kubeconfig.yaml"

# Xem tất cả resources
kubectl get all -n ckan

# Xem logs
kubectl logs -f deployment/ckan -n ckan
kubectl logs -f deployment/postgres -n ckan
kubectl logs -f deployment/redis -n ckan
kubectl logs -f deployment/solr -n ckan

# Restart deployment
kubectl rollout restart deployment/ckan -n ckan

# Scale CKAN
kubectl scale deployment/ckan --replicas=3 -n ckan

# Port forward (để test local)
kubectl port-forward svc/ckan-service 5000:5000 -n ckan

# Exec vào pod
kubectl exec -it deployment/ckan -n ckan -- bash

# Xem events
kubectl get events -n ckan --sort-by='.lastTimestamp'

# Delete và redeploy
kubectl delete -f k8s/ckan-deployment.yaml
kubectl apply -f k8s/ckan-deployment.yaml
```

## Configuration Files

- `k8s/namespace.yaml` - Namespace definition
- `k8s/configmap.yaml` - CKAN configuration (domain: ckan.idist.dev)
- `k8s/secrets.yaml` - Sensitive credentials
- `k8s/postgres-deployment.yaml` - PostgreSQL database
- `k8s/redis-deployment.yaml` - Redis cache
- `k8s/solr-deployment.yaml` - Solr search
- `k8s/ckan-deployment.yaml` - CKAN application
- `k8s/ingress.yaml` - Ingress with SSL (ckan.idist.dev)
- `k8s/letsencrypt-issuer.yaml` - Let's Encrypt ClusterIssuer
- `k8s/*-pvc.yaml` - Persistent Volume Claims

## Security Notes

⚠️ **QUAN TRỌNG:**

1. **Đổi passwords trong `k8s/secrets.yaml`** trước khi deploy production:
   - `CKAN_SYSADMIN_PASSWORD`
   - `POSTGRES_PASSWORD`
   - `CKAN___BEAKER__SESSION__SECRET`

2. **Backup database thường xuyên:**
   ```powershell
   kubectl exec deployment/postgres -n ckan -- pg_dump -U ckan ckan_default > backup.sql
   ```

3. **Monitor resources:**
   ```powershell
   kubectl top pods -n ckan
   kubectl top nodes
   ```

## Next Steps

1. ✅ Load CKAN image vào worker nodes
2. ✅ Deploy CKAN application
3. ✅ Deploy Ingress
4. ✅ Cấu hình DNS trỏ ckan.idist.dev
5. ✅ Đợi Let's Encrypt issue certificate
6. ✅ Truy cập https://ckan.idist.dev
7. ⚠️ Tạo sysadmin user đầu tiên
8. ⚠️ Configure CKAN settings
9. ⚠️ Setup backup strategy

## Support

Nếu gặp vấn đề, check:
1. Pod logs: `kubectl logs -f deployment/ckan -n ckan`
2. Events: `kubectl get events -n ckan`
3. Certificate: `kubectl describe certificate -n ckan`
4. Ingress: `kubectl describe ingress -n ckan`

