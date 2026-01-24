/*Create Database and Tables*/


DROP database if exists Suwapiyasa_DB;


/*Create Database*/
create database Suwapiyasa_DB;

use Suwapiyasa_DB;

/*Create Staff Table*/
create table Staff(
	EmployeeNumber varchar (30) primary key,
    EmployeeName varchar (50) NOT NULL,
    Gender varchar (30) NOT NULL,
    Address varchar (100) NOT NULL,
    TelephoneNumber varchar (30) NOT NULL,
    StaffType varchar (30) NOT NULL
);


/*Create Surgeon Table*/
create table Surgeon(
	EmployeeNumber varchar (30) primary key,
    Speciality varchar (100) NOT NULL,
    ContractType varchar (50) NOT NULL,
    ContractLength varchar (50)NOT NULL,
    foreign key (EmployeeNumber) references Staff (EmployeeNumber) 
); 


/*Create Head Doctor Table*/
create table HeadDoctor(
	EmployeeNumber varchar (30) primary key,
    HDNumber varchar (30) unique NOT NULL,
    Speciality varchar (100) NOT NULL,
    foreign key (EmployeeNumber) references Staff (EmployeeNumber)
);


/*Create Doctor Table*/
create table Doctor(
	EmployeeNumber varchar (30) primary key,
    Speciality varchar (100) NOT NULL,
    foreign key (EmployeeNumber) references Staff (EmployeeNumber)
);


/*Create Nurse Table*/
create table Nurse(
	EmployeeNumber varchar (30) primary key,
    Grade varchar (30) NOT NULL,
    YearsOfExperience int NOT NULL,
    SurgerySkillType varchar (100) NOT NULL,
    foreign key (EmployeeNumber) references Staff (EmployeeNumber)
);


/*Create Patient Table*/
create table Patient(
	PatientID varchar (30) primary key,
    PatientName varchar (50) NOT NULL,
    Age int check (Age > 0) NOT NULL,
    Address varchar (100) NOT NULL,
    TelephoneNumber varchar (30) NOT NULL,
    BloodType varchar (30) NOT NULL,
    Allergies varchar (100),
    PrimaryDoctorID varchar (30) NOT NULL,
    foreign key (PrimaryDoctorID) references Doctor (EmployeeNumber)
);


/*Create Surgery Table*/
create table Surgery(
    PatientID varchar (30) NOT NULL, 
    SurgeryName varchar (100) NOT NULL,
    SurgeryDate date NOT NULL,
    SurgeryTime time NOT NULL,
    Theatre varchar (30) NOT NULL,
    Category varchar (50) NOT NULL,
    SpecialNeeds varchar (100),
    SurgeonID varchar (30) NOT NULL,
    primary key (PatientID, SurgeryName), 
    foreign key (PatientID) references Patient (PatientID),
    foreign key (SurgeonID) references Surgeon (EmployeeNumber)
   );


/*Create Surgery Nurse Table*/
create table SurgeryNurse(
	PatientID varchar (30) NOT NULL,
    SurgeryName varchar (100) NOT NULL,
    NurseID varchar (30) NOT NULL,
    primary key (PatientID, SurgeryName, NurseID),
    foreign key (PatientID, SurgeryName) references Surgery (PatientID, SurgeryName),
    foreign key (NurseID) references Nurse (EmployeeNumber)
);


/*Create Location Table*/
create table Location(
	BedNumber varchar (30) primary key,
    RoomNumber varchar (30) NOT NULL,
    NursingUnit varchar (30) NOT NULL
);


/*Create Patient Stay Table*/
create table PatientStay(
	StayID varchar (30) primary key, 
    PatientID varchar (30) NOT NULL,
    BedNumber varchar (30) NOT NULL,
    foreign key (PatientID) references Patient (PatientID),
	foreign key (BedNumber) references Location (BedNumber)
);


/*Create Medication Table*/
create table Medication(
	MedicalCode varchar (30) primary key,
    MedicationName varchar (100) NOT NULL,
    QuantityOnHand int NOT NULL,
    QuantityOrdered int NOT NULL,
    Cost decimal (10,2) NOT NULL,
    ExpirationDate date NOT NULL
);


/*Create Patient Medication Table*/
create table PatientMedication(
	PatientID varchar (30) NOT NULL,
    MedicalCode varchar (30) NOT NULL,
    primary key (PatientID, MedicalCode),
    foreign key (PatientID) references Patient (PatientID),
    foreign key (MedicalCode) references Medication (MedicalCode)
);


/*Create Medication Interactions Table*/
create table MedicationInteractions(
	MedicalCode1 varchar (30) NOT NULL,
    MedicalCode2 varchar (30) NOT NULL,
    primary key (MedicalCode1, MedicalCode2),
    foreign key (MedicalCode1) references Medication (MedicalCode),
    foreign key (MedicalCode2) references Medication (MedicalCode)
);


/*Create Patient Medication Interactions Table*/
create table PatientMedicationInteractions(
	PatientID varchar (30) NOT NULL,
	MedicalCode1 varchar (30) NOT NULL,
    MedicalCode2 varchar (30) NOT NULL,
    Severity varchar (50) NOT NULL,
    primary key (PatientID, MedicalCode1, MedicalCode2),
    foreign key (PatientID) references Patient (PatientID),
    foreign key (MedicalCode1) references Medication (MedicalCode),
    foreign key (MedicalCode2) references Medication (MedicalCode)
);




/*Database Population*/

/*Insert into Staff Table*/
insert into Staff (EmployeeNumber, EmployeeName, Gender, Address, TelephoneNumber, StaffType) values
	('S001', 'D.D.Perera', 'Male', '20,Galle road, Dehiwala', '0714568925', 'Surgeon'),
    ('D001', 'N.S.Fernando', 'Male', '1st Cross Street, High level road, Nugegoda', '0778454845', 'Head Doctor'),
    ('N001', 'N.D.Ranasinghe', 'Female', '22/A, 2nd Lane, Moratuwa', '0755789405', 'Nurse'),
    ('D002', 'S.P.Peiris', 'Male', '324, Soysa Road, Piliyandala', '0741526458', 'Head Doctor'),
    ('N002', 'S.S.Jayasundara', 'Female', '451, Hill Street, Dehiwala', '0745628479', 'Nurse'),
    ('S002', 'M.K.Jayaweera', 'Female', '24/1, Garden Street, Colombo', '0728569423', 'Surgeon'),
    ('D003', 'J.P.De Silva', 'Female', '78, Flower road, Colombo', '0741235698', 'Doctor'),
    ('N003', 'S.D.Fernando', 'Female', '45, 4th lane, Kottawa', '0714562589', 'Nurse'),
    ('D004', 'K.G.Dias', 'Female', '12/B, 4th Cross Street, Battaramulla', '0752145968', 'Doctor'),
    ('N004', 'M.D. Silva', 'Female', '12, Manel road, Maharagama', '0745621589', 'Nurse');

SELECT * FROM Staff;


/*insert into  Surgeon Table*/
insert into Surgeon (EmployeeNumber, Speciality, ContractType, ContractLength) values
	('S001','Cardiothoracic Surgery','Full-Time','3 Years'),
    ('S002','Neurosurgery','Part-Time','1 Year');

SELECT * FROM Surgeon;


/*insert into Head Doctor Table*/
insert into HeadDoctor (EmployeeNumber, HDNumber, Speciality) values
	('D001', 'HD001', 'General Medicine'),
    ('D002', 'HD002', 'Internal Medicine');
  
SELECT * FROM HeadDoctor;


/*insert into Doctor Table*/
insert into Doctor (EmployeeNumber, Speciality) values
	('D003', 'Pediatrics'),
    ('D004', 'Cardiology');

SELECT * FROM Doctor;


/*insert into Nurse Table*/
insert into Nurse (EmployeeNumber, Grade, YearsOfExperience, SurgerySkillType) values
	('N001', 'Grade A', 5, 'General Surgery'),
    ('N002', 'Grade B', 3, 'Orthopedic Surgery'),
    ('N003', 'Grade A', 7, 'Cardiac Surgery'),
    ('N004', 'Grade C', 2, 'General Surgery');

SELECT * FROM Nurse;


/*insert into Patient Table*/
insert into Patient (PatientID, PatientName, Age, Address, TelephoneNumber, BloodType, Allergies, PrimaryDoctorID) values
	('P001', 'A.D. Perera', 45, '14, Cross Street, Nugegoda', '0714562589', 'A+', 'Dust Allergy', 'D003'),
    ('P002', 'J.K. De Silva', 25, '32, Sea road, Dehivala', '0756985425', 'B+', NULL, 'D004'),
    ('P003', 'F.M. Alwis', 32, '45, Flower road, Maharagama', '0765264326', 'O-', 'Penicillin', 'D004'),
    ('P004', 'M.P. Wijesinghe', 40, '6/C, 1st Lane, Kottawa', '0741235689', 'AB+', NULL, 'D003');

SELECT * FROM Patient;


/*insert into Surgery Table*/
insert into Surgery (PatientID, SurgeryName, SurgeryDate, SurgeryTime, Theatre, Category, SpecialNeeds, SurgeonID) values
	('P001', 'Heart Bypass', '2025-03-10', '09:00:00', 'Theatre 1', 'Cardiac', 'Extra oxygen', 'S001'),
    ('P003', 'Appendix Removal', '2025-04-12', '14:30:00', 'Theatre 2', 'General', NULL, 'S001');

SELECT * FROM Surgery;


/*insert into Surgery Nurse Table*/
insert into SurgeryNurse (PatientID, SurgeryName, NurseID) values
	('P001','Heart Bypass', 'N001'),
    ('P001','Heart Bypass', 'N003'),
    ('P003', 'Appendix Removal', 'N002'),
    ('P003', 'Appendix Removal', 'N004');

SELECT * FROM SurgeryNurse;

/*insert into Location Table*/
insert into Location (BedNumber, RoomNumber, NursingUnit) values
	('BED001', 'ROOM 101', 'Unit A'),
    ('BED002', 'ROOM 102', 'Unit A'),
    ('BED003', 'ROOM 101', 'Unit B'),
    ('BED004', 'ROOM 102', 'Unit B');

SELECT * FROM Location;


/*insert into Patient Stay Table*/
insert into PatientStay (StayID, PatientID, BedNumber) values
	('STAY001', 'P001', 'BED001'),
    ('STAY002', 'P003', 'BED003');
    
SELECT * FROM PatientStay;


/*insert into Medication Table*/
insert into Medication (MedicalCode, MedicationName, QuantityOnHand, QuantityOrdered, Cost, ExpirationDate) values
	('MED001', 'Amoxicillin', 200, 50, 45.00, '2026-01-12'),
    ('MED002', 'Paracetamol', 500, 100, 12.50, '2027-01-15'),
    ('MED003', 'Aspirin', 300, 80, 25.00, '2025-12-31'),
    ('MED004', 'Ibuprofen', 400, 120, 30.00, '2027-03-20'),
    ('MED005', 'Ciprofloxacin', 150, 60, 55.00, '2026-05-18'),
    ('MED006', 'Metformin', 350, 90, 40.00, '2027-08-10'),
    ('MED007', 'Omeprazole', 280, 70, 35.00, '2026-01-09'),
    ('MED008', 'Cetirizine', 450, 110, 20.00, '2027-04-05'),
    ('MED009', 'Azithromycin', 180, 40, 60.00, '2026-09-14'),
    ('MED010', 'Vitamin C', 600, 150, 10.00, '2028-01-30');
    
SELECT * FROM Medication;


/*insert into Patient Medication Table*/
insert into PatientMedication (PatientID, MedicalCode) values
	('P001','MED001'),
    ('P001', 'MED006'),
    ('P004', 'MED003');
    
SELECT * FROM PatientMedication;


/*insert into Medication Interactions Table*/
insert into MedicationInteractions (MedicalCode1, MedicalCode2) values
	('MED001', 'MED004'),
    ('MED002', 'MED003');
    
SELECT * FROM MedicationInteractions;


/*insert into Patient Medication Interactions Table*/
insert into PatientMedicationInteractions (PatientID, MedicalCode1, MedicalCode2, Severity) values
	('P002', 'MED001', 'MED004', 'Moderate'),
    ('P003', 'MED002', 'MED003', 'Severe');

SELECT * FROM PatientMedicationInteractions;


























