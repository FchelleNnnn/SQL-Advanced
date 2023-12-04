
/* RECURSIVE QUERY */

/* Display number from 1 to 10 without using any built-in functions */

WITH recursive num AS 
(SELECT 1 AS n
UNION ALL
SELECT n+1 as n
FROM num 
WHERE n < 10 )
SELECT * FROM num;

/*Find the heirarchy of employees under a given manager "Asha". It should also display
the name of the manager */

SELECT * FROM emp_details;

WITH recursive emp_heirarchy AS
(SELECT id , name , manager_id ,designation , 1 as lvl
 FROM emp_details
 WHERE name = 'Asha'--base query
UNION ALL
SELECT b.id, b.name , b.manager_id ,b.designation , lvl + 1 as lvl
FROM emp_heirarchy a
JOIN emp_details b ON a.id = b.manager_id)
SELECT a1.id as emp_id , a1.name as emp_name , a1.manager_id as manager_id,
b1.name as manager_name , a1.designation as designation , a1.lvl
FROM emp_heirarchy a1
JOIN emp_details b1 ON a1.manager_id = b1.id

/* Find the heirarchy of managers for a given employee called David */

SELECT * FROM emp_details;

WITH recursive david_managers AS 
(SELECT id, name, manager_id , designation
FROM emp_details 
WHERE name = 'David'
UNION ALL
SELECT b.id , b.name , b.manager_id , b.designation 
FROM david_managers a 
JOIN emp_details b ON a.manager_id = b.id)
SELECT a1.id as emp_id , a1.name as emp_name , a1.manager_id , 
b1.name as manager_name , b1.designation
FROM david_managers a1
JOIN emp_details b1 ON a1.manager_id = b1.id;