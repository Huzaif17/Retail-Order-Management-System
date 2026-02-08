# Retail-Order-Management-System
# 🏬 Retail Order Management System (SQL Server)

## 📖 Project Overview
This project is a **Retail Order Management System** built using **SQL Server**. It demonstrates database design, data integrity, business logic implementation, reporting, and performance optimization using **views, stored procedures, transactions, and indexes**.

---

## 🛠️ Technologies Used
- **SQL Server**
- **SQL Server Management Studio (SSMS)**
- **T-SQL**

---

## 🗂️ Database Modules
- **Customers**
- **Products**
- **Orders**
- **Order_Details**
- **Payments**

---

## ⚙️ Key Features
- Normalized tables with constraints and relationships  
- Views for reporting (`Sales_Summary`)  
- Stored Procedures for business logic (`PlaceOrder`, `GetCustomerOrders`, `MakePayment`)  
- Transactions and error handling (TRY…CATCH)  
- Indexes for query optimization  
- Batch execution using `GO`

---

## 🔹 Sample SQL Objects

**View: Sales Summary**
```sql
SELECT * FROM dbo.Sales_Summary;
