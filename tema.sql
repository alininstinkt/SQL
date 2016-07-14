------------------------Cerinta 1--------------------------------------
--incasarile obtinute de la clientii mall-ului prin utilizarea parcarii
-- pe o luna, zi, an. Am ales ziua 14 pentru prima varianta, luna 7 
--adica Iulie pentru a doua varianta si anul 2016 pentru a treia varianta--

--Incasari pentru ziua 14--
SELECT SUM(CEILING(Durata-2))*2 AS [Incasare ziua 14] 
FROM Vizite 
WHERE Durata > 2
AND DAY(DataSosire) = 14

-- Incasarile pentru luna Iulie--
SELECT SUM(CEILING(Durata-2))*2 AS [Incasare Iulie]
FROM Vizite 
WHERE Durata > 2
AND MONTH(DataSosire) = 7

-- Incasarile pentru anul 2016
SELECT SUM(CEILING(Durata-2))*2 AS [Incasare 2016]
FROM Vizite 
WHERE Durata > 2
	AND YEAR(DataSosire) = 2016



------------------------Cerinta 2----------------------------------------------------------------------
--care este intervalul orar cu cei mai multi utilizatori ai parcarii (cand sunt cele mai multe masini)--
-- m-am axat pe masinile care intra in parcare intr-un interval de 3 ore--
SELECT TOP 1
		DATEPART(HOUR, DataSosire) AS OraSosire,
		DATEPART(HOUR, DataSosire) + 3 AS OraPlecare ,
		COUNT(*) as NumarVizite
FROM Vizite
GROUP BY DATEPART(HOUR,DataSosire)
ORDER BY COUNT(*) DESC


------------------------Cerinta 3----------------------------------------------------------------------
--- care este media de utilizare a parcarii pe parcursul unei zile-- 
--(cate masini sunt in medie in fiecare ora de pe parcursul unei zile)--
-- am calculat cate masini vin in medie in fiecare interval al unei zile--
SELECT
	v.Ora as Ora1,
	v.Ora + 1 as Ora2,
	(SUM(v.NumarMasini))/COUNT(v.Zi) as NumarMasini
FROM
(
SELECT
	DATEPART(HOUR, DataSosire) as Ora,
	DATEPART(DAY, DataSosire) as Zi,
	COUNT(*) as NumarMasini
FROM Vizite
GROUP BY DATEPART(HOUR, DataSosire),
		 DATEPART(DAY, DataSosire),
		 DATEPART(MONTH, DataSosire),
		 DATEPART(YEAR, DataSosire)
) v
GROUP BY v.Ora



------------------------Cerinta 4------------------------------------------
--- care este media de utilizare a parcarii pe parcursul unei saptamani/an--
--prima varianta voi considera cate masini intra in parcare in medie in
-- fiecare zi, in a doua varianta cate masini intra in parcare in medie
--in fiecare saptamana, iar in a treia varianta cate masini intra in parcare
--in medie in fiecare an)


------------Prima varianta--------------
SELECT
		(SUM(z.TotalVizite))/COUNT(z.NumarZi) AS MedieMasiniPeZi
FROM
(
		SELECT 
			DATEPART(DAY, DataSosire) AS NumarZi,
		    COUNT(DataSosire) AS TotalVizite
		FROM Vizite
		GROUP BY DATEPART(DAY, DataSosire), 
				 DATEPART(MONTH, DataSosire),
				 DATEPART(YEAR,DataSosire)
)z



------------A doua varianta--------------
SELECT 
	(SUM(s.TotalVizite))/COUNT(s.NumarSaptamana) AS MedieMasiniPeSaptamana
FROM
(
	SELECT 
			DATEPART(WK, DataSosire) AS NumarSaptamana,
			COUNT(DataSosire) AS TotalVizite	
	FROM dbo.vizite
	GROUP BY DATEPART(WK, DataSosire), 
	         DATEPART(YEAR,DataSosire)
) s


------------A treia varianta--------------
SELECT 
	(SUM(a.TotalVizite))/COUNT(a.DataSosire) as MedieMasiniPeAn
FROM
(
	SELECT 
		DATEPART(YEAR, DataSosire) AS DataSosire,
		COUNT(DataSosire) AS TotalVizite
	FROM Vizite
	GROUP BY DATEPART(YEAR, DataSosire)
) a



------------------------Cerinta 5------------------------------------------
--- - care este cel mai fidel client 
--(cine utilizeaza cel mai mult parcarea)
SELECT TOP 1 
			vizite.MasinaID,
			producator.Nume AS Producator ,
			Producator.Activ AS PoducatorActiv,
			model.Nume AS Model,
			model.An,
			model.Activ AS ModelActiv,
			masini.Culoare,
			masini.NrInmnatriculare,
			vizite.TotalVizite		
FROM
(
	SELECT MasinaId,
		   COUNT(*) AS TotalVizite
	FROM dbo.Vizite
	GROUP BY MasinaID
)vizite
INNER JOIN Masini masini ON  masini.ID = vizite.MasinaID
INNER JOIN Model model ON model.ID = masini.ModelID
INNER JOIN Producator producator ON producator.ID = model.ProducatorID




------------------------Cerinta 6-------------------------------
-- durata medie petrecuta de masini in parcare
--am considerat timpul a fi exprimt in ore
SELECT AVG(Durata) AS DurataMedie
FROM Vizite



------------------------Cerinta 7-------------------------------
--care este a fost cea mai aglomerata zi din anul 
--2016 in ceea ce priveste parcarea

SELECT TOP 1
			DATEPART(DAY, DataSosire) AS Zi,
		    DATEPART(MONTH, DataSosire) AS Luna, 
		    COUNT(DATEPART(DAY,DataSosire)) AS TotalVizitatori
FROM Vizite
WHERE DATEPART(YEAR,DataSosire) = 2016
GROUP BY DATEPART(DAY,DataSosire), 
		 DATEPART(MONTH, DataSosire)
		 
------------------------Cerinta 8-------------------------------
--care este cea mai plina zi din saptamana (L, M, M) si 
--care interval orar
SELECT TOP 1 
	a.ZiuaDinSaptamana,
    (SUM(a.NumarMasini))/COUNT(a.ZiuaDinSaptamana) as TotalVizite
	
FROM
(
	SELECT
		DATENAME(DW,DataSosire) AS ZiuaDinSaptamana,
		COUNT(DATENAME(DW, DataSosire)) AS NumarMasini
	FROM Vizite
	GROUP BY DATENAME(DW,DataSosire), 
		 DATENAME(WK, DataSosire),
		 DATENAME(YEAR, DataSosire)
) a
GROUP BY a.ZiuaDinSaptamana
ORDER BY TotalVizite DESC




