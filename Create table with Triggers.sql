USE Suwapiyasa_DB;


/* Drop MedInfo table if exists */
DROP TABLE IF EXISTS MedInfo;

/* Create MedInfo Table */
CREATE TABLE MedInfo (
    MedName VARCHAR(100) PRIMARY KEY,
    QuantityAvailable INT,
    ExpirationDate DATE
);


/* Drop triggers if they exist */
DROP TRIGGER IF EXISTS trg_MedInfo_insert;
DROP TRIGGER IF EXISTS trg_MedInfo_update;
DROP TRIGGER IF EXISTS trg_MedInfo_delete;


/* Trigger 1 - After Insert */
DELIMITER $$
CREATE TRIGGER trg_MedInfo_insert
AFTER INSERT ON Medication
FOR EACH ROW
BEGIN
    INSERT INTO MedInfo (MedName, QuantityAvailable, ExpirationDate)
    VALUES (NEW.MedicationName, NEW.QuantityOnHand, NEW.ExpirationDate);
END $$
DELIMITER ;


/* Trigger 2 - After Insert */
DELIMITER $$
CREATE TRIGGER trg_MedInfo_update
AFTER UPDATE ON Medication
FOR EACH ROW
BEGIN
    UPDATE MedInfo
    SET QuantityAvailable = NEW.QuantityOnHand,
        ExpirationDate = NEW.ExpirationDate
    WHERE MedName = OLD.MedicationName;
END $$
DELIMITER ;


/* Trigger 3 - After Insert */
DELIMITER $$
CREATE TRIGGER trg_MedInfo_delete
AFTER DELETE ON Medication
FOR EACH ROW
BEGIN
    DELETE FROM MedInfo
    WHERE MedName = OLD.MedicationName;
END $$
DELIMITER ;

/*Populate MedInfo for existing Medication rows*/
INSERT INTO MedInfo (MedName, QuantityAvailable, ExpirationDate)
SELECT MedicationName, QuantityOnHand, ExpirationDate
FROM Medication
ON DUPLICATE KEY UPDATE
    QuantityAvailable = VALUES(QuantityAvailable),
    ExpirationDate = VALUES(ExpirationDate);

/*   Check MedInfo output */
SELECT * FROM MedInfo;














