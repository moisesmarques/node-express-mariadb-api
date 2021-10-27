CREATE OR REPLACE PROCEDURE insert_referror_fee(IN userID INT,	IN referredByID INT,	IN amount INT)
MODIFIES SQL DATA
BEGIN
	INSERT INTO referror_fees (create_date, last_modified_date, user_id, referred_by_id, amount, is_processed) VALUES (CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), userID, referredByID, amount, 0);
END;