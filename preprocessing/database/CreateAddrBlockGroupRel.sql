ALTER TABLE dbo.Address
   ADD CONSTRAINT FK_Address_BlockGroup FOREIGN KEY (BlockGroupID)
      REFERENCES dbo.BlockGroup (BlockGroupID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;