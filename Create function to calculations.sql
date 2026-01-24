USE Suwapiyasa_DB;

/* Drop function if exists */
DROP FUNCTION IF EXISTS DaysRemaining;

DELIMITER $$

CREATE FUNCTION DaysRemaining(expDate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(expDate, CURDATE());
END $$

DELIMITER ;

SELECT
    MedicationName,
    QuantityOnHand,
    ExpirationDate,
    DaysRemaining(ExpirationDate) AS Days_Left
FROM Medication
WHERE DaysRemaining(ExpirationDate) < 30;
