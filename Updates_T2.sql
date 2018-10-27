UPDATE dbo.Dostawcy SET NumerTelefonu = ABS(CHECKSUM(NEWID()))

UPDATE dbo.Klienci SET Nazwisko = 'Wielki' WHERE KlientID = 4
UPDATE dbo.Klienci SET Nazwisko = 'Ma³y' WHERE KlientID = 5
UPDATE dbo.Klienci SET Nazwisko = 'Szeroki' WHERE KlientID = 6
UPDATE dbo.Klienci SET Nazwisko = 'Du¿y' WHERE KlientID = 7
UPDATE dbo.Klienci SET Nazwisko = 'Niski' WHERE KlientID = 8

UPDATE dbo.Pracownicy SET Stanowisko = 'Blacharz' WHERE PracownikID = 3
UPDATE dbo.Pracownicy SET Stanowisko = 'Biurowy' WHERE PracownikID = 4