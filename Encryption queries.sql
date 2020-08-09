USE RAICHURKAR_ASHUTOSH_TEST;

-- Create DMK
CREATE MASTER KEY 
ENCRYPTION BY PASSWORD = 'Test_Password';

--Create Certificate to protect symmetric key
CREATE CERTIFICATE AMSCertificate
WITH SUBJECT = 'AMS Certificate',
EXPIRY_DATE = '2025-10-31'

--Create symmetric key to encrypt data
CREATE SYMMETRIC KEY AMSSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE AMSCertificate


--Open Symmetric Key
OPEN SYMMETRIC KEY AMSSymmetricKey
DECRYPTION BY CERTIFICATE AMSCertificate

--Alter User table to add Password column
Alter table AMS.[User] ADD UserPassword VARCHAR(250);

--Check the columns in updated User table 
SELECT * FROM AMS.[User];

-- Update values for existing data using Cursor
DECLARE 
cur Cursor
FOR SELECT acc_user_id FROM AMS.[User];
DECLARE @userID int;
OPEN cur
FETCH NEXT FROM cur INTO @userID;
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE AMS.[user]
	set userPassword = EncryptByKey(Key_GUID(N'AMSSymmetricKey'), 
									(SELECT Lname+'Password'+SUBSTRING(Passport_No,1,3) from ams.[user] where Acc_User_ID = @userID))
	where Acc_User_ID = @userID;
	FETCH NEXT FROM cur INTO @userID;
END;
CLOSE cur;
DEALLOCATE cur;

--Check the decrypted password
Select *, CONVERT(VARCHAR,DecryptByKey(UserPassword)) "Decrypted Password"
from ams.[user];

--Create a trigger on AMS.[User] table to encrypt the user password whenever a new data is inserted

CREATE OR ALTER Trigger EncryptUserPassword
ON AMS.[User]
AFTER INSERT 
AS
BEGIN
	UPDATE AMS.[User]
	SET UserPassword = EncryptByKey(Key_GUID(N'AMSSymmetricKey'), (SELECT UserPassword from inserted))
	WHERE Acc_User_ID = (select Acc_User_ID from inserted)
END;

