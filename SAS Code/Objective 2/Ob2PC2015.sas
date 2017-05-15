/*Data step to create a data set with population and
property crime details for the year 2015
Note: not including the stateS UTAH and HAWAII as more
than 50% of data is unavailable*/
DATA WORK.PROPERTY_CRIME_2015;
	SET WORK.CRIME_DATA;
	WHERE YEAR=2015 AND STATE NOT IN ('UTAH','HAWAII');
	KEEP STATE POPULATION PROPERTY_CRIME;
	RENAME POPULATION=POPULATION_2015 PROPERTY_CRIME=PROPERTY_CRIME_2015;
RUN;


/*Calculate the total population and total property
crime grouping by state*/
PROC REPORT DATA=WORK.PROPERTY_CRIME_2015 OUT=PC_2015;
	COLUMN STATE POPULATION_2015 PROPERTY_CRIME_2015;
	DEFINE STATE / GROUP STYLE(COLUMN)=HEADER;
	DEFINE POPULATION_2015 / SUM 'Population';
	DEFINE PROPERTY_CRIME_2015 / SUM 'Property Crime';
	TITLE 'Population and property crime details by state, year 2015';
RUN;

/*calculate the crim rate for property crime and
add it a new variable to the data set*/
DATA WORK.PC_RATE_2015;
	SET PC_2015;
	PROPERTY_CRIME_RATE_2015=(PROPERTY_CRIME_2015/POPULATION_2015)*100000;
	DROP _BREAK_ POPULATION_2015 PROPERTY_CRIME_2015;
RUN;

PROC PRINT DATA=PC_RATE_2015 label;
	LABEL PROPERTY_CRIME_RATE_2015 = 'Property crime rate';
TITLE 'Property crime rate per 100,000 for the year 2015';
RUN;
;