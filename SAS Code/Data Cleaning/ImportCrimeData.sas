/** Import an XLSX file.  **/

PROC IMPORT DATAFILE="/home/tp0457220/DAP_Assignment_Code/CRIME_DATA"
		    OUT=WORK.CRIME_DATA
		    DBMS=XLSX
		    REPLACE;
RUN;

/** Print the results. **/

PROC PRINT DATA=WORK.CRIME_DATA; RUN;