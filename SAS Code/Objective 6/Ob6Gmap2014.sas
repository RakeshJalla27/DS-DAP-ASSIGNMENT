/*Data set to have state code and state number*/
PROC SQL;
	CREATE TABLE WORK.STATE_CODES_US AS
	SELECT STATE,STATECODE
	FROM MAPS.US
	GROUP BY STATE,STATECODE;
QUIT;

/*proc sort to sort the data set by state number 
and remove duplicates */
PROC SORT DATA=WORK.STATE_CODES_US NODUPKEY;
BY STATE;
RUN;

PROC SQL;
	CREATE TABLE WORK.MAP_2014_NO AS
	SELECT STATE_CODE,CRIME_RATE,B.STATE
	FROM WORK.MAP_2014 AS A,WORK.STATE_CODES_US AS B
	WHERE A.STATE_CODE=B.STATECODE;
QUIT;

DATA MAPLABEL;
	LENGTH FUNCTION $ 8;
	RETAIN FLAG 0 XSYS YSYS '2' HSYS '3' WHEN 'a' STYLE "'Albany AMT'";
	SET MAPS.USCENTER(DROP=LONG LAT);
	FUNCTION='LABEL';
	TEXT=FIPSTATE(STATE); SIZE=2.5; POSITION='5';
	IF OCEAN='Y' THEN
	 DO;
		POSITION='6'; OUTPUT;
		FUNCTION='MOVE';
		FLAG=1;
	 END;
	ELSE IF FLAG=1 THEN
	 DO;
		FUNCTION='DRAW'; 
		SIZE=.5;
		FLAG=0;
	 END;
	OUTPUT;
RUN;
		
		
	
/*Define the colorramp to represent
each category with a color*/
PROC TEMPLATE;
	DEFINE STYLE STYLES.COLORRAMP;
	PATTERN1 c=LIGHTGREEN;
	PATTERN2 c=LIGHTCYAN;
	PATTERN3 c=LIGHTBLUE;
	PATTERN4 C=LIGHTSEAGREEN;
	PATTERN5 c=LIGHTCORAL;
END;
RUN;

/*Define the categories*/
PROC FORMAT;
 VALUE RATE 1000 - 1500 = '1000 >- 1500 -Low'
 	    1501 - 2000 = '1500 >- 2000 -Medium'
 	    2001 - 2500 = '2000 >- 2500 -High'
 	    2501 - 3000 = '2500 >- 3000 -Very High'
 	    3001 - 3500 = '3000 >- 3500 -Extreme';
 RUN;
 
 ODS LISTING STYLE=STYLES.COLORRAMP;
 ODS HTML STYLE=STYLES.COLORRAMP;
 
 /*proc gmap to generate the map, apply the category format on the 
 crime_rate field of our data set*/
 PROC GMAP DATA=WORK.MAP_2014_NO MAP=MAPS.US;
 	FORMAT CRIME_RATE RATE.;
 	LABEL CRIME_RATE='Crime Rate';
 	ID STATE;
 	CHORO CRIME_RATE / DISCRETE COUTLINE=BLACK annotate=maplabel ;
 TITLE1 'United State of America';
 TITLE2 'State categorized by Crime Rate. Year 2014';
 TITLE3 '**Crime Rate per 100,000';
 RUN;
 QUIT;
 
 