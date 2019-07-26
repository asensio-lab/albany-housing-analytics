ALTER TABLE dbo.Utility
   ADD CONSTRAINT FK_Utility_Address FOREIGN KEY (AddressID)
      REFERENCES dbo.Address (AddressID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;