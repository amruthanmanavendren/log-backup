from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Employee
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt



def home(request):
    return render(request, 'index.html')

@api_view(['GET'])
def get_employees(request):
    employees = Employee.objects.all().values()
    return Response(list(employees))


@csrf_exempt
@api_view(['POST'])
def add_employee(request):
    name = request.data.get('name')
    role = request.data.get('role')

    Employee.objects.create(name=name, role=role)
    return Response({"message": "Employee added"})