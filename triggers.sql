--------------Air Schedule-----------------
CREATE   TRIGGER t_air_schedule
On RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule
After INSERT 
AS
BEGIN 
	DECLARE @airvalid int
	SET @airvalid = (SELECT Arrival_AirportID FROM Inserted) 
	DECLARE @arrival_name varchar(50)
	SET @arrival_name = (SELECT Airport_Name FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Airport
							where Airport_ID = @airvalid)
	DECLARE @departid int 
	DECLARE @schid int
	SET @departid = (SELECT Depart_AirportID FROM Inserted)
	SET @schid = (SELECT AirSchedule_ID FROM Inserted)
	if (@departid = @airvalid)
		BEGIN
			Raiserror('The source and destination cannot be same',16,1)
			DELETE FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Air_Schedule where AirSchedule_ID = @schid 
		END
	ELSE 
	
	UPDATE 
	Air_Schedule
	SET Arrival_Airport_Name = @arrival_name WHERE Arrival_AirportID = @airvalid
	
	
	DECLARE @depart_name varchar(50)
	SET @depart_name = (SELECT Airport_Name FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Airport
						where Airport_ID = @departid)
	UPDATE 
	AMS.Air_Schedule 
	SET Depart_Airport_Name = @depart_name where Depart_AirportID  = @departid 
END
--------------Parking--------------------
--1st Trigger
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
--2nd Trigger
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
-----------------Room Availibility------------------------
---insertion trigger
Create trigger AMS.roomavailabilitytrig on  AMS.Room_Booking
after insert
as begin
declare @RoomNo int = 0
declare @HotelId int = 0
Select @RoomNo = Room_No from Inserted
Select @HotelId = Hotel_ID from inserted
update AMS.Roomavailability set Availability_status = 'No' where Room_No = @RoomNo and Hotel_ID = @HotelId
end
--Deletion trigger
Create trigger AMS.roomavailabilitytrigDel on  AMS.Room_Booking
after Delete
as begin
declare @RoomNo int = 0
declare @HotelId int = 0
Select @RoomNo = Room_No from deleted
Select @HotelId = Hotel_ID from deleted
update AMS.Roomavailability set Availability_status = 'Yes' where Room_No = @RoomNo and Hotel_ID = @HotelId
end

