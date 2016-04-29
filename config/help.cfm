<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>*** - [***]</title>
	<link rel="stylesheet" media="screen"    href="skins/screen.css">
	<link rel="stylesheet" media="print"     href="skins/print.css">
	<link rel="stylesheet" media="handheld"  href="skins/handheld.css">
</head>

<body>

Here is a very short description on how to use the Deployment-System:<br /><br />
- The VAR {database} within an SQL-Statement is allways available<br />
- Any further VARs could be defined win the variables.ini like:<br />
  [language]<br />
	us=helpfile<br />
	de=hilfedatei<br />
  and will be used in the statement like:<br />
  {language:us} oder {language:de}<br /><br />

- An SQL-Stement could be like this (the GO statement must allways stand alone on one line):<br /><br />
USE {database};<br />
GO<br /><br />

/* für das Admininterface und weitere Mandatesanpassungen */<br />
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Applications_Mandates' AND COLUMN_NAME='CountryCode')<br />
ALTER TABLE Applications_Mandates DROP COLUMN CountryCode;<br />
ALTER TABLE Applications_Mandates ADD CountryCode NVARCHAR(2);<br />
GO<br /><br />

DELETE FROM Applications_Mandates WHERE [ApplicationId] = 88;<br />
INSERT INTO Applications_Mandates (MandateID, ApplicationId) VALUES (2, 88);<br />
INSERT INTO Applications_Mandates (MandateID, ApplicationId) VALUES (1, 88);<br />
GO<br /><br />

DELETE FROM Applications_Mandates WHERE [ApplicationId] = 0;<br />
INSERT INTO Applications_Mandates (MandateID, ApplicationId) VALUES (2, 0);<br />
INSERT INTO Applications_Mandates (MandateID, ApplicationId) VALUES (1, 0);<br />
GO<br /><br />

UPDATE Applications_Mandates SET CountryCode = <br />
CASE<br />
	WHEN MandateID = {Mandant_1:ID} THEN '{Mandant_1:Code}'<br />
	WHEN MandateID = {Mandant_2:ID} THEN '{Mandant_2:Code}'<br />
	WHEN MandateID = {Mandant_3:ID} THEN '{Mandant_3:Code}'<br />
END;<br /><br />

</body>
</html>