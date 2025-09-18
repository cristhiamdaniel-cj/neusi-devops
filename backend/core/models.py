from django.db import models
from django.contrib.auth.models import User

# Proyecto general (ej: FinanzApp, EduTech, etc.)
class Proyecto(models.Model):
    nombre = models.CharField(max_length=200)
    descripcion = models.TextField(blank=True)
    linea_negocio = models.CharField(max_length=100, blank=True)
    estado = models.CharField(max_length=50, default="Activo")

    def __str__(self):
        return self.nombre


# Historia de usuario
class HistoriaUsuario(models.Model):
    proyecto = models.ForeignKey(Proyecto, on_delete=models.CASCADE, related_name="historias")
    quien = models.CharField(max_length=200)  # Ej: "Como administrador"
    que = models.TextField()                  # Ej: "quiero ver..."
    para_que = models.TextField(blank=True)   # Ej: "para..."
    prioridad = models.CharField(max_length=50, default="Pendiente")
    estado = models.CharField(max_length=50, default="Pendiente")

    def __str__(self):
        return f"{self.quien} - {self.que[:30]}"


# Tarea concreta dentro de una historia
class Tarea(models.Model):
    historia = models.ForeignKey(HistoriaUsuario, on_delete=models.CASCADE, related_name="tareas")
    titulo = models.CharField(max_length=200)
    descripcion = models.TextField(blank=True)
    responsable = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    estado = models.CharField(max_length=50, default="Pendiente")
    fecha_limite = models.DateField(null=True, blank=True)

    def __str__(self):
        return self.titulo


# Actas de ceremonias ágiles
class Acta(models.Model):
    CEREMONIAS = [
        ("planning", "Planning"),
        ("daily", "Daily"),
        ("review", "Review"),
        ("retrospectiva", "Retrospectiva"),
    ]
    tipo = models.CharField(max_length=20, choices=CEREMONIAS)
    fecha = models.DateField(auto_now_add=True)
    acuerdos = models.TextField()

    def __str__(self):
        return f"{self.tipo} - {self.fecha}"
