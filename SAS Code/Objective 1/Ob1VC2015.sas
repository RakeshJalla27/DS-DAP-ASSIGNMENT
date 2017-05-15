/*Data setp to create a data set with the population and 
violent crime details for the year 2015
NOT CONSIDERING THE STATES UTAH AND HAWAII  AS REMOVED FROM 2014 DATA*/
DATA WORK.VIOLENT_CRIME_2015;
	SET WORK.CRIME_DATA;
	WHERE YEAR=2015 AND STATE NOT IN ('UTAH','HAWAII');
	KEEP STATE POPULATION VIOLENT_CRIME;
	RENAME POPULATION=POPULATION_2015 VIOLENT_CRIME=VIOLENT_CRIME_2015;
RUN;

/*proc report step to sum the population and crime data
grouped by state*/
PROC REPORT DATA=VIOLENT_CRIME_2015 NOWD OUT=WORK.VC_2015;
	COLUMN STATE POPULATION_2015 VIOLENT_CRIME_2015;
	DEFINE STATE / GROUP STYLE(COLUMN)=HEADER;
	DEFINE POPULATION_2015 / SUM 'Population';
	DEFINE VIOLENT_CRIME_2015 / SUM 'Violent Crime';
	TITLE1 'Population and Violent Crime grouped by state, year 2015';
RUN;

/*Add new column for crime rate
crime rate = no of crimes / population
multiply by 100000 for no of crimes per 100000*/
DATA WORK.VC_RATE_2015;
	SET WORK.VC_2015;
	CRIME_RATE_2015=(VIOLENT_CRIME_2015/POPULATION_2015)*100000;
	DROP _BREAK_ POPULATION_2015 VIOLENT_CRIME_2015;
RUN;

PROC PRINT DATA=WORK.VC_RATE_2015 LABEL;
	LABEL CRIME_RATE_2015='Crime Rate';
TITLE1 'Crime rate per 100,000 for the year 2015';
RUN;
