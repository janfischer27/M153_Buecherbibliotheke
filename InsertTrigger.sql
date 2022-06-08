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