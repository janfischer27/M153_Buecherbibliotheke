-- *********************
-- DATENBANK ERSTELLEN
-- *********************

DROP DATABASE IF EXISTS Bibliotheke
GO

CREATE DATABASE Bibliotheke
GO

USE Bibliotheke
GO

CREATE TABLE "B�cher"(
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
    "B�cher" ADD CONSTRAINT "b�cher_id_primary" PRIMARY KEY("id");
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
    "B�cher" ADD CONSTRAINT "b�cher_fk_autorid_foreign" FOREIGN KEY("fk_AutorId") REFERENCES "Autor"("id");
ALTER TABLE
    "B�cher" ADD CONSTRAINT "b�cher_fk_genreid_foreign" FOREIGN KEY("fk_GenreId") REFERENCES "Genre"("id");
ALTER TABLE
    "B�cher" ADD CONSTRAINT "b�cher_fk_verlagid_foreign" FOREIGN KEY("fk_VerlagId") REFERENCES "Verlag"("id");
ALTER TABLE
    "bestSeller" ADD CONSTRAINT "bestseller_fk_buchid_foreign" FOREIGN KEY("fk_BuchId") REFERENCES "B�cher"("id");

GO


-- *********************
-- TRIGGER ERSTELLEN
-- *********************

Drop Trigger if Exists dropAllBooksFromAuthor
GO

Create Trigger dropAllBooksFromAuthor on autor instead of delete as
begin
 DECLARE @buchId int = (SELECT B�cher.id FROM deleted join B�cher on deleted.id = B�cher.fk_AutorId);
 DECLARE @autorId int = (SELECT id FROM deleted);
	
 delete from bestSeller where bestSeller.fk_BuchId IN (@buchId);
 delete from B�cher where B�cher.fk_AutorId IN (SELECT deleted.id FROM deleted);
 delete from Autor where Autor.id IN (@autorId);
 print('Alle B�cher des Autors wurden ebenfalls gel�scht.');
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
Select B�cher.titel as 'Buchtitel',Genre.name as 'Genre' , B�cher.bewertung as 'Bewertung', B�cher.inStock as 'St�ckzahl auf Lager' From Autor
Join B�cher On B�cher.fk_AutorId = Autor.id
Join Genre On B�cher.fk_GenreId = Genre.id
Where Autor.name = @AuthorName
Order By B�cher.titel
END
GO