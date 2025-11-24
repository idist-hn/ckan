# CKAN Deployment Script for Kubernetes
# This script deploys CKAN to the K8s cluster

$ErrorActionPreference = "Stop"

# Set kubeconfig
$env:KUBECONFIG = "E:\cdsqg\ckan\sources\ckan\k8s\kubeconfig.yaml"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "CKAN Kubernetes Deployment Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check cluster connection
Write-Host "[1/6] Checking cluster connection..." -ForegroundColor Yellow
try {
    kubectl get nodes | Out-Null
    Write-Host "✓ Cluster connection OK" -ForegroundColor Green
} catch {
    Write-Host "✗ Cannot connect to cluster" -ForegroundColor Red
    exit 1
}

# Check if infrastructure is running
Write-Host ""
Write-Host "[2/6] Checking infrastructure pods..." -ForegroundColor Yellow
$pods = kubectl get pods -n ckan -o json | ConvertFrom-Json
$runningPods = ($pods.items | Where-Object { $_.status.phase -eq "Running" }).Count
Write-Host "✓ Running pods: $runningPods" -ForegroundColor Green

# Deploy CKAN PVC
Write-Host ""
Write-Host "[3/6] Creating CKAN storage PVC..." -ForegroundColor Yellow
kubectl apply -f k8s/ckan-pvc.yaml
Write-Host "✓ PVC created" -ForegroundColor Green

# Wait for user to load image
Write-Host ""
Write-Host "[4/6] Image preparation required" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "IMPORTANT: You need to load the CKAN image to worker nodes" -ForegroundColor Red
Write-Host ""
Write-Host "Option 1: Load from tar file (if you have SSH access)" -ForegroundColor White
Write-Host "  1. Copy ckan-image.tar to each worker node:" -ForegroundColor Gray
Write-Host "     scp ckan-image.tar user@worker-01:/tmp/" -ForegroundColor Gray
Write-Host "     scp ckan-image.tar user@worker-02:/tmp/" -ForegroundColor Gray
Write-Host "     scp ckan-image.tar user@worker-03:/tmp/" -ForegroundColor Gray
Write-Host ""
Write-Host "  2. SSH to each worker and load image:" -ForegroundColor Gray
Write-Host "     ssh user@worker-01" -ForegroundColor Gray
Write-Host "     docker load -i /tmp/ckan-image.tar" -ForegroundColor Gray
Write-Host ""
Write-Host "Option 2: Push to registry (if registry is fixed)" -ForegroundColor White
Write-Host "  docker push registry.idist.dev/ckan:latest" -ForegroundColor Gray
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
$continue = Read-Host "Have you loaded the image to all worker nodes? (yes/no)"

if ($continue -ne "yes") {
    Write-Host "Deployment cancelled. Please load the image first." -ForegroundColor Yellow
    exit 0
}

# Deploy CKAN
Write-Host ""
Write-Host "[5/6] Deploying CKAN application..." -ForegroundColor Yellow
kubectl apply -f k8s/ckan-deployment.yaml
Write-Host "✓ CKAN deployment created" -ForegroundColor Green

# Wait for CKAN pods
Write-Host ""
Write-Host "Waiting for CKAN pods to be ready (this may take a few minutes)..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=ckan -n ckan --timeout=300s

# Deploy Ingress
Write-Host ""
Write-Host "[6/6] Deploying Ingress with SSL..." -ForegroundColor Yellow
kubectl apply -f k8s/ingress.yaml
Write-Host "✓ Ingress created" -ForegroundColor Green

# Show status
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deployment Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Pods:" -ForegroundColor White
kubectl get pods -n ckan

Write-Host ""
Write-Host "Services:" -ForegroundColor White
kubectl get svc -n ckan

Write-Host ""
Write-Host "Ingress:" -ForegroundColor White
kubectl get ingress -n ckan

Write-Host ""
Write-Host "Certificate:" -ForegroundColor White
kubectl get certificate -n ckan

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Point DNS ckan.idist.dev to your Ingress IP" -ForegroundColor White
Write-Host "2. Wait for Let's Encrypt certificate (check with: kubectl describe certificate -n ckan)" -ForegroundColor White
Write-Host "3. Access CKAN at: https://ckan.idist.dev" -ForegroundColor White
Write-Host ""
Write-Host "To view logs:" -ForegroundColor White
Write-Host "  kubectl logs -f deployment/ckan -n ckan" -ForegroundColor Gray
Write-Host ""
Write-Host "To check certificate status:" -ForegroundColor White
Write-Host "  kubectl describe certificate ckan-tls-secret -n ckan" -ForegroundColor Gray
Write-Host ""

