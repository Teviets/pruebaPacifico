import Repo as Rp
import view

products = []
customers = []
orders = []
orderItems = []


def main():
    op = 0
    while op != 4:
        op = view.menu()
        # SI la opcion es 1, listar productos
        if op == 1:
            view.list_products(Rp.buildProducts())
        # SI la opcion es 2, buscar productos por nombre
        elif op == 2:
            view.list_products(Rp.searchProdByName(view.search_product()))
        # SI la opcion es 3, se va a crear una nueva orden
        elif op == 3:
            cop = view.menuCustomer()
            idO = 0
            idC = 0
        
            # si cop es 1, se va a crear un nuevo cliente
            if cop == 1:
                firstName, lastName, email, phone = view.newCustomer()
                idC = Rp.insertCustomer(firstName, lastName, email, phone)
                idO = Rp.insertOrder(idC[0][0])
            # si cop es 2, se va a seleccionar un cliente existente
            elif cop == 2:
                idC = view.selectCustomer(Rp.buildCustomers())
                idO = Rp.insertOrder(idC)
            # de otro modo, continua el ciclo
            else:
                print("Invalid option")
                continue

            orderProd = []
            prodOP = 0
            # mientras que prodOP sea diferente de 4, se va a mostrar el menu de productos
            while prodOP != 4:
                prodOP = view.prodMenu()
                # si prodOP es 1, se va a agregar un producto a la orden
                if prodOP == 1:
                    product_id, quantity = view.newOrderItem()
                    orderProd.append((product_id, quantity))
                    print("Product added")
                # si prodOP es 2, se va a listar los productos
                elif prodOP == 2:
                    view.list_products(products)
                    print("Product listed")
                # si prodOP es 3, se va a buscar un producto por nombre
                elif prodOP == 3:
                    Rp.searchProdByName(view.search_product())
                    print("Product searched")
                elif prodOP == 4:
                    if len(orderProd) == 0:
                        print("Order empty try again")

                    else:
                        print("Order finished")
                else:
                    print("Invalid option")

            
            for product_id, quantity in orderProd:
                Rp.insertOrderItem(idO, product_id, quantity)
        elif op == 4:
            print("Goodbye!")        
        else:
            print("Invalid option")


if __name__ == "__main__":
    main()