use hmbank;
/* Tasks:4 - Subquery and its type */
-- 1 Retrieve the customer(s) with the highest account balance.

SELECT *
FROM customers , accounts
ORDER BY balance DESC
LIMIT 1;

-- 2 Calculate the average account balance for customers who have more than one account.

SELECT
    c.customer_id,
    AVG(a.balance) AS average_balance
FROM
    customers c
JOIN
    accounts a ON c.customer_id = a.customer_id
WHERE
    c.customer_id IN (
        SELECT customer_id
        FROM accounts
        GROUP BY customer_id
        HAVING COUNT(account_id) > 1
    )
GROUP BY
    c.customer_id;
    
-- 3 Retrieve accounts with transactions whose amounts exceed the average transaction amount.

SELECT DISTINCT a.*
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
WHERE t.amount > (
    SELECT AVG(amount)
    FROM transactions
);

-- 4 Identify customers who have no recorded transactions.

SELECT Customers.customer_id, Customers.first_name, Customers.last_name
FROM Customers
LEFT JOIN Transactions ON Customers.customer_id = Transactions.account_id
WHERE Transactions.account_id IS NULL;

-- 5 Calculate the total balance of accounts with no recorded transactions.

SELECT SUM(Accounts.balance) AS total_balance
FROM Accounts
LEFT JOIN Transactions ON Accounts.account_id = Transactions.account_id
WHERE Transactions.account_id IS NULL;

-- 6 Retrieve transactions for accounts with the lowest balance.

SELECT A.account_id,T.transaction_ID,T.transaction_type,T.amount,A.balance
FROM Transactions T
JOIN Accounts A ON T.account_id=A.account_id WHERE A.account_id IN(
SELECT account_id
FROM Accounts 
WHERE balance = (SELECT DISTINCT(balance) FROM Accounts
ORDER BY Balance LIMIT 1));

-- 7 Identify customers who have accounts of multiple types.

SELECT Customer_id, COUNT(DISTINCT account_id) as num_accounts
FROM Accounts
GROUP BY customer_id
HAVING num_accounts > 1;

-- 8 Calculate the percentage of each account type out of the total number of accounts.

SELECT
    account_type,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
FROM Accounts
GROUP BY account_type;

-- 9 Retrieve all transactions for a customer with a given customer_id.

SELECT C.customer_id,C.first_name,A.account_id,T.transaction_id,T.transaction_type,T.amount
FROM Customers C
JOIN Accounts A ON C.customer_id = A.customer_id
JOIN Transactions T ON A.account_id = T.account_id
WHERE C.customer_id=1;

-- 10 Calculate the total balance for each account type, including a subquery within the SELECT clause.

SELECT SUM(balance),account_type FROM Accounts GROUP BY Account_type;
