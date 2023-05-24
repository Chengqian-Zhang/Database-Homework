SELECT (close - lag(close, 20) OVER (ORDER BY date)) 
/ lag(close, 20) OVER (ORDER BY date) * 100 AS result
FROM tushare
