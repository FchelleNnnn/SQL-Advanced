
/* MATERIALIZED VIEW */

CREATE TABLE random_tab 
(id int , 
val decimal); 

INSERT INTO random_tab 
SELECT 1 , random() from generate_series(1, 10000000);
INSERT INTO random_tab
SELECT 2 , random() from generate_series(1,10000000);

SELECT * FROM random_tab --3.6s in running this code

SELECT id , avg(val) as avg
FROM random_tab
GROUP BY id;

CREATE materialized view mv_random_tab AS 
SELECT id , avg(val) as avg 
FROM random_tab
GROUP BY id

SELECT * 
FROM mv_random_tab --0.6ms in running this code

/* UPDATING THE TABLE */

DELETE FROM random_tab
WHERE id = 1 

/* ALWAYS REFRESH THE MATERIALIZED VIEW WHEN UPDATING THE TABLE */
REFRESH materialized view mv_random_tab
SELECT * FROM mv_random_tab
