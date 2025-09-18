from django.contrib import admin
from .models import Proyecto, HistoriaUsuario, Tarea, Acta

admin.site.register(Proyecto)
admin.site.register(HistoriaUsuario)
admin.site.register(Tarea)
admin.site.register(Acta)
