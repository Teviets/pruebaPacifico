def menu():
    print("""
    1. List of Products\n 
    2. Search for a Product\n
    3. Add an Order\n
    4. Exit\n""")

    return int(input("Select an option: "))

def list_products(products):
    for product in products:
        print(product)

def search_product():
    return input("Enter a product name: ")


def menuCustomer():
    print("""
    1. New Customer\n
    2. List of Customers\n
    """)
    return int(input("Select an option: "))

def prodMenu():
    print("""
    1. Add Product\n
    2. List of Products\n
    3. Search for a Product\n
    4. Finish\n
    """)
    return int(input("Select an option: "))

def selectCustomer(customers):
    for i, customer in enumerate(customers):
        print(f"{i+1}. {customer}")
    return int(input("Select a customer: "))

def newCustomer():
    print("Enter the following information to create a new customer: ")
    firstName = input("First Name: ")
    lastName = input("Last Name: ")
    email = input("Email: ")
    phone = input("Phone: ")
    return (firstName, lastName, email, phone)

def newOrderItem():
    print("Enter the following information to add a new order item: ")
    product_id = input("Product ID: ")
    quantity = input("Quantity: ")
    return (product_id, quantity)
