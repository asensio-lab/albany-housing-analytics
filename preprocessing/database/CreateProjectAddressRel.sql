ALTER TABLE dbo.HousingProject
   ADD CONSTRAINT FK_Project_Address FOREIGN KEY (AddressID)
      REFERENCES dbo.Address (AddressID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;