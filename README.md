# Prueba SQL

### Programas de Sebastián Estrada

## Descripción

Este proyecto consiste en la implementación de un programa en Python que interactúa con una base de datos PostgreSQL. Para conectarse a la base de datos, se utilizan las bibliotecas `psycopg2` para la conexión y manipulación de datos, y `Faker` para la generación de datos falsos para pruebas.

## Requisitos

### 1. PostgreSQL
Asegúrate de tener instalado PostgreSQL y que esté ejecutándose en tu máquina local.

### 2. Bibliotecas de Python
Instala las siguientes bibliotecas antes de ejecutar el programa:

- `psycopg2`: Permite conectar y manipular la base de datos PostgreSQL desde Python.
- `Faker`: Se utiliza para generar datos ficticios.

Para instalarlas, puedes usar pip ejecutando el siguiente comando en tu terminal:

```bash
pip install psycopg2 faker
```

### Configuración de la base de datos

Antes de ejecutar el programa, asegúrate de que la base de datos PostgreSQL esté configurada correctamente en tu entorno local. A continuación, asegúrate de ajustar las credenciales de la base de datos en el archivo Implementacion.py para que coincidan con las tuyas:

```python
import psycopg2
from faker import Faker

# Conectar a la base de datos
conn = psycopg2.connect(
    host="localhost",
    database="nombre_de_tu_base_de_datos",
    user="tu_usuario",
    password="tu_contraseña"
)
```

### Consideraciones Adicionales

Verifica que PostgreSQL esté funcionando en localhost y que el puerto predeterminado (5432) esté disponible.
Asegúrate de que las tablas necesarias ya existan en la base de datos o modifique el código para que cree las tablas antes de insertar los datos.
El archivo `TestSQL.sql` es en donde se encuentran los CRUD para crear la base de datos desde 0 y en `SQL/construccionDB/Main.py` se generan los datos random para llenar la base de datos. En el archivo `ejercicioSQL.sql` es el backup de la base de datos en postgres que utilice al realizar las pruebas.
