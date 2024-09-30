import faker as fk
import random

prods = []
cart = []
orders = []
prodsTechName = ["Laptop", "Mouse", "Keyboard", "Monitor", "Headset", "Webcam", "Microphone", "Tablet", "Smartphone", "Smartwatch"]

def createProd():
    prod = {
        'product_id': fk.Faker().random_number(),
        'product_name': prodsTechName[fk.Faker().random_int(min=0, max=9)],
        'price': fk.Faker().random_number()
    }
    prods.append(prod)

def randomCart():
    print("prodslen", len(prods))
    for i in range(5):
        il = random.randint(1, 9)
        cart.append({
            'product_id': prods[il]['product_id'],
            'quantity': random.randint(1, 10),
            'discount_percentage': random.randint(1, 50)/100
        })

def randomOrder():
    print("prodslen", len(prods))
    for i in range(15):
        il = random.randint(1, 9)
        orders.append({
            'product_id': prods[il]['product_id'],
            'quantity': random.randint(1, 10)
        })

# Ejercicio 1
def searchByName(name):
    return list(filter(lambda x:name in x['product_name'], prods))

# Ejericio 2
def calculateTotal():
    total = 0
    for item in cart:
        product = next((prod for prod in prods if prod['product_id'] == item['product_id']), None)
        if product:
            total += product['price'] * item['quantity']
    return total

# Ejercicio 3
def calculateTotalAfterDiscount():
    total = 0
    for item in cart:
        product = next((prod for prod in prods if prod['product_id'] == item['product_id']), None)
        if product:
            total += product['price'] * item['quantity'] * (1 - item['discount_percentage'])
    return total

# Ejercicio 4
def getTopNProductsSold(n):
    sales_count = {}
    
    for order in orders:
        product_id = order['product_id']
        quantity = order['quantity']
        if product_id in sales_count:
            sales_count[product_id] += quantity
        else:
            sales_count[product_id] = quantity
            
    products_with_sales = []
    for product_id, quantity in sales_count.items():
        product = next((prod for prod in prods if prod['product_id'] == product_id), None)
        if product:
            products_with_sales.append({
                'product_id': product_id,
                'quantity': quantity
            })
    
    return sorted(products_with_sales, key=lambda x: x['quantity'], reverse=True)[:n]

def printAllProds():
    for prod in prods:
        print(f"""\nID: {prod['product_id']}; nombre: {prod['product_name']}; precio: {prod['price']}""")

def printProds(products):
    for prod in products:
        print(f"""\nID: {prod['product_id']}; nombre: {prod['product_name']}; precio: {prod['price']}""")

def printCart():
    count = 1
    for prod in cart:
        print(f"""\n{count}ID: {prod['product_id']}; cantidad: {prod['quantity']}; descuento: {prod['discount_percentage']}""")
        count += 1

def printAllOrders():
    for prod in orders:
        print(f"""\nID: {prod['product_id']}; cantidad: {prod['quantity']}""")

def printOrders(ordersInput):
    count = 1
    for prod in ordersInput:
        print(f"""\n{count}. ID: {prod['product_id']}; cantidad: {prod['quantity']}""")

def main():
    print("----------------------Task 1----------------------")
    for i in range(10):
        createProd()
    printAllProds()
    print()
    printProds(searchByName(input('Ingrese el nombre del producto a buscar: ')))

    print()

    print('----------------------Task 2----------------------')
    randomCart()
    printCart()
    print()
    print(f'Total: {calculateTotal()}')

    print()
    print('----------------------Task 3----------------------')
    print(f'Total con descuento: {calculateTotalAfterDiscount()}')


    print()
    print('----------------------Task 4----------------------')
    randomOrder()
    printAllOrders()
    printOrders(getTopNProductsSold(int(input('Ingrese el número de productos a mostrar: '))))


if __name__ == '__main__':
    main()