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
		   '1999-04-27'),
		   ('Vivian Eubanks',
		   '2001-08-23'),
		   ('Joseph Vargas',
		   '1952-02-07'),
		   ('Francis Davis',
		   '1985-11-14'),
		   ('Ruth Byrd',
		   '1967-03-16')
GO

INSERT INTO [dbo].[Genre]
           ([name])
     VALUES
           ('Fantasie'),
		   ('Science-Fiction'),
		   ('Liebesroman'),
		   ('Familienroman'),
		   ('Reiseroman'),
		   ('Historischer Roman'),
		   ('Thriller/Gruselromane')
GO

INSERT INTO [dbo].[Verlag]
           ([name]
           ,[standort])
     VALUES
           ('Novum','Luzern'),
		   ('Klett','Berlin'),
		   ('Droemer','Bern'),
		   ('Fischer','Rom'),
		   ('Cornelsen','Hamburg'),
		   ('Beck','Basel'),
		   ('Bastei','Paris')
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
           ,(select Id from Verlag where Verlag.name like 'Novum')),
		    ('Fischers Abenteuer'
           ,420
           ,3
           ,'2011-07-08'
           ,0
           ,5.7
           ,(select Id from Genre where Genre.name like 'Fantasie')
           ,(select Id from Autor where Autor.name like 'Joseph Vargas')
           ,(select Id from Verlag where Verlag.name like 'Fischer')),
		    ('Zappa und das Haus des Schreckens'
           ,361
           ,19
           ,'2010-01-17'
           ,1
           ,3.4
           ,(select Id from Genre where Genre.name like 'Thriller/Gruselromane')
           ,(select Id from Autor where Autor.name like 'Joseph Vargas')
           ,(select Id from Verlag where Verlag.name like 'Fischer')),
		    ('Heinis fantastische Tierwesen'
           ,187
           ,2
           ,'2015-09-12'
           ,0
           ,5.1
           ,(select Id from Genre where Genre.name like 'Fantasie')
           ,(select Id from Autor where Autor.name like 'Samuel Beckett')
           ,(select Id from Verlag where Verlag.name like 'Klett')),
		   	('Der gefallene Goller'
           ,69
           ,6
           ,'2019-03-21'
           ,1
           ,2.3
           ,(select Id from Genre where Genre.name like 'Science-Fiction')
           ,(select Id from Autor where Autor.name like 'Vivian Eubanks')
           ,(select Id from Verlag where Verlag.name like 'Fischer')),
		   ('Hollbach der Halbblutprinz'
           ,1012
           ,21
           ,'2014-11-12'
           ,1
           ,5.8
           ,(select Id from Genre where Genre.name like 'Historischer Roman')
           ,(select Id from Autor where Autor.name like 'Vivian Eubanks')
           ,(select Id from Verlag where Verlag.name like 'Cornelsen'))
GO