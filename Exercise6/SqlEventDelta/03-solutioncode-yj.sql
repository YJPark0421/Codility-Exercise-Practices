WITH cte1 AS
(
	SELECT *, CASE WHEN e2.event_type = e2.prev THEN 0 
				 WHEN e2.event_type = e2.next THEN 0 
				 ELSE 1 END AS grp
	FROM (SELECT *, LAG(e1.event_type) OVER(ORDER BY (SELECT 1)) AS prev , LEAD(e1.event_type) OVER(ORDER BY (SELECT 1)) AS next FROM events e1) e2
)
,cte2 AS 
(
	SELECT cte1.event_type, cte1.time, cte1.grp, cte1.value - LAG(cte1.value) OVER(ORDER BY cte1.event_type, cte1.time) AS value 
	FROM cte1 
	WHERE cte1.grp = 0 
	ORDER BY cte1.event_type, cte1.time
)

SELECT c2.event_type, c2.value 
FROM cte2 c2
WHERE (c2.event_type, c2.time) IN (
	SELECT c2.event_type, MAX(c2.time) AS time 
	FROM cte2 c2 
	GROUP BY c2.event_type)
GROUP BY c2.event_type
ORDER BY c2.event_type, c2.time
