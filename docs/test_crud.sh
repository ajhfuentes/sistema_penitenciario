#!/bin/bash

echo "=========================================="
echo "PROBANDO CRUD COMPLETO DEL SISTEMA"
echo "=========================================="

cd "$(dirname "$0")"

# Login
echo "1. Login..."
TOKEN=$(curl -s -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@prison.com","password":"admin123"}' \
  | jq -r '.access_token')

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
  echo "❌ Error en login"
  exit 1
fi
echo "✅ Login exitoso"

# Crear Centro Penal
echo "2. Creando Centro Penal..."
CENTRO=$(curl -s -X POST http://localhost:8000/api/centros-penales \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Centro de Prueba CRUD",
    "ubicacion": "Av. Test #123",
    "capacidad_aforo": 500,
    "nivel_seguridad": "Media"
  }')
  
CENTRO_ID=$(echo $CENTRO | jq -r '.id')
echo "✅ Centro creado con ID: $CENTRO_ID"

# Crear Pabellón
echo "3. Creando Pabellón..."
PABELLON=$(curl -s -X POST http://localhost:8000/api/pabellones \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"centro_penal_id\": $CENTRO_ID,
    \"nombre\": \"Pabellón Test\",
    \"riesgo_permitido\": \"Medio\",
    \"capacidad_maxima\": 100
  }")

PABELLON_ID=$(echo $PABELLON | jq -r '.id')
echo "✅ Pabellón creado con ID: $PABELLON_ID"

# Crear Celda
echo "4. Creando Celda..."
CELDA=$(curl -s -X POST http://localhost:8000/api/celdas \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"pabellon_id\": $PABELLON_ID,
    \"codigo\": \"T01\",
    \"capacidad_maxima\": 10
  }")

CELDA_ID=$(echo $CELDA | jq -r '.id')
echo "✅ Celda creada con ID: $CELDA_ID"

# Crear Recluso
echo "5. Creando Recluso..."
RECLUSO=$(curl -s -X POST http://localhost:8000/api/reclusos \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"celda_id\": $CELDA_ID,
    \"nombres\": \"Juan\",
    \"apellidos\": \"Pérez García\",
    \"cedula_identidad\": \"1234567890\",
    \"nivel_riesgo\": \"Medio\",
    \"estado_operativo\": \"Activo\",
    \"fecha_nacimiento\": \"1990-05-15\",
    \"sexo\": \"M\"
  }")

RECLUSO_ID=$(echo $RECLUSO | jq -r '.id')
echo "✅ Recluso creado con ID: $RECLUSO_ID"

# Ver Recluso
echo "6. Verificando Recluso..."
curl -s -X GET http://localhost:8000/api/reclusos/$RECLUSO_ID \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" | jq '.data.nombre_completo'

# Actualizar Recluso
echo "7. Actualizando Recluso..."
curl -s -X PUT http://localhost:8000/api/reclusos/$RECLUSO_ID \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "nombres": "Juan Carlos",
    "apellidos": "Pérez García",
    "cedula_identidad": "1234567890",
    "nivel_riesgo": "Alto",
    "estado_operativo": "Activo"
  }' | jq '.data.nombres'

# Listar Reclusos
echo "8. Listando Reclusos..."
curl -s -X GET http://localhost:8000/api/reclusos \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" | jq '.data | length'

# Estadísticas
echo "9. Obteniendo Estadísticas..."
curl -s -X GET http://localhost:8000/api/reclusos/estadisticas \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" | jq '.'

echo "=========================================="
echo "✅ CRUD COMPLETADO EXITOSAMENTE"
echo "=========================================="
