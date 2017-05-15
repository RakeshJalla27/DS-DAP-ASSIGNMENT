/*SAS code to remove numbers and special 
characters from State and City names*/
DATA work.table4;
	set work.table4;
	State = compress(State,',1234567890');
	City = compress(City,',1234567890');
RUN;

/*SAS Code to merge Rape_Legacy and Rape_Revised to
single variable rape*/
DATA work.Table4;
	set work.Table4;
	Rape = catt(Rape_Revised,Rape_Legacy);
	Rape = compress(Rape,'.');
	drop Rape_Revised Rape_Legacy;
RUN;

