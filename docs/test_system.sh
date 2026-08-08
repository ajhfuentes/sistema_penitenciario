#!/bin/bash

echo "=========================================="
echo "VERIFICANDO SISTEMA SGP"
echo "=========================================="

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 1. Probar backend
echo -e "\n${YELLOW}1. Probando backend...${NC}"
if curl -s http://localhost:8000/api/test > /dev/null; then
    echo -e "${GREEN}✅ Backend OK${NC}"
else
    echo -e "${RED}❌ Backend no responde. ¿Está corriendo?${NC}"
    exit 1
fi

# 2. Login
echo -e "\n${YELLOW}2. Probando login...${NC}"
TOKEN=$(curl -s -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@sgp.com","password":"admin123"}' \
  | jq -r '.access_token')

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
    echo -e "${RED}❌ Fallo login${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Token obtenido${NC}"

# 3. Obtener estadísticas
echo -e "\n${YELLOW}3. Estadísticas...${NC}"
curl -s -X GET http://localhost:8000/api/dashboard/stats \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" | jq '.'

# 4. Listar reclusos (solo conteo)
echo -e "\n${YELLOW}4. Total reclusos...${NC}"
TOTAL=$(curl -s -X GET http://localhost:8000/api/reclusos \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json" | jq -r '.total // (.data | length)')
echo -e "Total: $TOTAL"

echo -e "\n${GREEN}✅ Verificación completada${NC}"
