/*pi chart for total crimes year 2014*/
PROC GCHART DATA=WORK.CRIME_DATA_STATES;
	WHERE YEAR=2014;
	PIE STATE / TYPE=SUM SUMVAR=TOTAL_CRIMES VALUE=INSIDE NOHEADING;
TITLE1 'Total crimes by state for the year 2014';
RUN;
QUIT;

/*pi chart for total crimes year 2015*/
PROC GCHART DATA=WORK.CRIME_DATA_STATES;
	WHERE YEAR=2015;
	PIE STATE / TYPE=SUM SUMVAR=TOTAL_CRIMES VALUE=INSIDE NOHEADING;
TITLE1 'Total crimes by state for the year 2015';
RUN;
QUIT;

/*bar plot to compare the crime rate between the states
in the year 2014 and 2015*/
PROC SGPLOT DATA = WORK.CRIME_DATA_STATES;
	VBAR STATE / RESPONSE = CRIME_RATE GROUP = YEAR GROUPDISPLAY=CLUSTER DATASKIN=MATTE;
	YAXIS LABEL = 'Crime Rate per 100,000';
 	TITLE 'Crime rate by state for the year 2014 and 2015';
RUN;
QUIT;




