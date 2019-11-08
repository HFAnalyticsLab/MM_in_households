* Derive_twopersonhholds_fromdenomfile.sas ;
* Code used to derive twopersonhholds from CPRD denominator file;
* Mai Stafford;
* July 2019;

libname mmhhdata '[file location removed]';

*Import denominator file;
proc import datafile="[file location removed]\acceptable_pats_from_utspracts_2019_07.txt" dbms=tab 
 out=denom_all_acceptable replace;
	guessingrows=32767;
run;

proc sort data=denom_all_acceptable; by patid; run;

data patient;
set denom_all_acceptable;
accept=1;
pracid1=mod(patid,1000);
pracfamnum1=catx('',pracid1,famnum);
pracfamnum=compress(pracfamnum1);
age=2016-yob;  * check we are taking 2016 as the start of follow-up for hc utilisation;
sex=gender;
if gender=3 then sex=.;
* sample middle age upwards;
if age ge 50 and sex ne . and (tod ge '01apr2015'd OR tod=.);
run;


proc sort data=patient; by pracfamnum patid; run;

proc means data=patient nway noprint;
class pracfamnum;
var accept;
output out=sumfam(drop=_type_ _freq_) n=famsize;
run;

data patient1;
merge patient sumfam;
by pracfamnum;
run;

proc sort data=patient1; by pracfamnum patid; run;

data patient1a;
set patient1;
* limit to 2-person households;
if famsize=2;
run;

* limit to patients that were registered within 1 year of their co-resident;
data patient1b;
set patient1a;
format crdlag ddmmyy10.;
crdlag=lag(crd);
run;

data patient1c;
set patient1b;
by pracfamnum;
if last.pracfamnum then diffcrd=crd-crdlag;
run;

proc sort data=patient1c; by pracfamnum descending patid ; run;

data patient1d;
set patient1c;
diffcrdx=lag(diffcrd);
if lag(pracfamnum) ne pracfamnum then diffcrdx=.;
run;

data patient2;
set patient1d;
if diffcrd=. then diffcrd=diffcrdx;
drop diffcrdx mob regstat reggap internal tod toreason deathdate pracfamnum1;
if diffcrd ge -366 and diffcrd le 366;
run;

proc sort data=patient2; by pracfamnum patid; run;

data mmhhdata.select_patid;
set patient2;
keep patid pracfamnum;
run;

