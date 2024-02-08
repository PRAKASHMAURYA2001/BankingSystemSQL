use hmbank;
/* Tasks - 3: Aggregate functions, Having, Order By, GroupBy and Joins */

-- 1 SQL query to Find the average account balance for all customers.
SELECT 
AVG(balance) 'AVERAGE BALANCE'
FROM
accounts;

-- 2 SQL query to Retrieve the top 10 highest account balances.

SELECT customer_id, account_id, balance
FROM accounts
ORDER BY balance DESC
LIMIT 10;

-- 3 SQL query to Calculate Total Deposits for All Customers in specific date.

SELECT account_id, SUM(amount) AS total_deposits, transaction_date
FROM transactions T 
WHERE T.transaction_type = 'deposit' AND T.transaction_date = '2024-01-01'
GROUP BY account_id;

-- 4 SQL query to Find the Oldest and Newest Customers.

SELECT MIN(DOB) AS oldest_customer_dob, MAX(DOB) AS newest_customer_dob
FROM customers;

-- 5 SQL query to Retrieve transaction details along with the account type.

SELECT transactions.*, accounts.account_type
FROM transactions
JOIN accounts ON transactions.account_id = accounts.account_id;

-- 6 SQL query to Get a list of customers along with their account details.

SELECT customers.first_name, customers.last_name, accounts.*
FROM customers
JOIN accounts ON customers.customer_id = accounts.customer_id;


-- 7 SQL query to Retrieve transaction details along with customer information for a specific account.

SELECT C.*, T.*
FROM customers C
JOIN accounts A ON C.customer_id = A.customer_id
JOIN transactions T ON A.account_id = T.account_id
WHERE T.account_id = 01;

-- 8 SQL query to Identify customers who have more than one account.

SELECT C.customer_id, C.first_name, COUNT(account_id) AS num_accounts
FROM Customers C
JOIN accounts A ON C.customer_id = A.customer_id
GROUP BY C.customer_id
HAVING num_accounts > 1;

-- 9 SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
SELECT
    accounts.account_id,
    accounts.balance,
    transactions.amount,
    (accounts.balance-transactions.amount) AS difference
FROM accounts INNER JOIN
transactions ON accounts.account_id=transactions.account_id
GROUP BY accounts.account_id;

-- 10 SQL query to Calculate the average daily balance for each account over a specified period.

SELECT
    A.account_id,
    MONTHNAME(transaction_date) AS month,
    YEAR(transaction_date) AS year,
    AVG(balance / DAY(LAST_DAY(transaction_date))) AS avg_daily_balance
FROM
    accounts A
JOIN
    transactions T ON A.account_id = T.account_id
GROUP BY
    account_id, year, month;
    
-- 11 Calculate the total balance for each account type.

SELECT accounts.account_type, 
       SUM(transactions.amount) AS total_balance
FROM accounts
JOIN transactions ON accounts.account_id = transactions.account_id
GROUP BY accounts.account_type;

-- 12 Identify accounts with the highest number of transactions order by descending order. 

SELECT account_id, COUNT(*) AS total_txns
FROM transactions 
GROUP BY account_id
ORDER BY total_txns DESC;

-- 13 List customers with high aggregate account balances, along with their account types.

SELECT C.customer_id, C.first_name, C.last_name, A.account_type, A.balance AS aggregate_balance
FROM customers C
JOIN accounts A ON C.customer_id = A.customer_id
ORDER BY aggregate_balance DESC;

-- 14 Identify and list duplicate transactions based on transaction amount, date, and account.

SELECT account_id, amount AS duplicate_txn, transaction_date, COUNT(*) AS total_count
FROM transactions T 
GROUP BY account_id, amount, transaction_date
HAVING COUNT(*) > 1;

    
    




