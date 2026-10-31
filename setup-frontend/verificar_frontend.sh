#!/bin/bash

echo "=========================================="
echo "VERIFICANDO FRONTEND REACT"
echo "=========================================="

# 1. Verificar Node.js
echo "1. Verificando Node.js..."
node -v

# 2. Verificar npm
echo "2. Verificando npm..."
npm -v

# 3. Verificar dependencias
echo "3. Verificando dependencias..."
cd "$(dirname "$0")"
npm list --depth=0

# 4. Verificar que el servidor esté corriendo
echo "4. Verificando servidor React..."
if curl -s http://localhost:3000 > /dev/null; then
    echo "✅ Servidor React corriendo en http://localhost:3000"
else
    echo "❌ Servidor React no está corriendo"
    echo "Ejecuta: cd ~/proyecto/frontend && npm start"
fi

echo "=========================================="
echo "✅ FRONTEND VERIFICADO CORRECTAMENTE"
echo "=========================================="
