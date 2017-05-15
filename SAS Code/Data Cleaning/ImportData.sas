/** Import an XLSX file.  **/

PROC IMPORT DATAFILE="/home/tp0457220/DAP_Assignment_Code/Table_4"
		    OUT=WORK.TABLE4 DBMS=XLS
		    REPLACE;
		    SHEET = "Table4"; /*Name of the sheet to import the data*/
		    GETNAMES=YES; /*This parameter considers the data as column names*/
		    NAMEROW=5;
		    DATAROW=6;
		    ENDROW=525;
		    ENDCOL=Q;
RUN;


