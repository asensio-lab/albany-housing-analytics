ALTER TABLE dbo.Utility
   ADD CONSTRAINT FK_Utility_Address FOREIGN KEY (AddressID)
      REFERENCES dbo.Address (AddressID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE dbo.HousingProject
   ADD CONSTRAINT FK_Project_Address FOREIGN KEY (AddressID)
      REFERENCES dbo.Address (AddressID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE dbo.Address
   ADD CONSTRAINT FK_Address_Tax FOREIGN KEY (TaxID)
      REFERENCES dbo.Tax (TaxID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE dbo.AddressJunctBG
    ADD CONSTRAINT FK_AddressJunctBG_Address FOREIGN KEY (AddressID)
      REFERENCES dbo.Address (AddressID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE dbo.AddressJunctBG
    ADD CONSTRAINT FK_AddressJunctBG_BG FOREIGN KEY (BlockGroupID)
      REFERENCES dbo.BlockGroup(BlockGroupID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE dbo.BGJunctTract
    ADD CONSTRAINT FK_BGJunctTract_BG FOREIGN KEY (BlockGroupID)
      REFERENCES dbo.BlockGroup (BlockGroupID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE dbo.BGJunctTract
    ADD CONSTRAINT FK_AddressJunctBG_Tract FOREIGN KEY (TractID)
      REFERENCES dbo.Tract (TractID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

