
class Order():
    def __init__(self, order_item_id, order_id, customer_id, order_date, order_items = None):
        self.order_id = order_id
        self.customer_id = customer_id
        self.order_date = order_date
        self.order_items = order_items
        self.order_total = self.calculate_total()
        self.order_item_id = order_item_id

    def calculate_total(self):
        total = 0
        if self.order_items == None:
            return total
        for item in self.order_items:
            total += item.subtotal
        return total

    def add_order_item(self, order_item):
        if self.order_items == None:
            self.order_items = []
        self.order_items.append(order_item)
        self.order_total = self.calculate_total()

    def __repr__(self):
        return f"Order({self.order_id}, {self.customer_id}, {self.order_date}, {self.order_total})"

    def __str__(self):
        return f"Order ID: {self.order_id}, Customer ID: {self.customer_id}, Order Date: {self.order_date}, Order Total: {self.order_total}"
    

class OrderItem():
    def __init__(self, product_id, quantity, subtotal):
        self.product_id = product_id
        self.quantity = quantity
        self.subtotal = subtotal

    def __repr__(self):
        return f"OrderItem({self.product_id}, {self.quantity}, {self.subtotal})"
    
    def __str__(self):
        return f"Product ID: {self.product_id} \n\tQuantity: {self.quantity} \tSubtotal: {self.subtotal}"
    