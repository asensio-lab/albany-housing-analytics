DROP USER IF EXISTS test

CREATE USER [test]
FOR LOGIN [test]
WITH DEFAULT_SCHEMA=dbo;
GO

-- add user to role(s) in db 
ALTER ROLE db_datareader ADD MEMBER [test]; 
ALTER ROLE db_datawriter ADD MEMBER [test]; 
ALTER ROLE db_ddladmin ADD MEMBER[test]