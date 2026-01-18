# Q5 - 423606450  


USE Suwapiyasa_DB;


LOAD XML INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Staff.xml'
REPLACE
INTO TABLE Staff
ROWS IDENTIFIED BY '<Staff>';

SELECT * FROM Staff;


LOAD XML INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Patient.xml'
REPLACE
INTO TABLE Patient
ROWS IDENTIFIED BY '<Patient>';

SELECT * FROM Patient;
