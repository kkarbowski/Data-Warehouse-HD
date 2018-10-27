DECLARE @Narzut FLOAT
SET @Narzut = 1.07

UPDATE c SET c.CenaNettoAktualna = pz.CenaNetto*@Narzut
FROM dbo.Czesci c, dbo.PozycjaZamowienia pz, dbo.Zamowienia z
WHERE c.CzescID = pz.FK_Czesc AND
pz.FK_Zamowienie = z.ZamowienieID AND
z.DataRealizacjiZamowienia = (
	SELECT MAX(DataRealizacjiZamowienia) FROM dbo.Zamowienia WHERE ZamowienieID = pz.FK_Zamowienie
)

UPDATE dbo.Czesci SET StanMagazynowy = ABS(CHECKSUM(NEWID()))%20 + 5

UPDATE dbo.Klienci SET Imie = NULL, Nazwisko = NULL WHERE NazwaFirmy IS NOT NULL
