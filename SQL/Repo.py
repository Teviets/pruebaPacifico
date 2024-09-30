import psycopg2
import Models.Customer as Customer
import Models.Order as Order
import Models.Product as Product
import datetime

def connect():
    return psycopg2.connect(
        host="localhost",
        database="ejerciciopactico",
        user="postgres",
        password="040902"
    )

def buildProducts():
    products = []
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM products")
    products = cursor.fetchall()
    conn.close()
    return [Product.Product(*product) for product in products]

def buildCustomers():
    customers = []
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM customers")
    customers = cursor.fetchall()
    conn.close()
    return [Customer.Customer(*customer) for customer in customers]

def getCustomers():
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM customers")
    customers = cursor.fetchall()
    conn.close()
    return customers

def getProducts():
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM products")
    products = cursor.fetchall()
    conn.close()
    return products

def buildOrders():
    orders = []
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM orders")
    orders = cursor.fetchall()
    conn.close()
    return [Order.Order(*order) for order in orders]

def buildOrderItems():
    orderItems = []
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM OrderItems")
    orderItems = cursor.fetchall()
    conn.close()
    print(orderItems)
    return [Order.OrderItem(*orderItem) for orderItem in orderItems]

def getOrders():
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM orders")
    orders = cursor.fetchall()
    conn.close()
    return orders

def getOrderItems():
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM OrderItems")
    orderItems = cursor.fetchall()
    conn.close()
    return orderItems

def asignOrderItems(orders, orderItems):
    for order in orders:
        order.order_items = [orderItem for orderItem in orderItems if orderItem.order_id == order.order_id]
        order.order_total = order.calculate_total()
    return orders

def searchProdByName(name):
    conn = connect()
    cursor = conn.cursor()
    request = f"SELECT * FROM products WHERE product_name like '%{name}%'"
    cursor.execute(request)
    product = cursor.fetchall()
    conn.close()
    print(product)
    return [Product.Product(*product) for product in product]

def insertCustomer(firstName, lastName, email, phone):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO customers (first_name, last_name, email, phone) VALUES (%s, %s, %s, %s) RETURNING customer_id", 
                    (firstName, lastName, email, phone))
    
    id = cursor.fetchall()
    conn.commit()
    conn.close()
    return id

def insertOrder(customer_id):
    print(f"Tipo de customer_id: {type(customer_id)}, Valor: {customer_id}")

    conn = connect()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO orders (customer_id, order_date) VALUES (%s, %s) RETURNING order_id", 
               (customer_id, str(datetime.datetime.now())))
    id = cursor.fetchall()
    conn.commit()
    conn.close()
    return id

def insertOrderItem(order_id, product_id, quantity):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (%s, %s, %s)", 
                    (order_id[0][0], product_id, quantity))
    conn.commit()
    conn.close()
