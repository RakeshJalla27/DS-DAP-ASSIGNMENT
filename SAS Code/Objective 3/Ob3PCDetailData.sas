/*dataset for the crime details of the three states
formatting the rape field to numeric
City Tyler is not considered for the analysis as it has missing data
for the year 2014*/
DATA WORK.CRIME_DETAILS_STATES;
	SET WORK.CRIME_DATA;
	RAPE_NO=INPUT(RAPE,5.);
	WHERE STATE_CODE IN ('CA','FL','TX') AND CITY NE 'TYLER';
RUN;

/*Creating the data set of detailed crime information
grouped by state*/
PROC SQL;
	CREATE TABLE WORK.CRIME_DETAILS_SEL_STATES AS
	SELECT STATE, YEAR, SUM(POPULATION) AS POPULATION,
	SUM(VIOLENT_CRIME) AS VIOLENT_CRIME,
	SUM(MURDER) AS MURDER,
	SUM(ROBBERY) AS ROBBERY,
	SUM(AGGRAVATED_ASSULT) AS AGGRAVATED_ASSAULT,
	SUM(RAPE_NO) AS RAPE,
	SUM(PROPERTY_CRIME) AS PROPERTY_CRIME,
	SUM(BURGLARY) AS BURGLARY,
	SUM(LARCENY_THEFT) AS LARCENY_THEFT,
	SUM(MOTOR_VEHICLE_THEFT) AS MOTOR_VEHICLE_THEFT,
	SUM(ARSON) AS ARSON
	FROM WORK.CRIME_DETAILS_STATES
	GROUP BY STATE, YEAR;
QUIT;

/*temporary data set for details  on property crime*/
DATA WORK.property_CRIME_DATA;
	SET WORK.CRIME_DETAILS_SEL_STATES;
	KEEP STATE YEAR BURGLARY LARCENY_THEFT MOTOR_VEHICLE_THEFT;
RUN;

/*data set for violent crime information for the
three states in the year 2014*/
DATA WORK.PROPERTY_CRIME_DATA_2014;
	SET WORK.PROPERTY_CRIME_DATA;
	WHERE YEAR=2014;
	DROP YEAR;
RUN;

/*data set for violent crime information for the 
three states in the year 2015*/
DATA WORK.PROPERTY_CRIME_DATA_2015;
	SET WORK.PROPERTY_CRIME_DATA;
	WHERE YEAR=2015;
	DROP YEAR;
RUN;

PROC PRINT DATA=WORK.PROPERTY_CRIME_DATA_2014 LABEL;
	FORMAT BURGLARY LARCENY_THEFT MOTOR_VEHICLE_THEFT COMMA16.;
	LABEL STATE='STATE' LARCENY_THEFT='LARCENY THEFT' MOTOR_VEHICLE_THEFT='MOTOR VEHICLE THEFT';
	TITLE 'Detailed property crime report : Year 2014';
	
RUN;

PROC PRINT DATA=WORK.PROPERTY_CRIME_DATA_2015 LABEL;
	FORMAT BURGLARY LARCENY_THEFT MOTOR_VEHICLE_THEFT COMMA16.;
	LABEL STATE='STATE'LARCENY_THEFT='LARCENY THEFT' MOTOR_VEHICLE_THEFT='MOTOR VEHICLE THEFT';
	TITLE 'Detailed property crime report : Year 2015';
RUN;