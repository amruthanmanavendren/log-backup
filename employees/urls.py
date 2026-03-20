from django.urls import path
from . import views

urlpatterns = [
    path('employees/', views.get_employees),
    path('add/', views.add_employee),
    path('', views.home),
]
