SELECT t.team_id, team_name, coalesce(SUM(num_points),0) AS num_points
FROM teams t LEFT JOIN(
SELECT match_id, host_team AS team_id, CASE WHEN host_goals > guest_goals THEN 3
			WHEN host_goals < guest_goals THEN 0
		    ELSE 1 END AS num_points
FROM matches
UNION		
SELECT match_id, guest_team AS team_id, CASE WHEN host_goals < guest_goals THEN 3
			WHEN host_goals > guest_goals THEN 0
		    ELSE 1 END AS num_points
FROM matches
)AS m ON t.team_id=m.team_id
GROUP BY m.team_id
ORDER BY num_points DESC, m.team_id ASC;
