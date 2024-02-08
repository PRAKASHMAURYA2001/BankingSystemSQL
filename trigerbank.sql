use hmbank;
-- Create a trigger to dynamically update the A.balance col.
DELIMITER //
CREATE TRIGGER update_balance
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE current_balance DECIMAL(10, 2);
    
    -- Get the current balance of the account
    SELECT COALESCE(balance, 0) INTO current_balance FROM Accounts A
		WHERE A.account_id = NEW.account_id; -- NEW.account_id indicates the newly inserted account_id in the Txns table
    
    -- Update the balance based on the transaction type
    IF NEW.transaction_type = 'deposit' THEN
        SET current_balance = current_balance + NEW.amount; -- NEW.amount indicates the newly inserted amount in the Txns table
    ELSE
        SET current_balance = current_balance - NEW.amount;
    END IF;
    
    -- Update the balance in the Accounts table
    UPDATE Accounts SET balance = current_balance WHERE account_id = NEW.account_id;
END;
//
DELIMITER ;
select *from customers;
select *from accounts;
select *from transactions;

