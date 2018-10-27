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
SELECT TOP(@id/10 + 1) @id + ROW_NUMBER() OVER(ORDER BY SerwisID), MAX(CASE WHEN k.NazwaFirmy IS NOT NULL THEN k.NazwaFirmy ELSE k.Imie END), MAX(k.Nazwisko),  MAX(CONVERT(VARCHAR(16),s.DataRozpoczeciaSerwisu,120)), MAX(u.RodzajUsterki), '', 'TAK'
FROM dbo.Serwisy s, dbo.Klienci k, dbo.Pojazdy p, dbo.Usterki u
WHERE s.FK_Pojazd = p.VIN AND
p.FK_Klient = k.KlientID AND
U.FK_Serwis = s.SerwisID
GROUP BY s.SerwisID

SELECT * FROM #tmp1
ORDER BY SerwisID