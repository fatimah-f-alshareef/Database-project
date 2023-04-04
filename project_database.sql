CREATE SCHEMA `project_database`;

CREATE TABLE Membership
( 		memNum INT(3) NOT NULL,
		memType VARCHAR(20) CHECK (memType IN ('annually', 'mounthly', 'pay-as-you-go')),
		specialOffer VARCHAR(10),
		amountOfMoney DECIMAL(7,2) CHECK (amountOfMoney BETWEEN 175 AND 2250 ),
CONSTRAINT Membership_PK PRIMARY KEY (memNum)
);

-- pay-as-you-go --> at least 1500 for the whole year // mounthly --> 500 for each mounth // annually --> 2200
INSERT INTO membership
VALUES (102, 'pay-as-you-go', '25%', 1125.0),
		(105, 'mounthly', '15%', 425.0),
        (106, 'annually', 'None', 2200.0),
        (107, 'mounthly', 'None',  500.0),
        (109, 'pay-as-you-go', '20%', 1200.0),
        (104, 'annually', '10%', 1980.0);

CREATE TABLE Advertiser
( 		ID INT(10) NOT NULL,
		fName VARCHAR(20),
		lName VARCHAR(20),
CONSTRAINT Advertiser_PK PRIMARY KEY (ID)

);

INSERT INTO advertiser
VALUES (1117836485, 'Atheer', 'Alsharief'),
		(1113578694, 'Batul', 'Mrkn'),
        (1116674536, 'Shomokh', 'Althagafi'),
        (1112398739, 'Fatima', 'Alshareef'),
        (1117694343, 'Majd', 'Alhakami'),
        (1117466328, 'Asmaa', 'Alayed');

CREATE TABLE Invoice
( 		invNum INT(6) NOT NULL,
		moneyAmount DECIMAL(10,2),
		dateOfPayment DATE ,
        invType VARCHAR(20) CHECK (invType IN ('electricity', 'water', 'salary', 'maintanance', 'advertisment')),
        -- empID         INT(10), add later
        -- we will add the constraint on the foreign key 'empID' later because we need to reference the Employee table
CONSTRAINT Invoice_PK PRIMARY KEY (invNum)
);

INSERT INTO invoice
VALUES ( 101300, 5500, '2020-03-09', 'electricity'),
( 101590,  6800, '2021-04-23', 'electricity'),
( 105490, 4900, '2022-10-07', 'water'),
( 109888, 7000, '2021-03-11', 'advertisment'),
( 108390, 3500, '2020-12-07', 'maintanance'),
( 103397, 7000, '2021-01-18', 'salary'),
( 103998, 8000, '2021-01-18', 'salary'),
( 103447, 7500, '2021-01-18', 'salary'),
( 103505, 6500, '2021-01-18', 'salary'),
( 103445, 8000, '2021-01-18', 'salary'),
( 103110, 9000, '2021-01-18', 'salary'),
( 109336, 7000, '2021-03-11', 'advertisment'),
( 109112, 9000, '2021-09-01', 'advertisment'),
( 109445, 3500, '2021-01-04', 'advertisment'),
( 109467, 6400, '2021-12-25', 'advertisment'),
( 109020, 8700, '2021-09-18', 'advertisment');


CREATE TABLE Employee 
(          empID             INT(10) NOT NULL , 
		   empNo             INT(6) UNIQUE, 
           dateOfBirth       DATE , 
           gender            VARCHAR(6) CHECK (gender IN ('Male', 'Female')) , 
           salary            DECIMAL(8,2) CHECK (salary > 2000),
           fName             VARCHAR(20) ,
           lName             VARCHAR(20) , 
           invNum            INT(6) ,
	CONSTRAINT Employee_PK PRIMARY KEY (empID) ,
    CONSTRAINT Employee_FK FOREIGN KEY (invNum) REFERENCES Invoice(invNum) ON DELETE CASCADE
);

INSERT INTO employee
VALUES (1117685943, 101222, '1998-05-20', 'Male', 7000.0, 'Ahmed', 'Alzahrani', 103397),
(1117869703, 101567, '1995-06-29', 'Male', 8000.0, 'Khaled', 'Jamal', 103998),
(1119907721, 101667, '1998-09-22', 'Female', 7500.0, 'Sara', 'Mohammed', 103447),
(1110098876, 101000, '1989-09-12', 'Female', 6500.0, 'Arwa', 'Talal', 103505),
(1115567432, 101123, '1990-01-04', 'Male', 8000.0, 'Zamil', 'Abdullah', 103445),
(1112353448, 1016909, '1996-11-11', 'Female', 9000.0, 'Haneen', 'Alsharief', 103110);

ALTER TABLE Invoice
ADD (empID   INT(10));

ALTER TABLE Invoice ADD CONSTRAINT fk_name FOREIGN KEY(empID) REFERENCES Employee(empID) ON DELETE CASCADE ;

UPDATE Invoice
SET empID = 1117685943;

CREATE TABLE Advertisement
(adNo          INT(6) NOT NULL,
cost           DECIMAL(7,2),
durationDays       INT(100),
Benefits       DECIMAL(7,2),
invNum         INT(6),
ID             INT(10),
 CONSTRAINT Advertisement_PK PRIMARY KEY (adNo),
 CONSTRAINT Advertisement_FK1 FOREIGN KEY (invNum) REFERENCES Invoice(invNum) ON DELETE CASCADE,
 CONSTRAINT Advertisement_FK2 FOREIGN KEY (ID) REFERENCES Advertiser(ID) ON DELETE CASCADE
);


INSERT INTO advertisement 
VALUES ( 202778, 7000, 30, 10000, 109888, 1117836485),
(202565, 7000, 50, 9000, 109336, 1113578694),
(202333, 9000, 45, 15000, 109112, 1116674536),
(202998, 3500, 35, 6000, 109445, 1112398739),
(202779, 6400, 33, 7000, 109467, 1117694343),
(202000, 8700, 60, 10000, 109020, 1117466328);

CREATE TABLE AdvertiserPhone
(PhoneNo        INT(10) NOT NULL,
ID             INT(10),
 CONSTRAINT AdvertiserPhone_PK PRIMARY KEY (PhoneNo, ID),
 CONSTRAINT AdvertiserPhone_FK FOREIGN KEY (ID) REFERENCES Advertiser(ID) ON DELETE CASCADE
);

INSERT INTO advertiserPhone
VALUES(0504756356, 1117836485 ),
(0577644382, 1117836485 ),
(0501239874, 1113578694),
(0500098884, 1112398739),
(0504449736, 1117694343),
(0504477765, 1117466328);

CREATE TABLE Trainee
( ID      INT(10) NOT NULL,
traineeNo      INT(6) UNIQUE,
dateOfBirth    DATE,
gender      VARCHAR(6) CHECK (gender IN ('Male', 'Female')),
fName      VARCHAR(20),
lName      VARCHAR(20),
empID      INT(10),
memNum      INT(3),
 CONSTRAINT Trainee_PK PRIMARY KEY (ID),     
 CONSTRAINT Trainee_FK1 FOREIGN KEY (empID) REFERENCES Employee(empID) ON DELETE CASCADE,
CONSTRAINT Trainee_FK2 FOREIGN KEY (memNum) REFERENCES Membership(memNum) ON DELETE CASCADE );

INSERT INTO trainee
VALUES ( 1112375489, 303667, '2001-03-18', 'Female', 'Bella', 'Kamal', 1117869703, 102),
( 1110098765, 303009, '2002-06-06', 'Female', 'Yara', 'Faisal', 1119907721, 105),
( 1115436789, 303123, '2002-09-20', 'Female', 'Waseelah', 'Mohammed', 1110098876, 106),
( 1115556656, 303566, '2000-07-13', 'Male', 'Mansoor', 'Omar', 1115567432, 107),
( 1117687909, 303000, '1999-11-11', 'Male', 'Fahed', 'Hussam', 1112353448, 109),
( 1113567953, 303998, '2010-08-08', 'Male', 'Ali', 'Sharaf', 1117869703, 104);



CREATE TABLE TraineePhone
( PhoneNo      INT(10) NOT NULL,
  ID      INT(4),
CONSTRAINT TraineePhone_PK PRIMARY KEY (PhoneNo, ID),
   CONSTRAINT TraineePhone_FK FOREIGN KEY (ID) REFERENCES Trainee(ID) ON DELETE CASCADE );

INSERT INTO traineePhone
VALUES(0504667554, 1112375489 ),
(0501445778, 1112375489),
(0501123345, 1110098765),
(0505567780, 1115436789),
(0508876552, 1117687909),
(0522468909, 1115556656);

CREATE TABLE healthTest
(healthStateNo INT(5),
 height DECIMAL(5,2) CHECK (height BETWEEN 50 AND 250),
 weight DECIMAL(5,2) CHECK (weight BETWEEN 20 AND 380),
 bodyMass DECIMAL(5,2),
 properDiet VARCHAR(20) CHECK (properDiet IN('The Paleo Diet', 'The Vegan Diet', 'Low-Carb Diets', 'The Dukan Diet', 
 'The Ultra-Low-Fat Diet', 'The Atkins Diet', 'The HCG Diet', 'The Zone Diet')),
 caloriesPerDay DECIMAL(6,2),
 diseaseCheck VARCHAR(3) CHECK (diseaseCheck IN ('Yes', 'No')) ,
 ID int(10),
 CONSTRAINT healthTest_PK PRIMARY KEY (healthStateNo),
 CONSTRAINT healthTest_FK FOREIGN KEY (ID) REFERENCES Trainee(ID) ON DELETE CASCADE 
 );
 INSERT INTO healthtest
 VALUES(11990, 160.5, 50, 22.2, 'The Paleo Diet', 1500, 'No', 1112375489),
	    (11706, 164.0, 53, 19.7, 'The Vegan Diet', 1350, 'No', 1110098765),
        (11808, 158.8, 51, 22.7, 'Low-Carb Diets', 1500, 'No', 1115436789),
        (11409, 180.9, 90, 27.8, 'The Dukan Diet', 1350, 'No', 1115556656),
        (11909, 178.0, 75, 23.7, 'The Zone Diet', 1300, 'Yes', 1117687909),
        (11444, 160.1, 60, 23.4, 'The Atkins Diet', 1700, 'No', 1113567953);
 
 CREATE TABLE employeePhone
 (empID INT(10),
  phoneNumber INT(10),
  CONSTRAINT employeePhone_PK PRIMARY KEY (empID,phoneNumber),
  CONSTRAINT employeePhone_FK FOREIGN KEY (empID) REFERENCES Employee(empID) ON DELETE CASCADE 
  );
  INSERT INTO employeephone
  VALUES (1117685943, 0509876432),
  (1117869703, 0504433221),
  (1119907721, 0509987421),
  (1110098876, 0509874228),
  (1115567432, 0544793762),
  (1115567432, 0577689954),
  (1112353448, 0538870093);

CREATE TABLE doesAtest
 (empID INT(10),
  healthStateNo INT(5),
  CONSTRAINT doesAtest_PK PRIMARY KEY (empID,healthStateNo),
  CONSTRAINT doesAtest_FK FOREIGN KEY (empID) REFERENCES Employee(empID) ON DELETE CASCADE ,
  CONSTRAINT doesAtest_FKq FOREIGN KEY (healthStateNo) REFERENCES healthTest(healthStateNo) ON DELETE CASCADE 
  );
  INSERT INTO doesAtest
  VALUES (1117685943, 11990),
  (1117869703, 11706),
  (1119907721, 11808),
  (1110098876, 11409),
  (1115567432, 11909),
  (1112353448, 11444);
  
  CREATE TABLE EmployeeExperience 
(
empID            INT(10) , 
experiences     VARCHAR(150) ,
CONSTRAINT EmployeeExperirnce_PK  PRIMARY KEY (empID , experiences ) ,
CONSTRAINT EmployeeExperirnce_FK1 FOREIGN KEY (empID) REFERENCES Employee(empID) ON DELETE CASCADE 
);
 INSERT INTO employeeexperience
  VALUES (1117685943, '+7 years experience'),
  (1117685943, 'level 4 certified personal trainer'),
  (1117685943, 'NASM certified personal trainer'),
  (1117869703, '+12 years experience'),
  (1117869703, 'bachelors degree in physical education'),
  (1119907721, '+9 years experience'),
  (1119907721, 'diploma in physical education'),
  (1110098876,'+3 years experience'),
  (1115567432, '+5 years experience'),
  (1115567432, 'Pilates from Merrithew'),
  (1112353448, '+13 years experience'),
  (1112353448, 'certified personal trainer (PTAG/NFPT)'),
  (1112353448, 'certified lifeguard level 1 (IWSF)'),
  (1112353448, 'free training');
  
   CREATE TABLE Class
   (className    VARCHAR(20) NOT NULL,
   Timing        VARCHAR(20) ,
   Duration      INT(4),
   TrainingRoom  INT(4),
   empID         INT(10),
   CONSTRAINT Class_PK  PRIMARY KEY (className, empID ),
   CONSTRAINT Class_FK1 FOREIGN KEY (empID) REFERENCES Employee(empID) ON DELETE CASCADE 
   );
   
   INSERT INTO Class
   VALUES ('Dancing', '08-00-00', 2, 201, 1112353448),
   ('Swimming', '10-00-00', 1, 202, 1112353448),
   ('Body Building', '11-00-00', 1.5, 203, 1112353448),
   ('Zumba', '12-30-00', 1.5, 201, 1115567432),
   ('Jogging', '14-00-00', 1, 202, 1115567432),
   ('Body Building', '15-00-00', 1, 203, 1115567432),
   ('Swimming', '16-00-00', 1, 201, 1119907721),
   ('Tango', '17-00-00', 2, 202, 1119907721),
   ('Weights Lifting', '19-00-00', 1, 203, 1110098876),
   ('Flamenco', '20-00-00', 2, 201, 1117869703);
   
  
-- trainers that trains trainees whos body mass is over 20
	SELECT fname, lname
    FROM employee 
    WHERE employee.empID IN (SELECT trainee.empID
							FROM trainee
							WHERE trainee.Id IN(SELECT healthtest.ID
												FROM healthtest
												WHERE bodyMass >20));
    
  -- for each trainee show all their details combined 
  -- with thier membership details in ascending order of thier names
    SELECT *
    FROM trainee t, membership m
    WHERE t.memNum = m.memNum
    ORDER BY t.fName ASC ;
    
 -- show sum of amount of money paid for each invoice type but only if the sum value is larger the the average
 -- in descending order of these types 
	SELECT invType, SUM(moneyAmount) AS Cost
    FROM Invoice
    GROUP BY invType
    HAVING Cost >(SELECT AVG(moneyAmount)
				  FROM Invoice)
    ORDER BY invType DESC;
    
-- show names of trainee who have disease and count them
   SELECT fname, lname , count(id) as count
   FROM trainee
   WHERE id IN (SELECT id
				FROM healthtest
                WHERE diseaseCheck = 'Yes');
                
-- Show swimming coach name, class time and Training Room in ascending order             
	SELECT fname , timing , TrainingRoom
	FROM class c , employee e
	WHERE c.empID = e.empID AND className = 'Swimming'
	ORDER BY timing ASC;
    
-- Show all details of the female trainees in descending order of their ids then memNum then traineeNo
   SELECT  *
   FROM        Trainee
   WHERE       gender ='Female'
   ORDER BY    ID , memNum , traineeNo DESC ; 
   
-- group up each gender of employee with their count
   SELECT      gender , COUNT(empID) AS count 
   FROM        employee 
   GROUP BY    gender 
   ORDER BY    gender ;
  
   
-- show the advertiser name with the benefits of thier advertisment in Descending of their names
	SELECT d.fName,d.lName,a.Benefits
	FROM advertisement a, advertiser d
	WHERE a.ID = d.ID
	ORDER BY d.fName DESC;

-- show the number of invoices for each type with the total amount in ascending order of the count
	SELECT invType,count(*) InvoiceCount ,sum(moneyAmount) totalCost
	FROM invoice
	GROUP BY invType
	ORDER BY InvoiceCount ASC;

-- show the employees names and date of birth but only if their salary is more than 8000 ordered by their dob
	SELECT fName, lName, dateOfBirth
	FROM Employee
	WHERE salary>=8000
	ORDER BY dateOfBirth ASC;

-- count each type of classes but only if they have more than one class
	SELECT className, COUNT(empID) AS Count
	FROM Class
	GROUP BY className
	HAVING COUNT(empID)>1;
    
-- Update
UPDATE Class
SET TrainingRoom = 203
WHERE className = 'Dancing';

UPDATE Trainee
SET MemNum = 106
WHERE fName = 'Bella';

-- Delete
DELETE FROM employeeexperience
WHERE experiences = 'level 4 certified personal trainer';


DELETE FROM healthtest
WHERE healthStateNo = '11909';

select *
from employeeexperience;

select *
from healthtest;
    
    
    
    
    
    