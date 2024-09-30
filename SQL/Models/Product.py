
class Product:
    def __init__(self, id, name, price, quantity):
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity

    def __repr__(self):
        return f'<Product {self.id}: {self.name}>'

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'price': self.price,
            'quantity': self.quantity
        }
    
    def __str__(self) -> str:
        return f'Product {self.id}: {self.name}  \n\tPrice: {self.price}  \n\tQuantity: {self.quantity}'