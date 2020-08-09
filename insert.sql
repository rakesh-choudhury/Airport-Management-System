USE RAICHURKAR_ASHUTOSH_TEST
--------------Airport---------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Airport
(Airport_Name, Location, City, State, Country, Zip)
VALUES('Logan Airport', 'Boston', 'South Boston', 'MA', 'USA', '02115'),
	  ('LA Airport', 'North LA', 'Los Angeles', 'CA', 'USA', '28633'),
	  ('Mumbai Airport', 'South Bombay', 'Mumbai', 'MH', 'INDIA', '129819'),
	  ('HONO LULU Airport', 'Honu', 'East Side', 'IJ', 'USA', '87282'),
	  ('London Heathrow Airport', 'London', 'South London', 'LH', 'UK', '23876'),
	  ('Kugaaruk Airport', 'Pelly Bay', 'South Pelly Bay', 'LHH', 'Canada', '23891'),
	  ('Pokhara Airport', 'Pokhara', 'Pela', 'PKR', 'Nepal', '23129'),
	  ('Hamburg Hbf', 'Hamburg', 'Hamburg Middle', 'ZMB', 'Germany', '34241'),
	  ('Rabah Bitat Airport', 'Apalachicola', 'East Apalachicola', 'AAF', 'USA', '87896'),
	  ('Anapa Vityazevo Airport', 'Anapa', 'West Anapa', 'RD', 'Russia', '27483'),
	  ('Allah Valley Airport', 'Surallah', 'North Surallah', 'JH', 'Philippines', '02115');

----------Airline---------------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Airline_Company
(Company_Name)
VALUES('Amadeus IT Group S.A.'),
	  ('Sabre travel network Asia-Pacific'),
	  ('Travelsky'),
	  ('Infini travel information, Inc.'),
	  ('Travelport (Galileo core)'),
	  ('Sirena travel'),
	  ('Axess international network, Inc.'),
	  ('Sirin'),
	  ('247 Jet Ltd'),
	  ('3D Aviation'),
	  ('Jubba Airways'),
	  ('Air Sinai'),
	  ('Star East Airline'),
	  ('Interjet'),
	  ('Express Air Cargo'),
	  ('Ryan Air Services'),
	  ('Pascan Aviation'),
	  ('Advanced Air'),
	  ('Air Costa'),
	  ('Abakan Air'),
	  ('Advanced Air Co.'),
	  ('Aero Owen'),
	  ('Aero Sotravia'),
	  ('Aerohelicopteros'),
	  ('Aeroventas de Mexico');
---------------Parking-------------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Parking
(Airport_ID, Terminal, Price, Time_From, Time_To, Gate_No, Availability)
VALUES(1, 'T1', 39, '2020-05-17', '2020-06-19', 'G2','A'),
	  (2, 'T5', 32, '2020-03-15', '2020-07-05', 'H2','NA'),
	  (3, 'T9', 45, '2020-05-08', '2020-02-12', 'K9','A'),
	  (4, 'T4', 23, '2020-07-13', '2020-05-21', 'L3','A'),
      (5, 'P2', 13, '2020-06-17', '2020-01-19', 'I4','A'),
      (6, 'P9', 58, '2020-06-15', '2020-01-08', 'P2','NA'),
   	  (7, 'P7', 34, '2020-05-21', '2020-03-26', 'Y3','NA'),
	  (8, 'J3', 23, '2020-07-07', '2020-01-06', 'R3','A'),
	  (9, 'G3', 76, '2020-07-07', '2020-06-13', 'M4','NA'),
	  (10, 'J7', 48,'2020-05-05', '2020-02-05', 'V3','A'),
	  (11, 'K2', 39,'2020-05-22', '2020-06-19', 'N3','A'),
	  (12, 'H2', 39,'2020-03-05', '2020-02-05', 'S2','A');
	
--------------Airplane--------------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Airplane
(Seating_Capacity, Company_ID, Type_Of_Aircraft, Aircraft_model)
VALUES(120, 3, 'CARGO', 'B382'),
	  (10, 4, 'Boeing', '747'),
	  (20, 5, 'Airbus', 'A320'),
	  (55, 6, 'Cessna', '172'),
	  (34, 7, 'Boeing', '787'),
	  (42, 8, 'Douglas', 'DC-3'),
	  (199, 9, 'Boeing', 'B-17'),
	  (133, 10, 'Boeing', 'B-29'),
	  (112, 11, 'Learjet', '23'),
	  (76, 12, 'Lockheed', 'C-130'),
	  (98, 13, 'Messerschmitt', 'Me-262'),
	  (45, 14, 'Vans Aircraft', 'RV-3');

---------------Base Fare-------------------
DECLARE	@cost int
declare @id int
set @cost = 1000
set @id =4
WHILE @id < 16
BEGIN 
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Base_fare
(Airplane_Id, Ticket_Cost)
VALUES(@id, @cost);
set @id = @id +1
set @cost = @cost + 5
END
DELETE FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Base_fare
---------------Access---------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Access
(Airport_ID, Airplane_ID)
VALUES(1, 4),
	  (2, 5),
	  (3, 6),
	  (4, 7),
	  (5, 8),
	  (6, 9),
	  (7, 10),
	  (8, 11),
	  (9, 12),
	  (10, 13),
	  (11, 14),
	  (12, 15);

--------------Air Schedule-----------------
CREATE or ALTER TRIGGER t_air_schedule
On RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
After INSERT 
AS
BEGIN 
	DECLARE @airvalid int
	SET @airvalid = (SELECT Arrival_AirportID FROM Inserted) 
	DECLARE @arrival_name varchar(50)
	SET @arrival_name = (SELECT Airport_Name FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Airport
							where Airport_ID = @airvalid)
	UPDATE 
	Air_Schedule
	SET Arrival_Airport_Name = @arrival_name WHERE Arrival_AirportID = @airvalid
	
	DECLARE @departid int 
	SET @departid = (SELECT Depart_AirportID FROM Inserted)
	DECLARE @depart_name varchar(50)
	SET @depart_name = (SELECT Airport_Name FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Airport
						where Airport_ID = @departid)
	UPDATE 
	AMS.Air_Schedule 
	SET Depart_Airport_Name = @depart_name where Depart_AirportID  = @departid 
END
SELECT * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Airport
drop trigger AMS.t_air_schedule
SELECT * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
(Depart_AirportID, Depart_AirplaneId, Arrival_AirportID, Arrival_AirplaneId, Depart_Time, Arrival_Time)
VALUES( 8,  14, 9, 14, '2020-07-26 14:14:49', '2020-07-26 06:14:49'),
	  ( 10,  14, 11, 14, '2020-07-26 01:14:49', '2020-07-26 04:14:49');
	  (5, 11, 6, 11, '2020-07-26 15:14:49', '2020-07-26 07:14:49'),
	  (7, 11, 8, 11, '2020-07-26 19:14:49', '2020-07-26 01:14:49'),
	  (6, 12, 7, 12, '2020-07-26 20:14:49', '2020-07-26 20:14:49'),
	  (8, 12, 9, 12, '2020-07-26 14:14:49', '2020-07-26 03:14:49'),
	  (7, 13, 8, 13, '2020-07-26 18:14:49', '2020-07-26 02:14:49'),
	  (9, 13, 10, 13, '2020-07-26 19:14:49', '2020-07-26 06:14:49');
DELETE FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
SELECT * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Access WHERE Airplane_ID = 14
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
(Depart_AirplaneId, Depart_AirportID, Arrival_AirplaneId, Arrival_AirportID, Depart_Time, Arrival_Time)
VALUES(0, 0, 0, 0, '', '');
SELECT * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Access
(Airport_ID, Airplane_ID)
VALUES(1, 6),
	  (3, 7),
	  (4, 8),
	  (5, 9),
	  (6, 10),
	  (7, 11),
	  (8, 12),
	  (9, 13),
	  (10, 14),
	  (11, 15),
	  (12, 4),
	  (1, 7),
	  (3, 8),
	  (4, 9),
	  (5, 10),
	  (6, 11),
	  (7, 12),
	  (8, 13),
	  (9, 14),
	  (10, 15),
	  (11, 4),
	  (12, 5),
	  (1, 8),
	  (3, 9),
	  (4, 10),
	  (5, 11),
	  (6, 12),
	  (7, 13),
	  (8, 14),
	  (9, 15),
	  (10, 4),
	  (11, 5),
	  (12, 6);

DELETE from  RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
alter table RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule alter column Depart_Time datetime
ALTER TABLE RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule ADD  Arrival_Airport_Name VARCHAR(50),
														   Depart_Airport_Name VARCHAR(50)
																 
drop table RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
select CURRENT_DATE from dummy
update table RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule set Arrival_Airport_Name = (SELECT )
select getdate()

--------------------Hotel------------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Hotel
(Hotel_Name,City,Country,[Type])
VALUES('A CAPITOL PLACE', 'New York', 'USA', 'Hotel'),
('ADAMS INN', 'Los Angeles', 'USA', 'Homestay'),
('AKA WHITE HOUSE', 'Chicago', 'USA', 'Lodge'),
('HOTEL HIVE', 'Houston', 'USA', 'Houseboat'),
('AMERICAN GUEST HOUSE', 'Phoenix', 'USA', 'Apartment'),
('ASANTE SANA INN', 'Philadelphia', 'USA', 'Palace'),
('AVENUE SUITES HOTEL', 'San Antonio', 'USA', 'Guest House'),
('BEACON HOTEL AND CORPORATE QUARTERS', 'San Diego', 'USA', 'Camp'),
('GEORGETOWN INN WEST END', 'Dallas', 'USA', 'Cottage'),
('THE WOODWARD BY BRIDGESTREET', 'San Jose', 'USA', 'Resort'),
('IVY CITY HOTEL', 'Austin', 'USA', 'Beach Hut'),
('ROSEWOOD', 'Jacksonvill', 'USA', 'Villa'),
('CAPITAL HILTON', 'Fort Worth', 'USA', 'Tree house'),
('HILTON WASHINGTON DC NATIONAL MALL', 'Columbus', 'USA', 'Hostel'),
('CAPITAL VIEW HOSTEL', 'Charlotte', 'USA', 'Hotel'),
('Zion Home Stay', 'Udaipur', 'India', 'Homestay'),
('Araliayas Resorts', 'Jaisalmer', 'India', 'Lodge'),
('Shri Udai Palace', 'Neemrana', 'India', 'Houseboat'),
('SNP House Airport Hotel And Restaurant', 'Manali', 'India', 'Apartment'),
('Hotel Pichola Haveli (LAKE SIDE)', 'Hyderabad', 'India', 'Palace'),
('Garden Hotel', 'Mussoorie', 'India', 'Guest House'),
('Jagmandir Island Palace', 'Munnar', 'India', 'Camp'),
('Shikarbadi Heritage', 'Gandhinagar', 'India', 'Cottage'),
('Shiv Niwas Palace', 'Nahan', 'India', 'Resort'),
('Hotel The Archi', 'Jammu', 'India', 'Beach Hut');
	
--------------------User------------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.[user]
(Acc_User_ID,Fname,Lname,Passport_No)
VALUES(1, 'Lee', 'Ann', 'LH987645'),
(2, 'Colorado', 'Wendy', '9W233467'),
(3, 'Hamilton', 'Fallon', 'A1201404'),
(4, 'Buckminster', 'Samantha', 'Q1190289'),
(5, 'Zachary', 'Shea', 'E2123412'),
(6, 'Donovan', 'Suki', 'B3305643'),
(7, 'Beau', 'Deanna', '94233465'),
(8, 'Hamish', 'Virginia', 'A5436780'),
(9, 'Harding', 'Meredith', 'R6990566'),
(10, 'Wylie', 'Kelsie', 'B9876541'),
(11, 'Zachary', 'Kiayada', 'C2345698'),
(12, 'Talon', 'Jessamine', 'D1002004'),
(13, 'George', 'Rosalyn', 'X9324666'),
(14, 'Kibo', 'Chantale', 'B8765430'),
(15, 'Denton', 'Mira', 'J9801235'),
(16, 'Carlos', 'Naida', 'A1234561'),
(17, 'Dane', 'Julie', 'A1234562'),
(18, 'Peter', 'Cassidy', 'A1234368'),
(19, 'Tyler', 'Karyn', 'A1234548'),
(20, 'Levi', 'Destiny', 'A1234558'),
(21, 'Francis', 'Anastasia', 'A1236568'),
(22, 'Michael', 'Sheila', 'A1237568'),
(23, 'Cyrus', 'Kiara', 'A1234588'),
(24, 'Hector', 'Noelani', 'A1239568'),
(25, 'Rashad', 'Cleo', 'A1234508'),
(26, 'Anthony', 'Aurelia', 'A1122334'),
(27, 'Abel', 'Grace', 'A1201405'),
(28, 'Oscar', 'Frances', 'A1201406'),
(29, 'Merritt', 'Tasha', 'A1201407'),
(30, 'Abel', 'Jaquelyn', 'A1201408'),
(31, 'Stone', 'Galena', 'A1201409'),
(32, 'Ross', 'Bryar', 'A1201400'),
(33, 'Channing', 'Alexis', 'A1201414'),
(34, 'Clark', 'Athena', 'A1201424'),
(35, 'Reed', 'Germaine', 'A1201434'),
(36, 'Luke', 'Tatum', 'A1201444'),
(37, 'Peter', 'MacKenzie', 'A1201454'),
(38, 'Kevin', 'Indira', 'A1201464'),
(39, 'Alfonso', 'Zenia', 'A1201474'),
(40, 'Byron', 'Tatum', 'A1201484'),
(41, 'Bert', 'Rhea', 'A1201494'),
(42, 'Quamar', 'Fatima', 'A1201104'),
(43, 'Dennis', 'Debra', 'A1201204'),
(44, 'Tobias', 'Florence', 'A1201304'),
(45, 'Xanthus', 'Jayme', 'A1201404'),
(46, 'Rashad', 'Olga', 'A1201504'),
(47, 'Baxter', 'Zenaida', 'A1201604'),
(48, 'Stephen', 'Sage', 'A1201704'),
(49, 'Colorado', 'Mona', 'A1201804'),
(50, 'Cadman', 'Pearl', 'A1201904');
	
--------------------Room_Availability------------------------
DELETE FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Roomavailability
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Roomavailability
(Hotel_ID, Room_No, Availability_status)
VALUES
(1,11,'Yes'),
(2,38,'No'),
(3,33,'No'),
(4,35,'Yes'),
(5,32,'No'),
(6,25,'Yes'),
(7,37,'Yes'),
(8,13,'No'),
(9,40,'Yes'),
(10,21,'Yes'),
(11,13,'No'),
(12,11,'Yes'),
(13,36,'Yes'),
(14,27,'Yes'),
(15,3,'No'),
(16,35,'Yes'),
(17,34,'Yes'),
(18,36,'No'),
(19,12,'No'),
(20,31,'Yes'),
(21,27,'Yes'),
(22,20,'No'),
(23,37,'Yes'),
(24,10,'Yes'),
(25,14,'No');	
----------Restaurant-----------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Restaurant
(Airport_ID, Terminal, [Type])
VALUES(1, 'J1', 'Food Court'),
	  (2, 'K2', 'Diner'),
	  (3, 'L4', 'Brasserie'),
	  (4, 'M6', 'Bistro'),
	  (5, 'E4', 'Cafe'),
	  (6, 'P4', 'Sandwich Bar'),
	  (7, 'V4', 'Trattoria'),
	  (8, 'E9', 'Osteria'),
	  (9, 'W1', 'Cafeteria'),
	  (10, 'N1', 'Buffet'),
	  (11, 'W5', 'Pizza'),
	  (12, 'X5', 'Bar');
----------------------Seat------------------------

INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Seat
(Airplane_ID, Seat_No, Availability, Class)
VALUES(4,   1, 'Yes', 'Business'),
	  (5,   1, 'No',   'Economy'),
	  (6,   5, 'Yes', 'Business'),
	  (7,  19, 'No',   'Economy'),
	  (8,  14, 'No',   'Economy'),
	  (9,  18, 'Yes', 'Business'),
	  (10, 10, 'Yes',  'Economy'),
	  (11,  9, 'No',  'Business'),
	  (12,  3, 'Yes',  'Economy'),
	  (13, 19, 'No',  'Business'),
	  (14, 20, 'No',   'Economy'),
	  (15, 21, 'Yes', 'Business');
ALTER table RAICHURKAR_ASHUTOSH_TEST.AMS.Seat alter column Class varchar(15)
SELECT * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Seat WHERE Availability = 'No'
--------------------Room_Booking------------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Room_Booking(
Hotel_ID,Room_No ,Check_In,Check_Out ,[Acc_User_ID])
VALUES(1, 11, '2020-07-26 13:02:49','2020-07-26 09:14:49',2),
	  (4, 35,'2020-07-26 16:14:49','2020-07-26 10:14:49',3),
	  (12, 11,'2020-07-26 14:14:49','2020-07-26 06:14:49',4),
	  (16, 35,'2020-07-26 15:14:49','2020-07-26 07:14:49',5),
	  (17, 34,'2020-07-26 20:14:49','2020-07-26 20:14:49',7),
	  (23, 37,'2020-07-26 14:14:49','2020-07-26 03:14:49',9),
	  (24, 10,'2020-07-26 18:14:49','2020-07-26 02:14:49',10);
SELECT * FROM  RAICHURKAR_ASHUTOSH_TEST.AMS.Roomavailability where Availability_status = 'Yes'
DELETE FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Room_Booking
ALTER TABLE RAICHURKAR_ASHUTOSH_TEST.AMS.Room_Booking ALTER COLUMN Check_Out DATETIME
--------------------Passenger------------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger
(Fname,			Lname,		Apt,	Street,					City ,			Country,	Passport_No,	Booking_User_ID,	DOB)
VALUES
('Lee', 		'Ann',		10, 	'NEW YORK AVENUE'		,'Jacksonvill',	'USA',		'LH987645',		1,					'1978-06-8'		),
('Colorado', 	'Wendy', 	121,	'31ST STREET '			,'Fort Worth',	'USA',		'9W233467',		2,					'1989-12-18'	),
('Hamilton', 	'Fallon', 	24,		'16TH STREET '			,'Columbus',	'USA',		'A1201404',		3,					'1996-01-12'	),
('Buckminster', 'Samantha', 35,		'LENFANT PLAZA '		,'Charlotte',	'USA',		'Q1190289',		4,					'1971-02-16'	),
('Zachary', 	'Shea', 	100,	'I STREET'				,'Udaipur',		'India',	'E2123412',		5,					'1976-07-17'	),
('Donovan', 	'Suki', 	2,		'C STREET'				,'Jaisalmer',	'India',	'B3305643',		6,					'1976-07-10'	),
('Beau', 		'Deanna', 	46,		'STREET'				,'Neemrana',	'India',	'94233465',		7,					'1991-05-29'	),
('Hamish', 		'Virginia', 79,		'NEW HAMPSHIRE AVENUE' 	,'Manali',		'India',	'A5436780',		8,					'1997-12-10'	),
('Harding', 	'Meredith', 82,		'CONNECTICUT AVENUE' 	,'Hyderabad',	'India',	'R6990566',		9,					'1998-05-4'		),
('Wylie', 		'Kelsie', 	12,		'17TH STREET'			,'Mussoorie',	'India',	'B9876541',		10,					'1997-07-19'	);
ALTER TABLE RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger ALTER COLUMN Passport_No VARCHAR(50)

--------------------Passenger_Itenarary------------------------

INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Passanger_Itenarary
(Passenger_ID,	Seat_No,	Airplane_ID,	Booking_User_ID,	[Source],	[Destination] ,	Date_of_Travel)
VALUES
(1,				 1,			4,		1,		'Santacruz',		'North LA',		  '2020-01-21'	),
(2,				 5,			6 ,  	2,		'North LA',			'London',         '2020-03-11'   ),
(3,				18,			9 ,  	3,		'London',			'Pelly Bay',      '2020-06-17'   ),
(4,				10,			10, 	4,		'Pelly Bay',		'Hamburg',        '2020-03-01'    ),
(5,				 3,			12, 	5,		'Hamburg',			'Surallah',       '2020-07-01'    ),
(6,				21,			15, 	6,		'Surallah',			'Santacruz',      '2020-03-16'   );
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger_Itenarary
(Passenger_ID, Seat_No, Airplane_ID, Booking_User_ID, [Source], Destination, Date_of_Travel)
VALUES
(2,				 1,			5,		1,		'Santacruz',		'North LA',		  '2020-01-21'	),
(3,				 5,			6 ,  	2,		'North LA',			'London',         '2020-03-11'   ),
(4,				18,			9 ,  	3,		'London',			'Pelly Bay',      '2020-06-17'   ),
(5,				10,			10, 	4,		'Pelly Bay',		'Hamburg',        '2020-03-01'    ),
(6,				 3,			12, 	5,		'Hamburg',			'Surallah',       '2020-07-01'    ),
(7,				21,			15, 	6,		'Surallah',			'Santacruz',      '2020-03-16'   );
ALTER TABLE RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger_Itenarary ALTER COLUMN Seat_No VARCHAR(5)

/*
select * from AMS.Seat
select * from AMS.Airplane
select a.Airport_ID, a.Airplane_ID, b.Location, temp.Seat_No from 
(select * from AMS.Seat
where AMS.Seat.Availability = 'Yes') temp
join AMS.Access a
on a.Airplane_ID = temp.Airplane_ID
join AMS.Airport b
on b.Airport_ID = a.Airport_ID
*/
--------------------------Booking------------------------------------
INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Booking
(Booking_User_Id, AmoutDue)
VALUES
(43,  867),
(44,  678),
(45,  685),
(46,  766),
(47,  678),
(48,  987);


DROP table RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger
--DELETE FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Room_Booking
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Access
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Airline_Company
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Airplane
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Airport
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Base_fare
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Booking
--alter table RAICHURKAR_ASHUTOSH_TEST.AMS.Booking alter column Invoice_No varchar(15)
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Hotel
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Parking
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger_Itenarary
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Restaurant
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Room_Booking
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Roomavailability
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Seat
select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.[user]







