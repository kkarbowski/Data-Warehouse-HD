SELECT wt.WydatkiData, SUM(wt.Wydatki) * 0.9 FROM(
	SELECT CONVERT(VARCHAR(7),s.DataZakonczeniaSerwisu,120) AS WydatkiData, upz.CenaNetto AS Wydatki
	FROM dbo.Usterka_PozycjaZam upz, dbo.Serwisy s, dbo.Usterki u
	WHERE upz.FK_Usterka = u.UsterkaID AND
	u.FK_Serwis = s.SerwisID
	UNION ALL
	SELECT CONVERT(VARCHAR(7),s.DataZakonczeniaSerwisu,120) AS WydatkiData, su.CenaNetto AS Wydatki
	FROM dbo.Serwis_Usluga su, dbo.Serwisy s
	WHERE su.FK_Serwis = s .SerwisID) wt
GROUP BY wt.WydatkiData