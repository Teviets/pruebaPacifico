class Customer:
    def __init__(self, id, firstName,lastName, email, phone):
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone

    def __repr__(self):
        return f'<Customer {self.id}: {self.name}>'
    
    def to_dict(self):
        return {
            'id': self.id,
            'firstName': self.firstName,
            'lastName': self.lastName,
            'email': self.email,
            'phone': self.phone
        }
    
    def __str__(self) -> str:
        return f'Customer {self.id}: {self.firstName} {self.lastName}  \n\tEmail: {self.email}  \n\tPhone: {self.phone}'