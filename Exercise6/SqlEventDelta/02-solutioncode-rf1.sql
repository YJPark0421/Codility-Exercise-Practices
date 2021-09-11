SELECT e1.event_type, (e1.value - e2.value) AS value FROM events e1
JOIN events e2
ON e1.event_type = e2.event_type
AND e1.time = (SELECT time FROM events temp1 
				WHERE temp1.event_type=e1.event_type 
				ORDER BY time DESC LIMIT 1)
AND e2.time = (SELECT time FROM events temp2 
				WHERE temp2.event_type=e2.event_type 
				ORDER BY time DESC LIMIT 1 OFFSET 1)
