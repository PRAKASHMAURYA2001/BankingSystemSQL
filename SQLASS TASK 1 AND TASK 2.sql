/*TASK:1- DATABASE DESIGN*/
create table customers(
    customer_id int primary key , 
    first_name varchar(20) not null,
    last_name varchar(20), DOB date, 
    email varchar(20) unique not null,
    phone_number int unique not null,
    address varchar(30)
);
create table accounts(
    account_id int primary key,
    customer_id int,
    account_type varchar(20),
    balance decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);
create table transactions(
    transaction_id int primary key,
    account_id int,
    transaction_type varchar(20),
    amount decimal(10,2),
    transaction_date date,
    foreign key (account_id) references accounts(account_id)
);
/* TASK:2- Select, Where, Between, AND, LIKE */
-- Insert at least 10 sample records into each of the following tables.
INSERT INTO customers VALUES
(1, 'ABC', 'XYZ','1980-12-17', 'ABCXYZ@gmail.com', 123456789, 'PUNE');
INSERT INTO customers VALUES
(2, 'DEF', 'UVW','1981-12-17', 'DEFUVW@gmail.com', 234567890, 'MUMBAI');
INSERT INTO customers VALUES
(3, 'GHI', 'RST','1982-12-17', 'GHIRST@gmail.com', 345678901, 'DELHI');
INSERT INTO customers VALUES
(4, 'JKL', 'OPQ','1983-12-17', 'JKLOPQ@gmail.com', 456789012, 'CHENNAI');
INSERT INTO customers VALUES
(5, 'MNO', 'LMN','1984-12-17', 'MNOLMN@gmail.com', 567890123, 'PUNE');
INSERT INTO customers VALUES
(6, 'EFG', 'QRS','1985-12-17', 'EFGQRS@gmail.com', 678901234, 'PATNA');
INSERT INTO customers VALUES
(7, 'HIJ', 'TUV','1986-12-17', 'HIJTUV@gmail.com', 789012345, 'HYDRABAD');
INSERT INTO customers VALUES
(8, 'KLM', 'WXY','1987-12-17', 'KLMQRS@gmail.com', 890123456, 'MUMBAI');
INSERT INTO customers VALUES
(9, 'NOP', 'ZAB','1988-12-17', 'NOPZAB@gmail.com', 901234567, 'NAGPUR');
INSERT INTO customers VALUES
(10, 'QRS','CDE','1989-12-17', 'QRSCDE@gmail.com', 012345678, 'RANCHI');

INSERT INTO accounts VALUES
(1, 1,'savings' ,1000);
INSERT INTO accounts VALUES
(2, 2,'current' ,2000);
INSERT INTO accounts VALUES
(3, 3,'zero_balance' ,100);
INSERT INTO accounts VALUES
(4, 4,'savings' ,3000);
INSERT INTO accounts VALUES
(5, 5,'current' ,4000);
INSERT INTO accounts VALUES
(6, 6,'zero_balance' ,300);
INSERT INTO accounts VALUES
(7, 7,'savings' ,8000);
INSERT INTO accounts VALUES
(8, 8,'current' ,9000);
INSERT INTO accounts VALUES
(9, 9,'zero_balance' ,200);
INSERT INTO accounts VALUES
(10, 10,'savings' ,7000);

INSERT INTO transactions VALUES
('1','1','Deposit','200', '2024-01-01');
INSERT INTO transactions VALUES
('2','1','Withdrawal','2000','2024-01-01');
INSERT INTO transactions VALUES
('3','2','Deposit','4000','2024-01-01');
INSERT INTO transactions VALUES
('4','7','Withdrawal','3000' , '2024-01-01');
INSERT INTO transactions VALUES
('5','6','transfer','7000','2024-01-11');
INSERT INTO transactions VALUES
('6','3','Deposit','5000', '2024-01-13');
INSERT INTO transactions VALUES
('7','5','transfer','6000','2024-01-13');
INSERT INTO transactions VALUES
('8','10','Deposit','3000','2024-01-14');
INSERT INTO transactions VALUES
('9','6','Withdrawal','6000','2024-01-21');
INSERT INTO transactions VALUES
('10','5','Withdrawal','100','2024-01-22');

-- 1 SQL query to retrieve the name, account type and email of all customers.

SELECT concat(customers.first_name,customers.last_name) name,customers.email,accounts.account_type 
FROM customers, accounts
WHERE customers.customer_id = accounts.account_id; 

-- 2 SQL query to list all transaction corresponding customer.

SELECT  t.*
FROM transactions t
WHERE t.account_id = 1;

-- 3 SQL query to increase the balance of a specific account by a certain amount.

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 8;

-- 4 SQL query to Combine first and last names of customers as a full_name.

SELECT CONCAT(first_name,last_name) AS full_name
FROM customers;

-- 5 SQL query to remove accounts with a balance of zero where the account type is savings.

DELETE FROM accounts
WHERE balance = 0 AND account_type = 'savings';

-- 6 SQL query to Find customers living in a specific city.

SELECT * 
FROM Customers
WHERE address = 'MUMBAI';

-- 7 SQL query to Get the account balance for a specific account.

SELECT balance
FROM accounts
WHERE account_id = '4';

-- 8 SQL query to List all current accounts with a balance greater than $1,000.

SELECT account_id, balance, account_type
FROM Accounts
WHERE balance > 1000 AND account_type = 'current';

-- 9 SQL query to Retrieve all transactions for a specific account.

SELECT *
FROM transactions
WHERE account_id = '10';

-- 10 SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.

SELECT 
	account_id, 
	balance * (7.5 / 100) AS interest_accrued
FROM accounts
WHERE account_type = 'savings';

-- 11 SQL query to Identify accounts where the balance is less than a specified overdraft limit.

SELECT account_id, balance
FROM accounts
WHERE balance < 1000;

-- 12 SQL query to Find customers not living in a specific city.

SELECT *
FROM Customers
WHERE address !=  'MUMBAI';

