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

Exec sp_showAllBooksByAuthor 'Jane Schulz';