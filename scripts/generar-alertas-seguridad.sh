#!/bin/bash
set -euo pipefail

POD_BACKEND=$(kubectl get pods -n devops-portfolio -l app=backend -o jsonpath='{.items[0].metadata.name}')

echo "=========================================================="
echo "  SIMULACIÓN DE ATAQUE / TRÁFICO ANÓMALO (TP12C)"
echo "=========================================================="
echo "Objetivo: Pod $POD_BACKEND / Contenedor: backend"
echo ""

echo "[1/2] Generando escaneo de rutas inexistentes (errores HTTP 404)..."
for i in $(seq 1 50); do
  kubectl exec -n devops-portfolio "$POD_BACKEND" -c backend -- python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/admin-admin-$i')" 2>/dev/null || true
done
echo "-> 50 peticiones enviadas."

echo ""
echo "[2/2] Simulando fuerza bruta de login (errores HTTP 401/404)..."
for i in $(seq 1 30); do
  kubectl exec -n devops-portfolio "$POD_BACKEND" -c backend -- python3 -c "import urllib.request; req = urllib.request.Request('http://localhost:5000/login', data=b'{\"user\":\"admin\",\"pass\":\"wrong\"}', headers={'Content-Type': 'application/json'}); urllib.request.urlopen(req)" 2>/dev/null || true
done
echo "-> 30 peticiones de autenticación fallida enviadas."

echo ""
echo "=== Simulación completada con éxito ==="
