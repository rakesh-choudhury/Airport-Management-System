
-------------Passenger Amount Due----------------------------------
CREATE view AMS.Passenger_Amount_Due
AS
SELECT p.Booking_User_ID, 
	   p.Fname + ' ' + p.Lname as 'Passenger Full Name',
	   p.Apt + ', ' + p.City + ', ' + p.Country as 'Passenger Address',
	   DATEDIFF(hour,p.DOB, GETDATE())/8766 as 'Age',
	   b.TotalSum as 'Amount Due'
FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger p
join RAICHURKAR_ASHUTOSH_TEST.AMS.Booking b on b.Booking_User_Id = p.Booking_User_ID 


--------------Flight ETA---------------------
CREATE view AMS.Passenger_ETA
AS
SELECT p.Fname + ' ' + p.Lname as [Passenger Name],
	   pi.[Source],
	   pi.Destination, 
	   cast(((DATEDIFF(SECOND, pi.Date_of_Travel, '2020-07-27 14:14:49')/3600)/24) as varchar(5)) +' Day, ' +
	   cast(((DATEDIFF(SECOND, pi.Date_of_Travel, '2020-07-27 14:14:49')/3600)%24) as varchar(5)) +' Hours' as [ETA]
FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger p
join RAICHURKAR_ASHUTOSH_TEST.AMS.Passenger_Itenarary pi on pi.Booking_User_ID = p.Booking_User_ID

--------------Restaurants--------------------

CREATE view AMS.Restaurant_Locations
AS

SELECT CASE WHEN A.State = 'MA'
		then 'Massachusetts'
	    WHEN A.State = 'CA'
		then 'California'
		WHEN A.State = 'Banglore'
		then 'Maharashtra'
		 WHEN A.State = 'IJ'
		then 'Oklahoma'
		 WHEN A.State = 'LH'
		then 'Scotland'
		 WHEN A.State = 'LHH'
		then 'Ontario'
		 WHEN A.State = 'PKR'
		then 'Goa'
		 WHEN A.State = 'ZMB'
		then 'Brandenburg'
		 WHEN A.State = 'AAF'
		then 'Maryland'
		 WHEN A.State = 'RD'
		then 'Altai'
		 WHEN A.State = 'JH'
		then 'Cordillera'
		WHEN A.State = 'Maharashtra'
		THEN 'Maharashtra'
		end as State_Names, R.Restaurant_ID, R.Airport_ID, R.Terminal, R.[Type],
		A.Airport_Name, A.Location, A.City,
		A.Country, A.Zip
		
		FROM RAICHURKAR_ASHUTOSH_TEST.AMS.Restaurant R 
JOIN RAICHURKAR_ASHUTOSH_TEST.AMS.Airport A ON R.Airport_ID = A.Airport_ID 


------------------------Airport Info----------------------------
CREATE VIEW AMS.vwAirportInfo 
AS 
SELECT [Depart_AirplaneId] as Flight_ID, asch.[Arrival_Airport_Name] as Destination, cast(cast(asch.[Depart_Time] as time) as varchar(5)) as DepartureTime  from [AMS].[Air_Schedule] asch
inner join [AMS].[Airport] ap
on ap.[Airport_ID] = asch.[Depart_AirportID]
where asch.[Depart_Airport_Name] = 'CSIA' and (CONVERT(VARCHAR(10), [Depart_Time], 111)) = '2020/07/26'
















