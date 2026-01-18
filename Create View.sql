# Q1 - 423606450  


USE Suwapiyasa_DB;

DROP VIEW IF EXISTS View_Patient_Surgery_Location_Info;

CREATE OR REPLACE VIEW View_Patient_Surgery_Location_Info AS
SELECT
    p.PatientID,
    p.PatientName,
    CONCAT(ps.BedNumber, '  ', l.RoomNumber) AS Location,
    s.SurgeryName,
    s.SurgeryDate
FROM Patient p
JOIN Surgery s ON p.PatientID = s.PatientID
JOIN PatientStay ps ON p.PatientID = ps.PatientID
JOIN Location l ON ps.BedNumber = l.BedNumber;


SELECT * FROM View_Patient_Surgery_Location_Info;

