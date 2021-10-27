CREATE OR REPLACE PROCEDURE get_referror_fee_summary()
BEGIN
	SELECT 
		  rf.id
		, rf.create_date AS createDate
		, rf.last_modified_date AS lastModifiedDate 
		, rf.user_id as userId
		, rf.amount	
		, u.create_date AS userCreateDate
		, u.last_modified_date AS userLastModifiedDate
		, u.user_type AS userType
		, u.display_name AS displayName
		, u.avatar_big AS avatarBig
		, u.avatar_small AS avatarSmall
		, u.firstname
		, u.lastname
		, u.phone_number AS phoneNumber
		, u.referred_by_id AS referredById
		, p.value + TIMESTAMPDIFF(HOUR, NOW(), u.create_date) > 0 AS active
	FROM users u
	INNER JOIN referror_fees rf ON (u.id = rf.user_id)
	INNER JOIN parameters p ON (p.name = 'Referral hours');
END;