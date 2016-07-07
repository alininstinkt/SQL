DECLARE @tbl TABLE (ID INT PRIMARY KEY IDENTITY(1,1),Nume NVARCHAR(50), Varsta INT null)


INSERT INTO @tbl (Nume,Varsta) VALUES ('Marcel 2 sql',null)

INSERT INTO @tbl (Nume,Varsta)

VALUES('Alexandra',21), ('Madalina','26')

SELECT *
FROM @tbl


