#!/bin/bash
set -euo pipefail

POD_BACKEND=$(kubectl get pods -n devops-portfolio -l app=backend -o jsonpath='{.items[0].metadata.name}')

echo "=========================================================="
echo "  SIMULACIÓN DE ATAQUE / TRÁFICO ANÓMALO (TP12C)"
echo "=========================================================="
echo "Objetivo: Pod $POD_BACKEND (backend)"
echo ""

echo "[1/2] Generando escaneo de rutas inexistentes (errores 404)..."
kubectl exec -n devops-portfolio "$POD_BACKEND" -c backend -- python3 -c "
import urllib.request
for i in range(1, 51):
    try: urllib.request.urlopen(f'http://localhost:5000/admin-admin-{i}')
    except Exception: pass
"
echo "-> 50 peticiones enviadas."

echo ""
echo "[2/2] Simulando fuerza bruta de login y ráfaga sostenida para activar alertas..."
kubectl exec -n devops-portfolio "$POD_BACKEND" -c backend -- python3 -c "
import urllib.request, time
start = time.time()
while time.time() - start < 15:
    try:
        req = urllib.request.Request('http://localhost:5000/login', data=b'{\"user\":\"admin\",\"pass\":\"wrong\"}', headers={'Content-Type': 'application/json'})
        urllib.request.urlopen(req)
    except Exception: pass
"
echo "-> Ráfaga de autenticación fallida enviada con éxito."
echo ""
echo "=== Simulación completada ==="
