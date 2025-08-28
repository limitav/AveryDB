-- CREATE DATABASE InventoryDB;

-- Create the Products table
/* CREATE TABLE Products (
	product_id SERIAL NOT NULL PRIMARY KEY,							-- Unique ID for Products
	product_name VARCHAR(255) NOT NULL,								-- Name of the products
	price DECIMAL(10, 2) NOT NULL,									-- Prices of the products
	category VARCHAR(100)											-- Category of the products
); */

-- Create the Suppliers table
/* CREATE TABLE Suppliers (
	supplier_id SERIAL NOT NULL PRIMARY KEY,						-- Unique ID for each supplier (Primary Key)
	supplier_name VARCHAR(255) NOT NULL,							-- Name of supplier
	contact_email VARCHAR(255),										-- Email address of the supplier
	phone_number VARCHAR(15)										-- Contact number of the supplier
); */

-- Create the Inventory table
/* CREATE TABLE Inventory (
	inventory_id SERIAL NOT NULL PRIMARY KEY, 						-- Unique ID for each inventory record (Primary Key)
	product_id INT,													-- Foreign Key (references product_id in Products)
	quantity INT DEFAULT 0,											-- Current stock quantity of the product
	supplier_id INT,												-- Foreign Key (references supplier_id in Suppliers)
	last_updated DATE DEFAULT (CURRENT_DATE),						-- Date when the stock was last updated
	FOREIGN KEY (product_id) REFERENCES Products(product_id),
	FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
); */

-- CREATE TYPE transactions_type AS ENUM('sale','purchase');
-- Create the Transaction table
/* CREATE TABLE Transactions (
	transaction_id SERIAL NOT NULL PRIMARY KEY,
	product_id INT,
	transaction_type transactions_type NOT NULL,
	transaction_date DATE DEFAULT (CURRENT_DATE),
	quantity INT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES Products(product_id)
); */


-- Insert sample procuts into Products table
/* INSERT INTO Products (product_name, price, category) VALUES
('Laptop', 1800.00, 'Electronics'),
('Desk Chair', 200.00, 'Furniture'),
('Notebook', 3.50, 'Stationery'); */


-- Insert sample suppliers into Suppliers table
/* INSERT INTO Suppliers (supplier_name, contact_email, phone_number) VALUES
('Wiz Supplies Co.', 'contact@wizsupplies.com', '12125640987'),
('Assets Furniture Inc.', 'support@assetsfurniture.com', '15156567887'); */

-- Insert initial inventory levels for products
/* INSERT INTO Inventory (product_id, quantity, supplier_id) VALUES
(1, 15, 1), -- Laptop from Wiz Supplies Co.
(2, 30, 2), -- Desk Chair from Assets Furniture Inc.
(3, 150, 2); -- Notebook from Assets Furniture Inc. */
--SELECT * FROM Inventory;

-- Insert sample transactions
/* INSERT INTO Transactions (product_id, transaction_type, quantity) VALUES
(1, 'purchase', 15), -- Purchased 15 laptops
(2, 'purchase', 30), -- Purchased 30 desk chairs
(3, 'purchase', 150); -- Purchased 150 notebooks */
-- Sales transaction: selling 10 laptops
/* INSERT INTO Transactions (product_id, transaction_type, quantity) VALUES
(1, 'sale', 5); */
--  SELECT * FROM Transactions;

-- Select the product name and quantity from the Products and Inventory tables
-- SELECT p.product_name, i.quantity
-- Join the Inventory table with the Products table using the product_id
-- FROM Inventory i
-- JOIN Products p ON i.product_id = p.product_id;

-- Update Stock After a Sale
-- Decrease the quantity of the product with product_id 2 (desks) by 3 units after a sale
/* UPDATE Inventory
SET quantity = quantity - 3
WHERE product_id = 2; */

-- SELECT * FROM Inventory;
-- Update Stock After a Purchase
-- Increase the quantity of the product with product_id 1 (laptops) by 10 units after a purchase
/* UPDATE Inventory
SET quantity = quantity + 10
WHERE product_id = 1; */

-- To view the purchase and sale history for a specific product, use the following query.
-- This query retrieves the transaction history for a specific product with product_id 1 (Laptop).
/* SELECT t.transaction_type, t.quantity, t.transaction_date
FROM Transactions t
JOIN Products p ON t.product_id = p.product_id -- Joining Transactions and Products tables on product_id
WHERE p.product_id = 1; */

-- This query identifies products that have stock levels below a certain threshold, such as 5 units.
-- View products with low stock (e.g., less than 5 units)
/* SELECT p.product_name, i.quantity
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id -- Joining Inventory and Products tables on product_id
WHERE i.quantity < 5; -- Filtering for products with stock levels less than 5 */

-- To generate a report showing the total number of products sold in a given month:
-- Generate a sales report for the current month
/* SELECT p.product_name, SUM(t.quantity) AS total_sold	-- Selecting product name and total quantity sold
FROM Transactions t
JOIN Products p ON t.product_id = p.product_id 			-- Joining Transactions with Products on product_id
WHERE t.transaction_type = 'sale'
AND t.transaction_date BETWEEN '2025-08-01' AND '2025-10-31'
GROUP BY p.product_name; */

-- Insert a new product 'Monitor' into the Products table with category 'Electronics' and price 150.00
/* INSERT INTO Products (product_name, category, price)
VALUES ('Monitor', 'Electronics', 300.00); */

-- Insert an initial stock quantity of 20 for the new product in the Inventory table
-- The product_id is retrieved using a subquery that selects the product_id for 'Monitor' from the Products table
/* INSERT INTO Inventory (product_id, quantity)
VALUES ((SELECT product_id FROM Products WHERE product_name = 'Monitor'), 20); */
-- SELECT * FROM Products;
-- SELECT * FROM Inventory;

-- Delete the product with product_id = 3 from the Inventory table to avoid foreign key conflicts
-- DELETE FROM Inventory WHERE product_id = 3;

-- After removing it from Inventory, delete the product from the Products table
-- DELETE FROM Products WHERE product_id = 3;
-- SELECT * FROM Transactions;

-- Select the product name and price from the Products table
/* SELECT product_name, price
-- Filter results to show only products in the 'Electronics' category
FROM Products
WHERE category = 'Electronics'; */

-- Select the product name, quantity, price, and calculate total value for each product
/* SELECT p.product_name, i.quantity, p.price,
		(i.quantity * p.price) AS total_value
-- Join the Inventory table with the Products table based on product_id
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id; */

-- Left join Products with Transactions to include all products, even those with no matching transactions
/* SELECT p.product_name
FROM Products p
LEFT JOIN Transactions t ON p.product_id = t.product_id
-- Only consider transactions that are of type 'sale'
AND t.transaction_type = 'sale'
-- Filter for products with no transaction or transactions before September 1, 2024
WHERE t.transaction_date IS NULL OR t.transaction_date < '2025-12-01'; */


-- Calculate the total revenue by multiplying the quantity sold by the product price
/* SELECT SUM(t.quantity * p.price) AS total_revenue
-- Join the Transactions table with the Products table to access product price
FROM Transactions t
JOIN Products p ON t.product_id = p.product_id
-- Filter for only 'sale' transactions
WHERE t.transaction_type = 'sale'
-- Only include transactions within the date range of October 1 to October 31, 2024
AND t.transaction_date BETWEEN '2025-07-01' AND '2025-12-31'; */

-- Select the product name and the total quantity sold
/* SELECT p.product_name, SUM(t.quantity) AS total_sold
-- Join the Transactions table with the Products table to link products to transactions
FROM Transactions t
JOIN Products p ON t.product_id = p.product_id
-- Filter for only 'sale' transactions
WHERE t.transaction_type = 'sale'
-- Only include transactions that occurred between October Aug 1 and Dec 31, 2024
AND t.transaction_date BETWEEN '2025-01-01' AND '2025-12-31'
-- Group the results by product name to calculate the total quantity sold for each product
GROUP BY p.product_name
-- Order the products by the total quantity sold in descending order (most sold first)
ORDER BY total_sold DESC
-- Limit the result to the top-selling product (one result) 
LIMIT 1; */

-- Select the transaction date and quantity from the Transactions table
/* SELECT t.transaction_date, t.quantity
-- Query the Transactions table using the alias 't'
FROM Transactions t
-- Filter for transactions related to the product with product_id 2
WHERE t.product_id = 2
-- Filter for only 'purchase' type transactions
AND t.transaction_type = 'purchase'; */

-- Select the product name and quantity from the Products and Transactions tables
/* SELECT p.product_name, t.quantity
-- Join the Transactions table with the Products table using the product_id
FROM Transactions t
JOIN Products p ON t.product_id = p.product_id
-- Filter to only include sale transactions
WHERE t.transaction_type = 'sale'
-- Filter to only include transactions that occurred today
AND t.transaction_date = CURRENT_DATE; */

-- Select the product name and quantity from the Products and Inventory tables
/* SELECT p.product_name, i.quantity
-- Join the Inventory table with the Products table using the product_id
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id
-- Filter to include only products with product_id 1 or 2
WHERE p.product_id IN (1, 2); */

-- Select the transaction date, product name, and quantity from the Transactions and Products tables
SELECT t.transaction_date, p.product_name, t.quantity
-- Join the Transactions table with the Products table using the product_id
FROM Transactions t
JOIN Products p ON t.product_id = p.product_id
-- Filter the results to only include transactions where the type is 'purchase'
WHERE t.transaction_type = 'purchase';

