Drop Trigger if Exists dropAllBooksFromAuthor
GO

Create Trigger dropAllBooksFromAuthor on autor for delete as
begin
DECLARE @buchId int = (SELECT Bücher.id FROM deleted join Bücher on deleted.id = Bücher.fk_AutorId);
--print (@buchId);
 delete from bestSeller where bestSeller.fk_BuchId IN (@buchId);
 print('bestseller');
 delete from Bücher where Bücher.fk_AutorId IN (SELECT deleted.id FROM deleted);
 print('Alle Bücher des Autors wurden ebenfalls gelöscht.');
End
GO