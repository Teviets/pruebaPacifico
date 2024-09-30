DROP TABLE OrderItems;
DROP TABLE Orders;
DROP TABLE Customers;
DROP TABLE Products;

-- PRIMERA PARTE
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(25)
);


CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock_quantity DECIMAL(10,2)
);


CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems(
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) on DELETE CASCADE
);

-- Trigger calculate subtotal
CREATE OR REPLACE FUNCTION calculate_subtotal() RETURNS TRIGGER AS $$
BEGIN
    NEW.subtotal = (SELECT price FROM Products WHERE product_id = NEW.product_id) * NEW.quantity;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calculate_subtotal_trigger
BEFORE INSERT ON OrderItems
FOR EACH ROW
EXECUTE FUNCTION calculate_subtotal();

-- Trigger update stock
CREATE OR REPLACE FUNCTION update_stock() RETURNS TRIGGER AS $$
BEGIN
    UPDATE Products SET stock_quantity = stock_quantity - NEW.quantity WHERE product_id = NEW.product_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stock_trigger
BEFORE INSERT ON OrderItems
FOR EACH ROW
EXECUTE FUNCTION update_stock();


-- SEGUNDA PARTE
-- Ejercicio 1
SELECT * FROM Products WHERE product_name like 'Laptop';
INSERT INTO Products (product_name, price, stock_quantity) VALUES ('Laptop', 1000.00, 50);
SELECT * FROM Products WHERE product_name like 'Laptop';

-- Ejercicio 2
SELECT * FROM Products where product_id = 3;
UPDATE products SET stock_quantity = 75 WHERE product_id = 3;
SELECT * FROM Products where product_id = 3;

-- Ejercicio 3
SELECT * FROM Orders JOIN OrderItems ON Orders.order_id = OrderItems.order_id WHERE Orders.order_id = 10;
DELETE FROM orders WHERE order_id = 10;
SELECT * FROM Orders JOIN OrderItems ON Orders.order_id = OrderItems.order_id WHERE Orders.order_id = 10;

-- Ejercicio 4
SELECT c.first_name, c.last_name FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id WHERE o.order_id = 5;

-- Ejercicio 5
SELECT p.product_name, SUM(oi.subtotal) as total FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_name ORDER BY total DESc;


-- TERCERA PARTE
CREATE OR REPLACE FUNCTION total_revenue(customer_idP INT) RETURNS DECIMAL(10,2) AS $$
DECLARE
    total DECIMAL(10,2);
BEGIN
    SELECT SUM(subtotal) INTO total FROM OrderItems oi
    JOIN Orders o ON oi.order_id = o.order_id
    WHERE o.customer_id = customer_idP;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

SELECT total_revenue(1);

