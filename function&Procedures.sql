------Room Availibility
create function AMS.Available (@HotelID int, @RoomNo int)
returns smallint
as begin
Declare @one smallint = 0
select @one  = Count(Room_No) from AMS.Roomavailability 
				where Room_No = @RoomNo and Hotel_ID = @HotelID and
				Availability_status != 'Yes'
		return @one
end
-------Bill Calculation
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

 -----Parking Availibility
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
---------Check for same airplane id
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
-----------Updating the transaction table
create procedure AMS.pro_booking
AS
BEGIN
	delete from RAICHURKAR_ASHUTOSH_TEST.AMS.Booking
	INSERT INTO RAICHURKAR_ASHUTOSH_TEST.AMS.Booking
	select Acc_User_ID from RAICHURKAR_ASHUTOSH_TEST.AMS.[user];	
END



















