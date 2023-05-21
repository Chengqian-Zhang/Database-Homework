SELECT SUM(mybool) OVER (ORDER BY date ROWS BETWEEN CURRENT ROW AND 11 FOLLOWING) / 12 * 100 AS result FROM
(
	SELECT close > LAG(close, 1) OVER (ORDER BY trade_date) AS mybool, trade_date AS date FROM tushare
) AS tmp;