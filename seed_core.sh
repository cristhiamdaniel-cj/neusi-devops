#!/bin/bash
# ===========================================
# 🚀 Script para seedear datos de ejemplo en NEUSI DevOps (Django)
# ===========================================

cd backend || exit 1
source ../.venv/bin/activate

echo "=== Seed: creando datos de ejemplo en la app core ==="

python manage.py shell << 'EOF'
from core.models import Proyecto, HistoriaUsuario, Tarea, Acta

# Limpiar datos anteriores (opcional)
Proyecto.objects.all().delete()
HistoriaUsuario.objects.all().delete()
Tarea.objects.all().delete()
Acta.objects.all().delete()

# Crear proyecto
p = Proyecto.objects.create(
    nombre="FinanzApp",
    descripcion="Proyecto de finanzas personales desarrollado por NEUSI",
    linea_negocio="Software",
    estado="Activo"
)

# Crear historia de usuario
h = HistoriaUsuario.objects.create(
    proyecto=p,
    quien="Como usuario",
    que="quiero registrar mis deudas",
    para_que="para organizarlas mejor",
    prioridad="Alta",
    estado="Pendiente"
)

# Crear tarea
Tarea.objects.create(
    historia=h,
    titulo="Diseñar modelo de base de datos",
    descripcion="Modelo inicial para gestionar deudas",
    estado="Pendiente"
)

# Crear acta de ceremonia
Acta.objects.create(
    tipo="planning",
    acuerdos="Definición de backlog inicial y prioridades para FinanzApp"
)

print("✅ Datos de ejemplo creados exitosamente")
EOF
