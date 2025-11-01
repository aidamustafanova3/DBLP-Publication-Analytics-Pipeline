/echo top 20 authors with the largest number of publications

SELECT a.name, COUNT(*) AS publications FROM authored ad 
JOIN author a ON a.id = ad.author_id 
GROUP BY a.name ORDER BY publications DESC LIMIT 20;


/echo top 20 authors with the largest number of publications in STOC 
WITH stoc AS (
  SELECT au.author_id
  FROM authored au
  JOIN inproceedings ip ON ip.pubid = au.pub_id
  WHERE ip.booktitle ILIKE '%STOC%'
)
SELECT a.name, COUNT(*) AS pubs_in_stoc FROM stoc s
JOIN author a ON a.id = s.author_id
GROUP BY a.id, a.name ORDER BY pubs_in_stoc DESC, a.name LIMIT 20;

/echo top 20 authors with the largest number of publications in SOSP
 
WITH sosp AS (
  SELECT au.author_id
  FROM authored au
  JOIN inproceedings ip ON ip.pubid = au.pub_id
  WHERE ip.booktitle ILIKE '%SOSP%'
)
SELECT a.name, COUNT(*) AS pubs_in_sosp FROM sosp s
JOIN author a ON a.id = s.author_id
GROUP BY a.id, a.name ORDER BY pubs_in_sosp DESC, a.name LIMIT 20;


/echo all authors who published at least 10 SIGMOD papers but never published a PODS paper
WITH sigmod AS (
  SELECT au.author_id, COUNT(*) AS n
  FROM authored au
  JOIN inproceedings ip ON ip.pubid = au.pub_id
  WHERE ip.booktitle ILIKE '%SIGMOD Conference%'
  GROUP BY au.author_id
),
pods AS (
  SELECT au.author_id, COUNT(*) AS n
  FROM authored au
  JOIN inproceedings ip ON ip.pubid = au.pub_id
  WHERE ip.booktitle ILIKE '%PODS%'
  GROUP BY au.author_id
)
SELECT a.name, s.n AS sigmod_papers FROM sigmod s
LEFT JOIN pods p ON p.author_id = s.author_id
JOIN author a ON a.id = s.author_id WHERE s.n >= 10 AND COALESCE(p.n, 0) = 0 ORDER BY s.n DESC, a.name;


/echo all authors who published at least 10 SIGMOD papers but never published a PODS paper 
WITH sigmod AS (
  SELECT au.author_id, COUNT(*) AS n
  FROM authored au
  JOIN inproceedings ip ON ip.pubid = au.pub_id
  WHERE ip.booktitle ILIKE '%SIGMOD Conference%'
  GROUP BY au.author_id
),
pods AS (
  SELECT au.author_id, COUNT(*) AS n
  FROM authored au
  JOIN inproceedings ip ON ip.pubid = au.pub_id
  WHERE ip.booktitle ILIKE '%PODS%'
  GROUP BY au.author_id
)
SELECT a.name, p.n AS pods_papers FROM pods p
LEFT JOIN sigmod s ON s.author_id = p.author_id
JOIN author a ON a.id = p.author_id WHERE p.n >= 5 AND COALESCE(s.n, 0) = 0 ORDER BY p.n DESC, a.name;

/echo Find the institutions that have published most papers in STOC; return the top 20 institutions
WITH author_domain AS (SELECT id,NULLIF(split_part(regexp_replace(lower(homepage), '^https?://(www\.)?', ''), '/', 1),'' ) AS domain FROM author),
stoc_authors AS (
  SELECT au.author_id FROM authored au
  JOIN inproceedings ip ON ip.pubid = au.pub_id
  WHERE ip.booktitle ILIKE '%STOC%'),
joined AS (
  SELECT ad.domain FROM stoc_authors sa
  JOIN author_domain ad ON ad.id = sa.author_id
  WHERE ad.domain IS NOT NULL)
SELECT domain AS institution, COUNT(*) AS stoc_papers FROM joined
WHERE domain LIKE '%.edu' OR domain LIKE '%.ac.%'      
GROUP BY domain ORDER BY stoc_papers DESC, institution LIMIT 20;



WITH author_domain AS (SELECT id,NULLIF(split_part(regexp_replace(lower(homepage), '^https?://(www\.)?', ''), '/', 1),'' ) AS domain FROM author),
chi_authors AS (
  SELECT au.author_id FROM authored au
  JOIN inproceedings ip ON ip.pubid = au.pub_id
  WHERE ip.booktitle ILIKE '%CHI%'),
joined AS (
  SELECT ad.domain FROM chi_authors sa
  JOIN author_domain ad ON ad.id = sa.author_id
  WHERE ad.domain IS NOT NULL)
SELECT domain AS institution, COUNT(*) AS chi_papers FROM joined
WHERE domain LIKE '%.edu' OR domain LIKE '%.ac.%'     
GROUP BY domain ORDER BY chi_papers DESC, institution LIMIT 20;
