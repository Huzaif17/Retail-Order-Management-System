

CREATE DATABASE RetailDB;
GO

USE RetailDB;
GO

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) CHECK (price > 0),
    stock INT CHECK (stock >= 0)
);
GO

CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    status VARCHAR(20),
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    CONSTRAINT fk_od_orders
        FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT fk_od_products
        FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    payment_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_payments_orders
        FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

INSERT INTO Customers (name, email, phone, city)
VALUES
('Amit Sharma', 'amit@gmail.com', '9876543210', 'Delhi'),
('Neha Verma', 'neha@gmail.com', '9123456789', 'Mumbai');

INSERT INTO Products (product_name, category, price, stock)
VALUES
('Laptop', 'Electronics', 55000, 10),
('Headphones', 'Electronics', 2000, 50);
GO



CREATE VIEW dbo.Sales_Summary
AS
SELECT
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.status
FROM Orders o
JOIN Customers c
    ON o.customer_id = c.customer_id;
GO


CREATE PROCEDURE dbo.PlaceOrder
    @customer_id INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Orders (customer_id, status)
    VALUES (@customer_id, 'PLACED');
END;
GO


CREATE PROCEDURE dbo.GetCustomerOrders
    @cust_id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Orders
    WHERE customer_id = @cust_id;
END;
GO


CREATE PROCEDURE dbo.MakePayment
    @order_id INT,
    @method VARCHAR(30)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Payments (order_id, payment_method, payment_status)
        VALUES (@order_id, @method, 'SUCCESS');

        UPDATE Orders
        SET status = 'PAID'
        WHERE order_id = @order_id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

CREATE INDEX idx_orders_customer
ON Orders(customer_id);

CREATE INDEX idx_products_category
ON Products(category);
GO

EXEC dbo.PlaceOrder @customer_id = 1;
GO

EXEC dbo.GetCustomerOrders @cust_id = 1;
GO

SELECT * FROM dbo.Sales_Summary;
GO










