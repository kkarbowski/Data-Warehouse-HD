DECLARE @id INT

IF OBJECT_ID('tempdb..#tmp1') IS NOT NULL
DROP TABLE #tmp1

SELECT s.SerwisID, CASE WHEN k.NazwaFirmy IS NOT NULL THEN k.NazwaFirmy ELSE k.Imie END as 'Imie/Nazwa firmy', k.Nazwisko,  CONVERT(VARCHAR(16),s.DataRozpoczeciaSerwisu,120) AS 'Data i godzina wizyty', u.RodzajUsterki, '' AS 'Inne', 'NIE' AS 'Odwolane'
INTO #tmp1
FROM  dbo.Klienci k, dbo.Pojazdy p,
dbo.Serwisy s LEFT JOIN dbo.Usterki u ON u.FK_Serwis = s.SerwisID
WHERE s.FK_Pojazd = p.VIN AND
p.FK_Klient = k.KlientID


DELETE x
FROM (SELECT *, rn=row_number() over (partition by SerwisID order by SerwisID) FROM #tmp1) x
WHERE rn > 1

SET @id = (SELECT COUNT(*) FROM #tmp1)

INSERT INTO #tmp1
SELECT TOP(@id/10 + 1) @id + ROW_NUMBER() OVER(ORDER BY SerwisID),CASE WHEN k.NazwaFirmy IS NOT NULL THEN k.NazwaFirmy ELSE k.Imie END, k.Nazwisko, CONVERT(VARCHAR(16),s.DataRozpoczeciaSerwisu,120), u.RodzajUsterki, '', 'TAK'
FROM dbo.Klienci k, dbo.Pojazdy p,
dbo.Serwisy s LEFT JOIN dbo.Usterki u ON u.FK_Serwis = s.SerwisID
WHERE s.FK_Pojazd = p.VIN AND
p.FK_Klient = k.KlientID

UPDATE #tmp1 SET RodzajUsterki = 'Napêd' WHERE RodzajUsterki IS NULL

SELECT * FROM #tmp1
ORDER BY SerwisID