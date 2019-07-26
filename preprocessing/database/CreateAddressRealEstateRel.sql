ALTER TABLE dbo.Address
   ADD CONSTRAINT FK_Address_RealEstate FOREIGN KEY (RealEstateID)
      REFERENCES dbo.RealEstate (RealEstateID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;