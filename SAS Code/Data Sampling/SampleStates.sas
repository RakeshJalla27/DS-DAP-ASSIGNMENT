/*Create a data set for the year 2014 alone*/

DATA WORK.CRIME_DATA_2014;
	SET WORK.CRIME_DATA;
	WHERE YEAR=2014;
RUN;

PROC PRINT DATA=WORK.CRIME_DATA_2014;
RUN;

/*
 * Create a data set with state name and number of cities
 * and sort the data set with descending order 
 * of number of cities
 */
PROC SQL;
	CREATE TABLE WORK.SAMPLE_2014 AS
	SELECT STATE,
		   COUNT(STATE) AS NO_OF_CITIES
	FROM WORK.CRIME_DATA_2014
	GROUP BY STATE
	ORDER BY NO_OF_CITIES DESCENDING;
QUIT;

/*
 * print the first three observations as the selected 
 * sample
 */
PROC PRINT DATA=WORK.SAMPLE_2014 (OBS=3) LABEL;
	LABEL NO_OF_CITIES='No of Cities';
RUN;
