Drop Trigger if Exists dropAllBooksFromAuthor
GO

Create Trigger dropAllBooksFromAuthor on autor for delete as
begin
DECLARE @buchId int = (SELECT B�cher.id FROM deleted join B�cher on deleted.id = B�cher.fk_AutorId);
--print (@buchId);
 delete from bestSeller where bestSeller.fk_BuchId IN (@buchId);
 print('bestseller');
 delete from B�cher where B�cher.fk_AutorId IN (SELECT deleted.id FROM deleted);
 print('Alle B�cher des Autors wurden ebenfalls gel�scht.');
End
GO