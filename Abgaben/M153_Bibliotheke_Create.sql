-- *********************
-- DATENBANK ERSTELLEN
-- *********************

DROP DATABASE IF EXISTS Bibliotheke
GO

CREATE DATABASE Bibliotheke
GO

USE Bibliotheke
GO

CREATE TABLE "Bücher"(
    "id" INT NOT NULL IDENTITY(1,1),
    "titel" NVARCHAR(255) NOT NULL,
    "anzahlSeiten" INT NOT NULL,
    "inStock" INT NOT NULL,
    "erscheinungsdatum" DATE NOT NULL,
    "altersfreigabe" BIT NULL,
    "bewertung" DECIMAL(8, 2) NULL,
    "fk_GenreId" INT NOT NULL,
    "fk_AutorId" INT NOT NULL,
    "fk_VerlagId" INT NOT NULL
);
ALTER TABLE
    "Bücher" ADD CONSTRAINT "bücher_id_primary" PRIMARY KEY("id");
CREATE TABLE "Autor"(
    "id" INT NOT NULL IDENTITY(1,1),
    "name" NVARCHAR(255) NOT NULL,
    "jahrgang" DATE NULL
);
ALTER TABLE
    "Autor" ADD CONSTRAINT "autor_id_primary" PRIMARY KEY("id");
CREATE TABLE "Genre"(
    "id" INT NOT NULL IDENTITY(1,1),
    "name" NVARCHAR(255) NOT NULL
);
ALTER TABLE
    "Genre" ADD CONSTRAINT "genre_id_primary" PRIMARY KEY("id");
CREATE TABLE "Verlag"(
    "id" INT NOT NULL IDENTITY(1,1),
    "name" NVARCHAR(255) NOT NULL,
    "standort" NVARCHAR(255) NOT NULL
);
ALTER TABLE
    "Verlag" ADD CONSTRAINT "verlag_id_primary" PRIMARY KEY("id");
CREATE TABLE "bestSeller"(
    "id" INT NOT NULL IDENTITY(1,1),
    "fk_BuchId" INT NOT NULL,
    "verkaufszahl" INT NOT NULL
);
ALTER TABLE
    "bestSeller" ADD CONSTRAINT "bestseller_id_primary" PRIMARY KEY("id");
ALTER TABLE
    "Bücher" ADD CONSTRAINT "bücher_fk_autorid_foreign" FOREIGN KEY("fk_AutorId") REFERENCES "Autor"("id");
ALTER TABLE
    "Bücher" ADD CONSTRAINT "bücher_fk_genreid_foreign" FOREIGN KEY("fk_GenreId") REFERENCES "Genre"("id");
ALTER TABLE
    "Bücher" ADD CONSTRAINT "bücher_fk_verlagid_foreign" FOREIGN KEY("fk_VerlagId") REFERENCES "Verlag"("id");
ALTER TABLE
    "bestSeller" ADD CONSTRAINT "bestseller_fk_buchid_foreign" FOREIGN KEY("fk_BuchId") REFERENCES "Bücher"("id");

GO


-- *********************
-- TRIGGER ERSTELLEN
-- *********************

Drop Trigger if Exists dropAllBooksFromAuthor
GO

Create Trigger dropAllBooksFromAuthor on autor instead of delete as
begin
 DECLARE @buchId int = (SELECT Bücher.id FROM deleted join Bücher on deleted.id = Bücher.fk_AutorId);
 DECLARE @autorId int = (SELECT id FROM deleted);
	
 delete from bestSeller where bestSeller.fk_BuchId IN (@buchId);
 delete from Bücher where Bücher.fk_AutorId IN (SELECT deleted.id FROM deleted);
 delete from Autor where Autor.id IN (@autorId);
 print('Alle Bücher des Autors wurden ebenfalls gelöscht.');
End
GO


-- *********************
-- PROCEDURE ERSTELLEN
-- *********************

Drop Procedure If Exists sp_showAllBooksByAuthor
GO

Create Procedure sp_showAllBooksByAuthor
@AuthorName varchar(50)
AS
BEGIN
Select Bücher.titel as 'Buchtitel',Genre.name as 'Genre' , Bücher.bewertung as 'Bewertung', Bücher.inStock as 'Stückzahl auf Lager' From Autor
Join Bücher On Bücher.fk_AutorId = Autor.id
Join Genre On Bücher.fk_GenreId = Genre.id
Where Autor.name = @AuthorName
Order By Bücher.titel
END
GO