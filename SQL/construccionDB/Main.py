import psycopg2
import faker as fk
import random as rm

productsTechName = ["Laptop", "Smartphone", "Tablet", 
                    "Smartwatch", "Headphones", "Keyboard", 
                    "Mouse", "Monitor", "Printer", "Router", 
                    "Webcam", "Microphone", "Speaker", "Gamepad", 
                    "Console", "Charger", "Battery", "Cable", 
                    "Adapter", "Dock", "Case", "Cooler", "Fan", 
                    "Heatsink", "Thermal Paste", "Memory", "Storage", 
                    "Processor", "Graphics Card", "Motherboard", 
                    "Power Supply"]

def fakeProducts():
    fake = fk.Faker()
    products = []
    for i in range(100):
        product = {
            "product_name": fake.word() + " " + rm.choice(productsTechName),
            "price": rm.randint(100, 1000),
            "stock_quantity": rm.randint(0, 100)
        }
        products.append(product)
    return products

def fakeCustomers():
    fake = fk.Faker()
    customers = []
    for i in range(100):
        customer = {
            "first_name": fake.first_name().split(" ")[0],
            "last_name": fake.last_name(),
            "email": fake.email(),
            "phone": fake.phone_number()
        }
        customers.append(customer)
    return customers

def fakeOrders():
    fake = fk.Faker()
    orders = []
    for i in range(100):
        order = {
            "customer_id": rm.randint(1, 100),
            "order_date": fake.date_time_this_year()
        }
        orders.append(order)
    return orders

def fakeOrderItem():
    fake = fk.Faker()
    orderItems = []
    for i in range(100):
        orderItem = {
            "order_id": rm.randint(1, 100),
            "product_id": rm.randint(1, 100),
            "quantity": rm.randint(1, 10) 
        }
        orderItems.append(orderItem)
    return orderItems

def insertProducts():
    conn = connect()
    cursor = conn.cursor()
    products = fakeProducts()
    for product in products:
        cursor.execute("INSERT INTO products (product_name, price, stock_quantity) VALUES (%s, %s, %s)", 
                        (product["product_name"], product["price"], product["stock_quantity"]))
    conn.commit()
    conn.close()

def insertCustomers():
    conn = connect()
    cursor = conn.cursor()
    customers = fakeCustomers()
    for customer in customers:
        cursor.execute("INSERT INTO customers (first_name, last_name, email, phone) VALUES (%s, %s, %s, %s)", 
                        (customer["first_name"], customer["last_name"], customer["email"], customer["phone"]))
    conn.commit()
    conn.close()


def insertOrders():
    conn = connect()
    cursor = conn.cursor()
    orders = fakeOrders()
    for order in orders:
        cursor.execute("INSERT INTO orders (customer_id, order_date) VALUES (%s, %s)", 
                        (order["customer_id"], order["order_date"]))
    conn.commit()
    conn.close()

def insertOrderItem():
    conn = connect()
    cursor = conn.cursor()
    orderItems = fakeOrderItem()
    for orderItem in orderItems:
        cursor.execute("INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (%s, %s, %s)", 
                        (orderItem["order_id"], orderItem["product_id"], orderItem["quantity"]))
    conn.commit()
    conn.close()

def connect():
    return psycopg2.connect(
        host="localhost",
        database="ejerciciopactico",
        user="postgres",
        password="040902"
    )

def main():
    insertProducts()
    insertCustomers()
    insertOrders()
    insertOrderItem()

if __name__ == "__main__":
    main()