
/*
 * Create a data set with crime details for the
 * state of California
 */
DATA WORK.CRIME_DATA_3;
	SET WORK.CRIME_DATA;
	WHERE STATE_CODE in ('CA','FL','TX');
	TOTAL_CRIMES=VIOLENT_CRIME+PROPERTY_CRIME+ARSON;
	KEEP STATE YEAR CITY POPULATION VIOLENT_CRIME PROPERTY_CRIME ARSON TOTAL_CRIMES ;
RUN;

/*
 * Create an aggregated data set of population and 
 * crimes
 */
PROC SQL;
	CREATE TABLE WORK.CRIME_DATA_STATES AS
	SELECT STATE,YEAR,SUM(POPULATION) AS TOTAL_POPULATION,
		SUM(VIOLENT_CRIME) AS VIOLENT_CRIME,
		SUM(PROPERTY_CRIME) AS PROPERTY_CRIME,
		SUM(ARSON) AS ARSON,
		SUM(TOTAL_CRIMES) AS TOTAL_CRIMES
	FROM WORK.CRIME_DATA_3
	GROUP BY STATE, YEAR;
QUIT;

/*
 * Calculate the crime rate per 100000
 * for the states
 */
DATA WORK.CRIME_DATA_STATES;
	SET WORK.CRIME_DATA_STATES;
	CRIME_RATE=(TOTAL_CRIMES/TOTAL_POPULATION)*100000;
RUN;


/*proc tabulate to display the crime details
of the three states over the year 2014 and 2015*/
PROC TABULATE DATA=CRIME_DATA_STATES;
TITLE1 'US: California, Florida & Texas';
TITLE2 'Crime details over the years 2014 & 2015';
TITLE3 '**Crime rate per 100,000';
	CLASS STATE YEAR;
	VAR TOTAL_POPULATION VIOLENT_CRIME 
		PROPERTY_CRIME ARSON TOTAL_CRIMES 
		CRIME_RATE;
	TABLE STATE='',YEAR*(TOTAL_POPULATION='Population'*(SUM=''*F=COMMA16.)
		VIOLENT_CRIME='Violent Crimes'*(SUM=''*F=COMMA16.)
		PROPERTY_CRIME='Property Crimes'*(SUM=''*F=COMMA16.)
		ARSON='Arson'*(SUM=''*F=COMMA16.) TOTAL_CRIMES='Total Crimes'*(SUM=''*F=COMMA16.)
		CRIME_RATE='Crime Rate'*(SUM=''))
		/BOX='State';
RUN;
	