-- QUESTION1. 
SELECT p AS publication_type, COUNT(*) AS total_num
FROM pub
GROUP BY p
ORDER BY total_num DESC;

/*
 publication_type | total_num 
------------------+-----------
 article          |   4033065
 www              |   3909781
 inproceedings    |   3765448
 phdthesis        |    149059
 incollection     |     70988
 proceedings      |     62731
 book             |     21238
 data             |     17283
 mastersthesis    |        27
(9 rows)
*/

-- QUESTION2. 
WITH all_types AS (
  SELECT COUNT(DISTINCT p) AS n FROM pub)
SELECT field.p AS field_name
FROM field
JOIN pub ON pub.k = field.k
GROUP BY field.p
HAVING COUNT(DISTINCT pub.p) = (SELECT n FROM all_types)
ORDER BY field_name;

/*
 field_name 
------------
 author
 ee
 title
 year
(4 rows)
*/

-- QUESTION3.

CREATE INDEX IF NOT EXISTS idx_pub_p    ON pub(p);
CREATE INDEX IF NOT EXISTS idx_pub_k    ON pub(k);
CREATE INDEX IF NOT EXISTS idx_field_k  ON field(k);
CREATE INDEX IF NOT EXISTS idx_field_p  ON field(p);
