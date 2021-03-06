/*data set to plot bar charts for violent and
property crime*/
DATA WORK.CRIME_RATE_DETAILS_SEL_STATE;
	SET WORK.CRIME_DETAILS_SEL_STATES;
	VIOLENT_CRIME_RATE=(VIOLENT_CRIME/POPULATION)*100000;
	PROPERTY_CRIME_RATE=(PROPERTY_CRIME/POPULATION)*100000;
RUN;

/*bar plot for violent crime rate*/

PROC SGPLOT DATA = CRIME_RATE_DETAILS_SEL_STATE;
	VBAR STATE / RESPONSE = VIOLENT_CRIME_RATE GROUP = YEAR GROUPDISPLAY=CLUSTER DATASKIN=MATTE;
	YAXIS LABEL = 'Crime Rate per 100,000';
 	TITLE 'Violent Crime rate by state for the year 2014 and 2015';
RUN;
QUIT;

/*transpose funciton to get detailed violent crime report*/
PROC TRANSPOSE DATA=WORK.VIOLENT_CRIME_DATA_2014 
	OUT=WORK.VC_2014_DETAILS
	NAME=VIOLENT_CRIMES;
	ID STATE;
RUN;

PROC TRANSPOSE DATA=WORK.VIOLENT_CRIME_DATA_2015
	OUT=WORK.VC_2015_DETAILS
	NAME=VIOLENT_CRIMES;
	ID STATE;
RUN;

PROC PRINT DATA=WORK.VC_2014_DETAILS LABEL;
	FORMAT CALIFORNIA FLORIDA TEXAS COMMA16.;
	LABEL VIOLENT_CRIMES='VIOLENT CRIME';
	TITLE 'Details of violent crime by state. Year 2014';
RUN;

PROC PRINT DATA=WORK.VC_2015_DETAILS LABEL;
	FORMAT CALIFORNIA FLORIDA TEXAS COMMA16.;
	LABEL VIOLENT_CRIMES='VIOLENT CRIME';
	TITLE 'Details of violent crime by state. Year 2015';
RUN;



/*Violent crime pie chart california state 2014*/
PROC GCHART DATA=WORK.VC_2014_DETAILS;
	PIE3D VIOLENT_CRIMES / TYPE = SUM SUMVAR = CALIFORNIA NOHEADING;
	TITLE 'Details of violent crimes in California for the year 2014';
RUN;
QUIT;

/*violent crime pie chart california state 2015*/
PROC GCHART DATA=WORK.VC_2015_DETAILS;
	PIE3D VIOLENT_CRIMES / TYPE = SUM SUMVAR = CALIFORNIA NOHEADING;
	TITLE 'Details of violent crimes in California for the year 2015';
RUN;
QUIT;

/*Violent crime pie chart florida state 2014*/
PROC GCHART DATA=WORK.VC_2014_DETAILS;
	PIE3D VIOLENT_CRIMES / TYPE = SUM SUMVAR = FLORIDA NOHEADING;
	TITLE 'Details of violent crimes in Florida for the year 2014';
RUN;
QUIT;

/*violent crime pie chart FLORIDA state 2015*/
PROC GCHART DATA=WORK.VC_2015_DETAILS;
	PIE3D VIOLENT_CRIMES / TYPE = SUM SUMVAR = FLORIDA NOHEADING;
	TITLE 'Details of violent crimes in Florida for the year 2015';
RUN;
QUIT;

/*Violent crime pie chart Texas state 2014*/
PROC GCHART DATA=WORK.VC_2014_DETAILS;
	PIE3D VIOLENT_CRIMES / TYPE = SUM SUMVAR = TEXAS NOHEADING;
	TITLE 'Details of violent crimes in Texas for the year 2014';
RUN;
QUIT;

/*violent crime pie chart Texas state 2015*/
PROC GCHART DATA=WORK.VC_2015_DETAILS;
	PIE3D VIOLENT_CRIMES / TYPE = SUM SUMVAR = TEXAS NOHEADING;
	TITLE 'Details of violent crimes in Texas for the year 2015';
RUN;
QUIT;
