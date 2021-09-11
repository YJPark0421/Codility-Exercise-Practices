WITH cte AS
(
     SELECT *,
           (SELECT COUNT(*) + 1
            FROM "events" e1
            WHERE e1.event_type= e.event_type
              AND e1.time > e.time) AS rn
     FROM "events" e
)
SELECT c.event_type, c."value" -c2."value" AS "value"
FROM cte c
JOIN cte c2
  ON c.event_type= c2.event_type
 AND c.rn= 1 AND c2.rn= 2
ORDER BY c.event_type, c.time;
