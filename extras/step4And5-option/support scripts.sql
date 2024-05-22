/* List of books borrowed out of date */
SELECT CONCAT (aa.prenom, ' ', aa.nom) adherent,ee.date_emprunt,ll.titre,NOW(),EXTRACT(DAY FROM NOW()-ee.date_emprunt) AS DateDifference 
FROM emprunte ee, livre ll, adherent aa
where ee.livre_id = ll.livre_id and aa.no_adherent = ee.no_adherent
AND EXTRACT(DAY FROM NOW()-ee.date_emprunt) >14

/* List of books borrowed on date */
SELECT CONCAT (aa.prenom, ' ', aa.nom) adherent,ee.date_emprunt,ll.titre,NOW(),EXTRACT(DAY FROM (NOW()-ee.date_emprunt)) AS DateDifference 
FROM emprunte ee, livre ll,adherent aa
where ee.livre_id = ll.livre_id and aa.no_adherent = ee.no_adherent
AND EXTRACT(DAY FROM NOW()-ee.date_emprunt) <14

/* List of books ordered by number of loans, with last loan and first loan */
SELECT min(ee.date_emprunt) first_loan , max(ee.date_emprunt) last_loan,ll.titre, count(ll.livre_id) 
FROM emprunte ee, livre ll
where ee.livre_id = ll.livre_id
group by ll.livre_id
order by  count(ll.livre_id) desc


/*to know the situation of each subscriber at any time (number of books borrowed, possible delays*/
select CONCAT (aa.prenom, ' ', aa.nom) adherent, count(ee.livre_id) number_of_books,
SUM(CASE WHEN EXTRACT(DAY FROM (NOW()-ee.date_emprunt)) >14 THEN 1 ELSE 0 END) number_of_out_of_date
from adherent aa left outer join emprunte ee on aa.no_adherent = ee.no_adherent
group by aa.no_adherent

/* do statistics on the practice of subscribers (number of books borrowed per year, distribution of borrowings by genre, number of borrowings per book*/
select 
EXTRACT(YEAR FROM ee.date_emprunt) yyyy,EXTRACT(MONTH FROM ee.date_emprunt) mm,COUNt(*) number_of_books
from adherent aa left outer join emprunte ee on aa.no_adherent = ee.no_adherent
group by EXTRACT(YEAR FROM ee.date_emprunt),EXTRACT(MONTH FROM ee.date_emprunt)
order by EXTRACT(YEAR FROM ee.date_emprunt),EXTRACT(MONTH FROM ee.date_emprunt)

/* distribution of borrowings by genre */
SELECt ll.genre,count(*) FROM emprunte ee, livre ll where ee.livre_id = ll.livre_id
group by ll.genre

/* number of borrowings per book */
SELECt ll.titre,count(*) borrowings_per_book FROM emprunte ee, livre ll where ee.livre_id = ll.livre_id
group by ll.livre_id
ORDER BY count(*) DESC

/*Additionally, subscribers can order books. 
	They can order a maximum of three. 
    An order can be canceled or honored if the ordered book has finally been borrowed. 
    The library wishes to keep track of all orders made.*/
select CONCAT (aa.prenom, ' ', aa.nom),count(*) order_books from commande cc, adherent aa ,livre ll 
where cc.no_adherent = aa.no_adherent and cc.livre_id = ll.livre_id    
GROUP BY aa.no_adherent
/* check any with more than 3 orders */
select CONCAT (aa.prenom, ' ', aa.nom),count(*) order_books from commande cc, adherent aa ,livre ll 
where cc.no_adherent = aa.no_adherent and cc.livre_id = ll.livre_id    
GROUP BY aa.no_adherent
HAVING count(*) >3
/* The library wishes to keep track of all orders made.*/
select CONCAT (aa.prenom, ' ', aa.nom),ll.titre,CASE WHEN ee.no_adherent ISNULL THEN 'Pending' ELSE 'Honored' END keep_track,ee.*
from commande cc INNER JOIN adherent aa ON cc.no_adherent = aa.no_adherent
INNER JOIN livre ll ON cc.livre_id = ll.livre_id    
LEFT OUTER JOIN emprunte ee on (aa.no_adherent = ee.no_adherent and ee.livre_id = ll.livre_id)



