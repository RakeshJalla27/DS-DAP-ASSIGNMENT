/*Merge the data sets with property crime rates
for the years 2014 and 2015*/
DATA WORK.PROP_CRIME_1415;
	MERGE PC_RATE_2014 PC_RATE_2015;
	BY STATE;
RUN;

/*Subset the data set by removing the records where 
property crime rate in 2015 is more than
the property crime rate in 2014*/
DATA WORK.PROP_CRIME_1415;
	SET WORK.PROP_CRIME_1415;
	WEHRE PROPERTY_CRIME_RATE_2014 > PROPERTY_CRIME_RATE_2015;
RUN;

/*Calculate the percentage decrease of property
crime rate in 2015 compared to the year 2014 and add it as 
a new valriable in the data set*/
DATA WORK.PROP_CRIME_RATE_1415;
	SET WORK.PROP_CRIME_1415;
	PERCENTAGE_DECREASE=
	((PROPERTY_CRIME_RATE_2014-PROPERTY_CRIME_RATE_2015)/PROPERTY_CRIME_RATE_2014)*100;
RUN;

/*
 * Sort the data set in the descending order of percentage
 * decrease to achieve objective2
 */
PROC SORT DATA=PROP_CRIME_RATE_1415;
	BY DESCENDING PERCENTAGE_DECREASE;
RUN;

/*proc print set for generating the final report 
of objective 2*/
PROC PRINT DATA=PROP_CRIME_RATE_1415 LABEL;
	LABEL PROPERTY_CRIME_RATE_2014='Property crime rate 2014'
		  PROPERTY_CRIME_RATE_2015='Property crime rate 2015'
		  PERCENTAGE_DECREASE='% Decrease';
	TITLE1 'United State';
	TITLE2 'Property Crime 2014-2015';
	TITLE3 '**Crime rate per 100,000';
RUN; 