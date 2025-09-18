#!/bin/bash
# ===========================================
# 🚀 Script para crear backend Django en NEUSI DevOps
# ===========================================

# Nombre del proyecto y app
PROJECT_NAME="backend"
APP_NAME="core"

echo "=== Creando entorno virtual ==="
python3 -m venv .venv
source .venv/bin/activate

echo "=== Instalando dependencias Django ==="
pip install --upgrade pip
pip install django djangorestframework psycopg2-binary

echo "=== Creando carpeta de backend ==="
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

echo "=== Iniciando proyecto Django ==="
django-admin startproject config .
django-admin startapp $APP_NAME

echo "=== Creando archivo requirements.txt ==="
pip freeze > requirements.txt

echo "=== Migrando base de datos inicial ==="
python manage.py migrate

echo "=== Creando superusuario ==="
echo "Usuario admin -> recuerda completar manualmente la contraseña"
python manage.py createsuperuser --username admin --email admin@neusi.dev

echo "=== Backend Django creado con éxito en $PROJECT_NAME ==="
