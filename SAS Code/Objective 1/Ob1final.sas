/*Merge the data sets VC_RATE_2014 and VC_RATE_2015
to get the final crime rate by states for the year 2014 and 2015*/
DATA WORK.CRIMERATE_1415;
	MERGE VC_RATE_2014 VC_RATE_2015;
	BY STATE;
RUN;

/*Remove the records with missing data fromt the 
data set work.crimerate_1415*/
DATA WORK.CRIMERATE_1415;
	SET WORK.CRIMERATE_1415;
	WHERE CRIME_RATE_2014 ^= . AND 
			CRIME_RATE_2015 ^= .;
RUN;

/*Remove the records where the crime rate in 2015 is 
less than the crime rate in 2014*/
DATA WORK.CRIMERATE_1415;
	SET WORK.CRIMERATE_1415;
	WHERE CRIME_RATE_2015 > CRIME_RATE_2014;
RUN;

/*Calculate the percentage increase in the violent crime rate for the 
years 2014 and 2015 and delete the records with decrease in the crime rate*/

DATA WORK.CRIMERATE_1415;
	SET WORK.CRIMERATE_1415;
	PERCENTAGE_INCREASE = ((CRIME_RATE_2015-CRIME_RATE_2014)/CRIME_RATE_2015)*100;
RUN;



/*Arrange the final data set in the descending order to 
recognise the top 2 states with increase in violent
crime rate*/

PROC SORT DATA=WORK.CRIMERATE_1415 OUT=WORK.CRIMERATE_1415;
	BY DESCENDING PERCENTAGE_INCREASE;
RUN;

/*Proc print step to generate the report for Objective 1*/
PROC PRINT DATA=WORK.CRIMERATE_1415 LABEL;
	LABEL CRIME_RATE_2014 = 'Violent Crime Rate 2014'
		  CRIME_RATE_2015 = 'Violent Crime Rate 2015'
		  PERCENTAGE_INCREASE = '% Increase';
TITLE1 'United States';
TITLE2 'Violent Crime Report 2014-2015';
TITLE3 '**Crime Rate per 100,000';
RUN;
	
