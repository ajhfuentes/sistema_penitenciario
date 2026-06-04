# Sistema de Gestión Penitenciaria (SGP)

Este proyecto automatiza la logística, seguridad e ingreso de datos en un recinto penal, centralizando las operaciones alrededor del ciclo de vida del expediente del recluso.

## 🚀 Características y Módulos

* **Módulo de Admisión:** Verificación legal de órdenes judiciales, registro biométrico y clasificación de perfiles de riesgo.
* **Control de Ubicación:** Asignación automatizada de celdas según el nivel de peligrosidad y control de aforo para evitar hacinamiento.
* **Seguridad y Visitas:** Registro de ciudadanos, control de parentesco en cartillas de visita y control de accesos con marcas de tiempo.
* **Gestión de Personal:** Control de accesos basado en roles (RBAC) y asignación de turnos de guardia por pabellones.

## 🛠️ Tecnologías Utilizadas

* **Base de Datos:** PostgreSQL (o el motor que uses)
* **Lenguaje/Framework:** [Ej. Node.js / Java / Python - Completa aquí]
* **Modelado:** Diagramas Entidad-Relación y Casos de Uso (UML)

## 🗄️ Estructura de la Base de Datos

El diseño de la base de datos se divide en tres niveles que garantizan la integridad de los datos:

1.  **Modelo Lógico:** Definición formal de tablas, llaves primarias (`PK`), llaves foráneas (`FK`) y restricciones de unicidad.
2.  **Modelo Físico:** Implementación de tipos de datos específicos, cláusulas `CHECK` para validar estados (ej. niveles de riesgo 'Alto', 'Medio', 'Bajo') e índices de optimización.
3.  **Script SQL:** Archivo ejecutable para levantar el esquema completo en limpio.

## ⚙️ Instrucciones de Instalación y Despliegue

Sigue estos pasos para ejecutar el script de la base de datos de manera local:

1. Clona este repositorio:
   ```bash
   git clone [https://github.com/tu-usuario/sistema-penitenciario.git](https://github.com/tu-usuario/sistema-penitenciario.git)
