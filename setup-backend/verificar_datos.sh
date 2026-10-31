#!/bin/bash
# Evita las alertas de permisos moviendo la sesión a un directorio neutral
cd /tmp

echo "=== Verificación de datos insertados ==="
echo "Reclusos: $(psql -U postgres -d sgp -t -c 'SELECT COUNT(*) FROM reclusos;')"
echo "Causas penales: $(psql -U postgres -d sgp -t -c 'SELECT COUNT(*) FROM causas_penales;')"
echo "Defensores: $(psql -U postgres -d sgp -t -c 'SELECT COUNT(*) FROM defensores;')"
echo "Personal: $(psql -U postgres -d sgp -t -c 'SELECT COUNT(*) FROM personal;')"
echo "Turnos: $(psql -U postgres -d sgp -t -c 'SELECT COUNT(*) FROM turnos;')"
echo "Redenciones: $(psql -U postgres -d sgp -t -c 'SELECT COUNT(*) FROM redenciones;')"
echo "Boletas: $(psql -U postgres -d sgp -t -c 'SELECT COUNT(*) FROM boletas_excarcelacion;')"
echo "Unificaciones: $(psql -U postgres -d sgp -t -c 'SELECT COUNT(*) FROM unificaciones;')"


