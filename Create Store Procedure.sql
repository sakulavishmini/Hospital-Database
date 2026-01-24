USE Suwapiyasa_DB;

/* Drop procedure if exists */
DROP PROCEDURE IF EXISTS GetMedicationCountByPatient;

DELIMITER $$

CREATE PROCEDURE GetMedicationCountByPatient (
    IN p_PatientID VARCHAR(30),
    INOUT medCount INT
)
BEGIN
    SELECT COUNT(*) INTO medCount
    FROM PatientMedication
    WHERE PatientID = p_PatientID;
END $$

DELIMITER ;

SET @MedicationTotal = 0;
CALL GetMedicationCountByPatient('P001', @MedicationTotal);
SELECT @MedicationTotal AS NumberOfMedications;


