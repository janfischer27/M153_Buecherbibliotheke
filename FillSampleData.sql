USE [Bibliotheke]
GO

INSERT INTO [dbo].[Autor]
           ([name]
           ,[jahrgang])
     VALUES
           ('Hans Christian'
           ,'1980-01-01'),
		   ('Jane Schulz',
		   '1988-05-18'),
		   ('Samuel Beckett',
		   '1999-04-27')
GO

INSERT INTO [dbo].[Genre]
           ([name])
     VALUES
           ('Fantasie'),
		   ('Science-Fiction'),
		   ('Liebesroman')
GO

INSERT INTO [dbo].[Verlag]
           ([name]
           ,[standort])
     VALUES
           ('Novum'
           ,'Luzern'),
		   ('Klett','Berlin')
GO

INSERT INTO [dbo].[Bücher]
           ([titel]
           ,[anzahlSeiten]
           ,[inStock]
           ,[erscheinungsdatum]
           ,[altersfreigabe]
           ,[bewertung]
           ,[fk_GenreId]
           ,[fk_AutorId]
           ,[fk_VerlagId])
     VALUES
           ('Andersens Märchen'
           ,512
           ,6
           ,'2020-04-07'
           ,0
           ,5.4
           ,(select Id from Genre where Genre.name like 'Liebesroman')
           ,(select Id from Autor where Autor.name like 'Hans Christian')
           ,(select Id from Verlag where Verlag.name like 'Klett')),
		   ('Stolz und Vorurteil'
           ,310
           ,12
           ,'2029-04-08'
           ,1
           ,4.6
           ,(select Id from Genre where Genre.name like 'Liebesroman')
           ,(select Id from Autor where Autor.name like 'Jane Schulz')
           ,(select Id from Verlag where Verlag.name like 'Novum'))
GO