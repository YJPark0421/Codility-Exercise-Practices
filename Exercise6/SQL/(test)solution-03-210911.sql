SELECT m.team_id, team_name, SUM(num_points) AS num_points FROM
(
SELECT match_id, host_team AS team_id, CASE WHEN host_goals > guest_goals THEN 3
			WHEN host_goals < guest_goals THEN 0
		    ELSE 1 END AS num_points
FROM matches
UNION		
SELECT match_id, guest_team AS team_id, CASE WHEN host_goals < guest_goals THEN 3
			WHEN host_goals > guest_goals THEN 0
		    ELSE 1 END AS num_points
FROM matches
)AS m LEFT JOIN teams t ON m.team_id=t.team_id
GROUP BY team_name 
ORDER BY num_points DESC, m.team_id ASC;