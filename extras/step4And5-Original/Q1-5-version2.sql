
/* Q1. List of the books returned with delay for each adherant? */

SELECT 
	/* the select list of fields */
	CONCAT (aa.prenom, ' ', aa.nom) adherent,
	ee.date_emprunt,
	ll.titre,
	NOW(),
	EXTRACT(DAY FROM COALESCE(ee.date_retour,NOW())-ee.date_emprunt) AS DateDifference  
FROM emprunte ee, livre ll, adherent aa where ee.livre_id = ll.livre_id and aa.no_adherent = ee.no_adherent 
AND EXTRACT(DAY FROM COALESCE(ee.date_retour,NOW())-ee.date_emprunt) >14 

/* Q1 rewite with subquery returned_delay */

SELECT aa.nom,aa.prenom,ll.titre 
FROm adherent aa,
livre ll,
	(SELECT ee.no_adherent,ee.livre_id 
 		from emprunte ee 
     	where EXTRACT(DAY FROM COALESCE(ee.date_retour,NOW())-ee.date_emprunt) >14) returned_delay 
WHERE aa.no_adherent =returned_delay.no_adherent and ll.livre_id = returned_delay.livre_id
ORDER BY aa.nom,aa.prenom

/* Q2 : Number of the books borrowed by each Adherent?*/

select ee.no_adherent, 
	count(ee.no_adherent) books_borrowed, 
	max(aa.nom), 
	max(aa.prenom) 
from emprunte ee, adherent aa WHERE ee.no_adherent = aa.no_adherent  
group by ee.no_adherent 

/* the grouping in a subquery  */
SELECT aa.*,gg.books_borrowed 
FROM adherent aa INNER JOIN 
	(select ee.no_adherent,count(ee.no_adherent) books_borrowed 
     	from emprunte ee group by ee.no_adherent) gg 
        ON aa.no_adherent =gg.no_adherent

/* Q3. Number of the books borrowed by each adherant by year? */
select aa.nom,aa.prenom,
EXTRACT(YEAR FROM ee.date_emprunt) yyyy,COUNt(*) number_of_books
from adherent aa left outer join emprunte ee on aa.no_adherent = ee.no_adherent
group by  aa.no_adherent, EXTRACT(YEAR FROM ee.date_emprunt)
order by EXTRACT(YEAR FROM ee.date_emprunt)

/* Q4. Distribution of borrowed books by genre for each adherant? */
SELECt aa.nom,aa.prenom,MAX(ll.genre),count(*) borrowings_per_genre 
FROM emprunte ee, livre ll, adherent aa ,genres gg
where ee.livre_id = ll.livre_id and aa.no_adherent = ee.no_adherent and ll.livre_id = gg.livre_id
group by aa.no_adherent,gg.genre_nom
ORDER BY count(*) DESC

/* Q4. Distribution of borrowed books by genre for each adherant? !!!!! */
SELECt aa.nom,aa.prenom,ll.genre,count(*) borrowings_per_genre 
FROM emprunte ee, livre ll, adherent aa 
where ee.livre_id = ll.livre_id and aa.no_adherent = ee.no_adherent 
group by aa.no_adherent,ll.genre
ORDER BY count(*) DESC

/* Q5. Number of borrowings for each book for each adherant? (It means each book has borrowed 
how many times by each adherant)*/

SELECt aa.nom,aa.prenom,ll.titre,count(*) borrowings_per_book FROM emprunte ee, livre ll, adherent aa 
where ee.livre_id = ll.livre_id and aa.no_adherent = ee.no_adherent
group by aa.no_adherent,ll.livre_id
ORDER BY count(*) DESC
