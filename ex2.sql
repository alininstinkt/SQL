USE [AdventureWorks2014]
GO

DECLARE @RC int
DECLARE @ID int ='asdas'

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[uspTest] 
   @ID
GO


