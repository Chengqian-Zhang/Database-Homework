SELECT (SELECT AVG(close) FROM tushare WHERE date <= t1.date 
	AND date >= DATE_SUB(t1.date, INTERVAL 6 DAY)) / close AS result
FROM tushare t1
