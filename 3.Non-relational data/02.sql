SELECT (-1) * (val - next_val) AS result FROM
(
	SELECT val, LEAD(val, 1) OVER (ORDER BY date) AS next_val FROM
	(
		SELECT ((close-low)-(high-close))/((high-low)) AS val, trade_date AS date  from tushare ORDER BY date
	) AS tmp
) AS tmp2;