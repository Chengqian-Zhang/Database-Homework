SELECT AVG(val) OVER (ORDER BY date ROWS BETWEEN 0 PRECEDING AND 4 FOLLOWING) AS result FROM
(
	SELECT close - lead(close, 5) OVER (ORDER BY trade_date) AS val, trade_date AS date FROM tushare
) AS tmp