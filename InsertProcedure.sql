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

Exec sp_showAllBooksByAuthor 'Jane Schulz';