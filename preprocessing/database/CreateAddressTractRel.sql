ALTER TABLE dbo.Address
   ADD CONSTRAINT FK_Address_Tract FOREIGN KEY (TractID)
      REFERENCES dbo.Tract (TractID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;