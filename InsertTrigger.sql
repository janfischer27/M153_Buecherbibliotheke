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