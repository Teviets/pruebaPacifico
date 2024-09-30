# Sistema de Gestión de Productos - Python

### Programas de Sebastian Estrada

## Descripción

Este proyecto es un sistema básico de gestión de productos, que incluye un carrito de compras y un sistema de órdenes. El programa simula la creación de productos tecnológicos utilizando la biblioteca `Faker` para generar datos aleatorios. Además, permite realizar búsquedas por nombre de producto, calcular el total de un carrito de compras con y sin descuento, y obtener los productos más vendidos basados en las órdenes generadas aleatoriamente.

## Funcionalidades

1. **Crear productos**: Se crean 10 productos tecnológicos con nombres predefinidos y precios generados aleatoriamente.
2. **Buscar productos por nombre**: Filtra los productos según una palabra clave en el nombre del producto.
3. **Calcular el total del carrito**: Calcula el costo total de los productos en el carrito.
4. **Calcular el total con descuentos**: Aplica descuentos a los productos en el carrito y calcula el total con descuento.
5. **Obtener productos más vendidos**: Muestra los productos más vendidos basados en las órdenes generadas.

## Requisitos

### 1. **Bibliotecas de Python necesarias**

Este programa utiliza la biblioteca `Faker` para generar datos aleatorios como nombres y precios de productos. Asegúrate de instalarla antes de ejecutar el programa:

```bash
pip install faker
```

### Ejemplo de salida

```bash
----------------------Task 1----------------------
ID: 10234; nombre: Laptop; precio: 90342
ID: 87563; nombre: Monitor; precio: 52345
...

Ingrese el nombre del producto a buscar: Laptop
ID: 10234; nombre: Laptop; precio: 90342

----------------------Task 2----------------------
1. ID: 10234; cantidad: 3; descuento: 0.2
...

Total: 235432

----------------------Task 3----------------------
Total con descuento: 188345

----------------------Task 4----------------------
Ingrese el número de productos a mostrar: 3
1. ID: 10234; cantidad: 15
...
```