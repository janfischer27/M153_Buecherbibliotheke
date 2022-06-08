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