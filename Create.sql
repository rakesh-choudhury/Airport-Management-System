use RAICHURKAR_ASHUTOSH_TEST

CREATE SCHEMA AMS

-------------Airport ----------------
Create table AMS.Airport (
Airport_ID int identity Primary key,
Airport_Name varchar(50) not null,
Location varchar(50) not null,
City varchar(50) not null,
State varchar(50) not null,
Country varchar(50) not null, 
Zip varchar(10) not null
)
--------------Airplane_Company-------------

Create table AMS.Airline_Company(
Company_ID int Identity Primary key,
Company_Name varchar(50) not null
)

------------Parking--------------
Create table AMS.Parking(
Parking_ID int identity Primary key,
Airport_ID int references AMS.Airport(Airport_ID),
Terminal varchar(5),
Price int,
Time_From date,
Time_To date,
Gate_No varchar(5),
[Availability] varchar(10)
)
drop table AMS.Parking

ALTER TABLE AMS.Parking ALTER COLUMN Airport_ID int not null;



---------Restaurant----------------
create table AMS.Restaurant(
Restaurant_ID int identity primary key,
Airport_ID int references AMS.Airport(Airport_ID) not null,
Terminal varchar(5),
[Type] varchar(20)
)


---------Airplane -----------
Create table AMS.Airplane(
Airplane_ID int identity Primary key,
Seating_Capacity int,
Company_ID int references AMS.Airline_Company(Company_ID) not null,
Type_Of_Aircraft varchar(20),
Aircraft_model varchar(20)
)

---------Base Fare-------------
Create table AMS.Base_fare(
Airplane_Id int Primary key references AMS.Airplane(Airplane_ID),
Ticket_Cost int
)

--------- Seat ----------------
Create table AMS.Seat(
Airplane_ID int References AMS.Airplane(Airplane_ID) not null,
Seat_No int not null,
[Availability] varchar(20) not null,
Class int,
Primary key(Airplane_ID,Seat_No)
)

drop table AMS.Seat
---------- Access--------------
create table AMS.Access(
Airport_ID int references AMS.Airport(Airport_ID) not null,
Airplane_ID int references AMS.Airplane(Airplane_ID) not null,
primary key(Airport_ID,Airplane_ID)
)

create unique index one on AMS.Access(Airplane_ID)
drop index one on AMS.Access



----------AirSchedule-----------
Create table AMS.Air_Schedule(
AirSchedule_ID int identity Primary key,
Depart_AirplaneId int not null,
Depart_AirportID int not null,
Arrival_AirplaneId int not null,
Arrival_AirportID int not null,
Depart_Time date,
Arrival_Time date,
foreign key(Depart_AirportID,Depart_AirplaneId) references AMS.Access(Airport_ID,Airplane_ID),
foreign key(Arrival_AirportID,Arrival_AirplaneId) references AMS.Access(Airport_ID,Airplane_ID)
)

drop table AMS.Air_Schedule



-------------- User------------
Create table AMS.[user] (
Acc_User_ID int Primary key,
Fname varchar(50),
Lname varchar(50),
Passport_No varchar(50) not null
)
drop table AMS.[user]


-------------Passanger---------
Create table AMS.Passenger(
Passenger_ID int identity,
Fname varchar(50) not null,
Lname varchar(50) not null,
Apt varchar(5),
Street varchar(50),
City varchar(50) not null,
Country varchar(50) not null,
Passport_No int not null,
Booking_User_ID int references AMS.[User](Acc_User_ID),
DOB Date not null
Primary key(Passenger_ID,Booking_User_ID)
)


drop table AMS.Passenger
-----------Hotel-------------------------
Create table AMS.Hotel(
Hotel_ID int identity primary key,
Hotel_Name varchar(50),
City varchar(50),
Country varchar(50),
[Type] varchar(20)
)


--------Room Availability---------
Create table AMS.Roomavailability(
Hotel_ID int references AMS.Hotel(Hotel_ID),
Room_No int,
Availability_status varchar(20),
primary key (Hotel_ID,Room_No)
)

create unique index UI_Two on AMS.Roomavailability(Hotel_ID)
create unique index UI_Three on AMS.Roomavailability(Room_No)


--------Hotel_Booking--------------
create table AMS.Room_Booking(
Hotel_ID int not null,
Room_No int not null,
Check_In Date,
Check_Out Date,
[Acc_User_ID] int references AMS.[User](Acc_User_ID ),
foreign key(Hotel_ID,Room_No) references AMS.Roomavailability(Hotel_ID,Room_No)
)


--------- Passenger_Itenary-----------------
Create table AMS.Passenger_Itenarary(
Passenger_ID int,
Seat_No int,
Airplane_ID int,
Booking_User_ID int,
[Source] varchar(50),
[Destination] varchar(50),
Date_of_Travel Date,
foreign key(Airplane_ID,Seat_No) references AMS.Seat(Airplane_ID,Seat_No),
foreign key(Passenger_ID,Booking_User_ID) references AMS.Passenger(Passenger_ID,Booking_User_ID),
unique(Passenger_ID,Seat_No,Airplane_ID)
)

select * from AMS.Passenger_Itenarary
drop table AMS.Passenger_Itenarary

-------------Booking--------------------

Create table AMS.Booking(
Booking_ID int identity primary key,
Booking_User_Id int references AMS.[User](Acc_User_ID)
)

use RAICHURKAR_ASHUTOSH_TEST
insert into AMS.Hotel values ('Taj','Mumbai','India','5 Star')

Select * from AMS.Roomavailability

create function AMS.Available (@HotelID int, @RoomNo int)
returns smallint
as begin
Declare @one smallint = 0
select @one  = Count(Room_No) from AMS.Roomavailability 
				where Room_No = @RoomNo and Hotel_ID = @HotelID and
				Availability_status != 'Yes'
		return @one
end

Alter table AMS.Room_Booking add constraint Avail1 check(AMS.Available(Hotel_ID,Room_No)=0)


Create trigger AMS.roomavailabilitytrig on  AMS.Room_Booking
after insert
as begin
declare @RoomNo int = 0
declare @HotelId int = 0
Select @RoomNo = Room_No from Inserted
Select @HotelId = Hotel_ID from inserted
update AMS.Roomavailability set Availability_status = 'No' where Room_No = @RoomNo and Hotel_ID = @HotelId
end

select * from AMS.Roomavailability
delete from AMS.Room_Booking
insert into AMS.Room_Booking(Hotel_ID,Room_No) values(1,11)
Select * from AMS.Roomavailability


Create trigger AMS.roomavailabilitytrigDel on  AMS.Room_Booking
after Delete
as begin
declare @RoomNo int = 0
declare @HotelId int = 0
Select @RoomNo = Room_No from deleted
Select @HotelId = Hotel_ID from deleted
update AMS.Roomavailability set Availability_status = 'Yes' where Room_No = @RoomNo and Hotel_ID = @HotelId
end

Create Table AMS.Booking(
Invoice_No int identity Primary key,
Booking_User_Id int references AMS.[user](Acc_User_ID),
AmoutDue int
)


select * from AMS.Air_Schedule
Select * from AMS.Access



select * from AMS.Room_Booking
Select * from AMS.Roomavailability

delete from AMS.Room_Booking


create function AMS.Available (@HotelID int, @RoomNo int)
returns smallint
as begin
Declare @one smallint = 0
select @one  = Count(Room_No) from AMS.Roomavailability 
				where Room_No = @RoomNo and Hotel_ID = @HotelID and
				Availability_status != 'Yes'
		return @one
end

Alter table AMS.Room_Booking add constraint Avail1 check(AMS.Available(Hotel_ID,Room_No)=0)

create function AMS.SameAirplane (@DepartAirplaneID int,@ArrivalAirplaneID int)
returns smallint
as begin
Declare @return smallint =0
if @DepartAirplaneID = @ArrivalAirplaneID
	set @return = 0
else
	begin
	set @return = 1
	end
	return @return
end


alter table AMS.Air_Schedule add constraint airplaneIDcheck check(AMS.SameAirplane (Depart_AirplaneId,Arrival_AirplaneId)=0) 

------------------------------------Working Part----------------------------------------------
select * from AMS.Seat
select * from AMS.Base_fare
select * from AMS.Passenger_Itenarary
select * from AMS.Passenger
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Lee','Carleone',2,'Coventry Street','Boston','Usa','LHJK145',1,'1999-01-02')
insert into AMS.Seat values (5,3,'Yes','Economy')

Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Uday','Shetty',3,'UHSN','New York','Usa','LHJK187',1,'1975-01-02')

select * from AMS.Booking
insert into AMS.Passenger_Itenarary values(12,2,5,1,'Santacruz','North LA','2020-01-21')
insert into AMS.Passenger_Itenarary values(13,3,5,1,'Santacruz','North LA','2020-01-21')

Select Count(Passenger_ID) as [SeatCount],Airplane_ID from AMS.Passenger_Itenarary where Booking_User_ID = 1
group by Airplane_ID
select * from AMS.Base_fare

Select * from AMS.Booking
Drop table AMS.Booking
select * from AMS.[User]
insert into AMS.Booking values(1)
----------------------------------------------------------------------------------
 Create function AMS.BillCal(@UserID int)
 returns money
 as begin
 Declare @TicketCount int = 0
 Declare @AirlineID int = 0
 Declare @Ticket_Price int = 0
 Declare @Sum money = 0
 Select @TicketCount = Count(Passenger_ID) from AMS.Passenger_Itenarary where  Booking_User_ID = @UserID
 Select @AirlineID =  Airplane_ID from AMS.Passenger_Itenarary where Booking_User_ID = @UserID
 Select @Ticket_Price = Ticket_Cost from AMS.Base_fare where Airplane_Id = @AirlineID
 Set @Sum = @Ticket_Price*@TicketCount
 return @Sum
 end 

drop function AMS.BillCal

 Select AMS.BillCal(1)

Alter table AMS.Booking add TotalSum as(AMS.BillCal(Booking_User_Id))

Select * from AMS.Seat
Select * from AMS.Passenger


Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Tony','Stark',24,'Central Avenue','Los Angeles','USA','AHB198',2,'1991-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Clark','Kent',2,'Coventry Street','Boston','Usa','LHJK146',1,'1982-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Chris','Evans',31,'Burbank Street','Miami','Usa','ABGK145',2,'1999-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Keanu
','Reeves',2,'Bandra','Mumbai','India','jj1567',3,'1996-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Peter','parker',41,'Coventry Street','Huderabad','India','LHJK178',2,'1999-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Logan','Smith',67,'Park Drive','Arlington','Usa','LHJ785',1,'1991-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('John','Wick',61,'Coventry Street','Newark','Usa','LHJK189',6,'1999-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('James','Bond',20,'Olison','Boston','Usa','IIP678',1,'1978-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Oliver','Queen',89,'Tremont','Torronto','Canada','LHY781',4,'1985-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Bruce',' Wayne',27,'Coventry Street','Boston','Usa','BAT781',3,'1989-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Sheldon','Cooper',2,'Pasadena','Los Angeles','Usa','SMR145',4,'1990-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Harvey','Specter',3,'Manhattan','New York','Usa','JKL897',3,'1980-01-02')
Insert into AMS.Passenger(Fname,Lname,Apt,Street,City,Country,Passport_No,Booking_User_ID,DOB) values 
('Mike','Ross',71,'Manhattan','New York','Usa','ACXK145',2,'1980-01-02')


Select * from AMS.Passenger
Select * from AMS.Passenger_Itenarary
Select * from AMS.Seat

insert into AMS.Passenger_Itenarary values(10,5,7,9,'Los Angeles','New York','2021-09-03')
insert into AMS.Passenger_Itenarary values(16,4,10,2,'Mumbai','New York','2020-09-03')
insert into AMS.Passenger_Itenarary values(14,2,6,2,'Mumbai','New York','2021-09-03')
insert into AMS.Passenger_Itenarary values(15,3,6,1,'Mumbai','New York','2021-09-03')

Exec pro_booking

Select * from AMS.booking


Create table AMS.ParkingAvailability(
Parking_ID int Identity,
Airport_ID int references AMS.Airport(Airport_ID),
[Availability] varchar(5) not null,
Primary key (Parking_ID,Airport_ID)
)

Create table AMS.Parking_Management(
Parking_ID int not null,
Airport_ID int not null,
Car_No varchar(20) not null,
Start_Time DateTime,
End_Time DateTime,
Foreign key(Parking_ID,Airport_ID) references AMS.ParkingAvailability(Parking_ID,Airport_ID)
)

Insert into AMS.ParkingAvailability Values(1,'Yes')

Select * from AMS.ParkingAvailability

Insert into AMS.Parking_Management(Parking_ID ,Airport_ID,Car_No) values(1,1,'MH01-05-2668')

Delete from AMS.Parking_Management where Parking_ID= 1 and Airport_ID = 1

Create function AMS.CheckParkingAvail (@parking_ID int,@Airport_ID int)
returns smallint
as begin
Declare @Status varchar(10)
Declare @returns smallint  = 0
Select @Status = [Availability] from AMS.ParkingAvailability where Parking_ID = @parking_ID
and Airport_ID = @Airport_ID
if @Status = 'No'
begin
set @returns = 1
return @returns
end
return @returns
end

Exec AMS.CheckParkingAvail(1,1)

Create trigger AMS.ParkingOne on AMS.Parking_Management
after insert
as begin
Declare @ParkingID int = 0
Declare @AirportID int = 0
Select @ParkingID = Parking_ID from inserted
Select @AirportID = Airport_Id from inserted
update AMS.ParkingAvailability set [Availability] = 'No' where Parking_ID = @ParkingID
and Airport_ID = @AirportID
end

Create trigger AMS.ParkingTwo on AMS.Parking_Management
after Delete
as begin
Declare @ParkingID int = 0
Declare @AirportID int = 0
Select @ParkingID = Parking_ID from Deleted
Select @AirportID = Airport_Id from deleted
update AMS.ParkingAvailability set [Availability] = 'Yes' where Parking_ID = @ParkingID
and Airport_ID = @AirportID
end

Select * from AMS.ParkingAvailability
Select * from AMS.Parking_Management
insert into AMS.ParkingAvailability values (1,'No')
insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No) values (1,1,'MH03-AM-2668')

Select * from AMS.Airport

Select * from AMS.ParkingAvailability
insert into AMS.ParkingAvailability values (12,'Yes')

Select * from AMS.ParkingAvailability
Select * from AMS.Parking_Management

insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(3,4,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')
insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(4,4,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')
insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(5,4,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')
insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(6,4,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')
insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(7,4,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')

insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(8,5,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')

insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(9,5,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')

insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(10,6,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')

insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(11,6,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')


insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(12,7,'Massachsetts02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')

insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(13,7,'Massachsetts0289','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')
insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(14,8,'Massachsetts01889','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')
insert into AMS.Parking_Management(Parking_ID,Airport_ID,Car_No,Start_Time,End_time) values
(15,8,'NYC02789','2020-07-25 12:14:49.000','2020-07-26 10:14:49.000')


Select * from AMS.Airport
Select * from AMS.Airline_Company
Select * from


select * FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Parking





Select * from AMS.Room_Booking
Select * from AMS.Roomavailability

Insert into AMS.Room_Booking(Hotel_ID,Room_No,Check_In,Check_Out,Acc_User_ID) values 
(16,35,'2020-07-26 13:02:49.000','2020-07-26 13:02:49.000',2)

Insert into AMS.Room_Booking(Hotel_ID,Room_No,Check_In,Check_Out,Acc_User_ID) values 
(4,35,'2020-07-26 13:02:49.000','2020-07-26 13:02:49.000',14)

Insert into AMS.Room_Booking(Hotel_ID,Room_No,Check_In,Check_Out,Acc_User_ID) values 
(17,34,'2020-07-26 13:02:49.000','2020-07-26 13:02:49.000',13)


Insert into AMS.Room_Booking(Hotel_ID,Room_No,Check_In,Check_Out,Acc_User_ID) values 
(23,37,'2020-07-26 13:02:49.000','2020-07-26 13:02:49.000',14)

Insert into AMS.Room_Booking(Hotel_ID,Room_No,Check_In,Check_Out,Acc_User_ID) values 
(24,10,'2020-07-26 13:02:49.000','2020-07-26 13:02:49.000',14)
