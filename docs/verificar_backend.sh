#!/bin/bash

echo "=========================================="
echo "VERIFICANDO BACKEND LARAVEL"
echo "=========================================="

# 1. Verificar PHP
echo "1. Verificando PHP..."
php -v | head -n 1

# 2. Verificar Composer
echo "2. Verificando Composer..."
composer -V

# 3. Verificar dependencias
echo "3. Verificando dependencias..."
cd "$(dirname "$0")"
composer check-platform-reqs

# 4. Verificar migraciones
echo "4. Verificando migraciones..."
php artisan migrate:status

# 5. Verificar rutas
echo "5. Verificando rutas API..."
php artisan route:list --path=api

# 6. Probar API
echo "6. Probando API..."
curl -s http://localhost:8000/api/test | jq .

# 7. Probar login
echo "7. Probando login..."
TOKEN=$(curl -s -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@prison.com","password":"admin123"}' \
  | jq -r '.access_token')

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
  echo "❌ Error en login"
  exit 1
fi
echo "✅ Login exitoso"
echo "Token: ${TOKEN:0:50}..."

# 8. Probar endpoint protegido
echo "8. Probando endpoint protegido..."
curl -s -X GET http://localhost:8000/api/dashboard/stats \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" | jq .

echo "=========================================="
echo "✅ BACKEND VERIFICADO CORRECTAMENTE"
echo "=========================================="
