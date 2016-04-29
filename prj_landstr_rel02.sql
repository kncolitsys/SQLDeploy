USE {database};
GO

/* für das Admininterface und weitere Mandatesanpassungen */
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Applications_Mandates' AND COLUMN_NAME='CountryCode')
ALTER TABLE Applications_Mandates DROP COLUMN CountryCode;
ALTER TABLE Applications_Mandates ADD CountryCode NVARCHAR(2);
GO

DELETE FROM Applications_Mandates WHERE [ApplicationId] = 88;
INSERT INTO Applications_Mandates (MandateID, ApplicationId) VALUES (2, 88);
INSERT INTO Applications_Mandates (MandateID, ApplicationId) VALUES (1, 88);
GO

DELETE FROM Applications_Mandates WHERE [ApplicationId] = 0;
INSERT INTO Applications_Mandates (MandateID, ApplicationId) VALUES (2, 0);
INSERT INTO Applications_Mandates (MandateID, ApplicationId) VALUES (1, 0);
GO

UPDATE Applications_Mandates SET CountryCode = 
CASE
	WHEN MandateID = {Mandant_1:ID} THEN '{Mandant_1:Code}'
	WHEN MandateID = {Mandant_2:ID} THEN '{Mandant_2:Code}'
	WHEN MandateID = {Mandant_3:ID} THEN '{Mandant_3:Code}'
END;