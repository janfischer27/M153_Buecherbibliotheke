-- *********************
-- PROCEDURE BEISPIEL
-- *********************

exec sp_showAllBooksByAuthor 'Hans Christian';


-- *********************
-- TRIGGER TESTEN
-- *********************

delete from Autor where Autor.id = 1;