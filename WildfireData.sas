/ *1/ Data cleaning with new variable creation ***
/*2/ Exploratory and confirmatory factor Analysis 
/*3/ Descriptive Analysis 
/*4/ Factor Analysis. Explorator and confirmatory factor analysis 
/*5/ Principle Component analysis and Missing Value Imputation 
/*6/ Summary Statistics 
/*7/ WTP modeling 
/*8/ Variable creation for Maximuum Likelihood estimation 
/*9/ Modified Probit Model 
/*10 Create Graph and Figure /


/data cleaning and new variable creation/

/*Final do file SAS/

/*Risk Reduction, Baseline Risk and damages Public and Private Program*

/**Baseline Risk***/

proc freq data=WILDFIRE;
tables p1_pct / out=baseline_risk_dummies;
run;

data WILDFIRE;
set WILDFIRE;
rename  br10 = dum1 br2 = dum2 br3 = dum3 br6 = dum4 br8 = dum5;

* Baseline risk;
if dum1 = 1 then baselinerisk = 10;
else if dum2 = 1 then baselinerisk = 2;
else if dum3 = 1 then baselinerisk = 3;
else if dum4 = 1 then baselinerisk = 6;
else if dum5 = 1 then baselinerisk = 8;

*dummy for probability of risk reduction;

proc freq data=WILDFIRE;
tables pr_loss / out=risk_reduction_dummies;
run;

data WILDFIRE;
set WILDFIRE;
rename  prd106 = dum1 prd109 = dum2 prd21 = dum3 prd31 = dum4 prd62 = dum5 prd86 = dum6;

* Risk Reduction;
if dum1 = 1 then riskreduction = 4;
else if dum2 = 1 then riskreduction = 1;
else if dum3 = 1 then riskreduction = 1;
else if dum4 = 1 then riskreduction = 2;
else if dum5 = 1 then riskreduction = 4;
else if dum6 = 1 then riskreduction = 2;

*probability that a wildfire will damage your property sometime in the 5 year period;

proc freq data=WILDFIRE;
tables pr_loss_year / out=pr_loss_year_dummies;
run;

data WILDFIRE;
set WILDFIRE;
rename  ply105 = dum1 ply145 = dum2 ply2710 = dum3 ply3427 = dum4 ply4127 = dum5 ply4138 = dum6;

* Dummy for year span;
proc freq data=WILDFIRE;
tables yearspan / out=yearspan_dummies;
run;

data WILDFIRE;
set WILDFIRE;
rename  yearspan5 = dum1 yearspan10 = dum2;

* Dummy for loss for private program;
proc freq data=WILDFIRE;
tables loss / out=private_loss_dummies;
run;

data WILDFIRE;
set WILDFIRE;
rename  prloss50K = dum1 prloss100k = dum2 prloss200k = dum3;

* Summary Statistics;

proc means data=WILDFIRE;
var br10 br2 br3 br6 br8 prd106 prd109 prd21 prd31 prd62 prd86 yearspan5 yearspan10;
run;


*Private and public bid amount;

proc freq data=WILDFIRE;
tables pribid1 pribid2 pribid3 pribid4 pribid5 pribid6;
tables pubbid1 pubbid2 pubbid3 pubbid4 pubbid5 pubbid6;
run;

*Generate variables for private program, affectr answer about WTP questions;

* I cannot afford the cost;
data WILDFIRE;
set WILDFIRE;
noafford = fx_prv_1;

if noafford = 0 then noafford = 0;
else if noafford = 1 then noafford = 25;
else if noafford = 2 then noafford = 50;
else if noafford = 3 then noafford = 75;
else if noafford = 4 then noafford = 100;

if noafford in (75, 100) then noafford1 = 1;
else noafford1 = 0;

*Reducing risk by this much is not valuable to me;
novalue = fx_prv_2;

if novalue = 0 then novalue = 0;
else if novalue = 1 then novalue = 25;
else if novalue = 2 then novalue = 50;
else if novalue = 3 then novalue = 75;
else if novalue = 4 then novalue = 100;

if novalue in (75, 100) then novalue1 = 1;
else novalue1 = 0;

*I wouldn't want to lose my house to wildfire if I can prevent it;
prevent = fx_prv_3;

if prevent = 0 then prevent = 0;
else if prevent = 1 then prevent = 25;
else if prevent = 2 then prevent = 50;
else if prevent = 3 then prevent = 75;
else if prevent = 4 then prevent = 100;

if prevent in (75, 100) then prevent1 = 1;
else prevent1 = 0;

run;

*Summary Statistics/

proc freq data=WILDFIRE;
tables noafford fx_prv_1 novalue fx_prv_2 prevent fx_prv_3;
run;

proc means data=WILDFIRE;
var noafford fx_prv_1 novalue fx_prv_2 prevent fx_prv_3;
run;

*Private and public bid amount;

proc freq data=WILDFIRE;
tables pribid1 pribid2 pribid3 pribid4 pribid5 pribid6;
tables pubbid1 pubbid2 pubbid3 pubbid4 pubbid5 pubbid6;
run;

*Generate variables for private program, affectr answer about WTP questions;

* I cannot afford the cost;
data WILDFIRE;
set WILDFIRE;
noafford = fx_prv_1;

if noafford = 0 then noafford = 0;
else if noafford = 1 then noafford = 25;
else if noafford = 2 then noafford = 50;
else if noafford = 3 then noafford = 75;
else if noafford = 4 then noafford = 100;

if noafford in (75, 100) then noafford1 = 1;
else noafford1 = 0;

*Reducing risk by this much is not valuable to me;
novalue = fx_prv_2;

if novalue = 0 then novalue = 0;
else if novalue = 1 then novalue = 25;
else if novalue = 2 then novalue = 50;
else if novalue = 3 then novalue = 75;
else if novalue = 4 then novalue = 100;

if novalue in (75, 100) then novalue1 = 1;
else novalue1 = 0;

*I wouldn't want to lose my house to wildfire if I can prevent it;
prevent = fx_prv_3;

if prevent = 0 then prevent = 0;
else if prevent = 1 then prevent = 25;
else if prevent = 2 then prevent = 50;
else if prevent = 3 then prevent = 75;
else if prevent = 4 then prevent = 100;

if prevent in (75, 100) then prevent1 = 1;
else prevent1 = 0;

run;

*Summary Statistics;
proc freq data=WILDFIRE;
tables noafford fx_prv_1 novalue fx_prv_2 prevent fx_prv_3;
run;

proc means data=WILDFIRE;
var noafford fx_prv_1 novalue fx_prv_2 prevent fx_prv_3;
run;

* I don't believe that the risk reduction would be achieved;
data WILDFIRE;
set WILDFIRE;
notachieved = fx_prv_4;

if notachieved = 0 then notachieved = 0;
else if notachieved = 1 then notachieved = 25;
else if notachieved = 2 then notachieved = 50;
else if notachieved = 3 then notachieved = 75;
else if notachieved = 4 then notachieved = 100;

if notachieved in (75, 100) then notachieved1 = 1;
else notachieved1 = 0;

* I would not create defensible space on my property in this situation even if it cost me nothing;
costnothing = fx_prv_5;

if costnothing = 0 then costnothing = 0;
else if costnothing = 1 then costnothing = 25;
else if costnothing = 2 then costnothing = 50;
else if costnothing = 3 then costnothing = 75;
else if costnothing = 4 then costnothing = 100;

if costnothing in (75, 100) then costnothing1 = 1;
else costnothing1 = 0;

* These changes in risk are too small to matter to me;
smallrisk = fx_prv_6;

if smallrisk = 0 then smallrisk = 0;
else if smallrisk = 1 then smallrisk = 25;
else if smallrisk = 2 then smallrisk = 50;
else if smallrisk = 3 then smallrisk = 75;
else if smallrisk = 4 then smallrisk = 100;

if smallrisk in (75, 100) then smallrisk1 = 1;
else smallrisk1 = 0;

* My insurance would cover anything I might lose from wildfire;
allcovered = fx_prv_7;

if allcovered = 0 then allcovered = 0;
else if allcovered = 1 then allcovered = 25;
else if allcovered = 2 then allcovered = 50;
else if allcovered = 3 then allcovered = 75;
else if allcovered = 4 then allcovered = 100;

if allcovered in (75, 100) then allcovered1 = 1;
else allcovered1 = 0;

* I might move before having the full benefits;
movebenefit = fx_prv_8;

if movebenefit = 0 then movebenefit = 0;
else if movebenefit = 1 then movebenefit = 25;
else if movebenefit = 2 then movebenefit = 50;
else if movebenefit = 3 then movebenefit = 75;
else if movebenefit = 4 then movebenefit = 100;

if movebenefit in (75, 100) then movebenefit1 = 1;
else movebenefit1 = 0;

run;

*Summary Statistics;
proc freq data=WILDFIRE;
tables notachieved fx_prv_4 costnothing fx_prv_5 smallrisk fx_prv_6 allcovered fx_prv_7 movebenefit fx_prv_8;
run;

proc means data=WILDFIRE;
var notachieved fx_prv_4 costnothing fx_prv_5 smallrisk fx_prv_6 allcovered fx_prv_7 movebenefit fx_prv_8;
run;


* I value the peace of mind from reducing risk of wildfire;
data WILDFIRE;
set WILDFIRE;
peacemind = fx_prv_9;

if peacemind = 0 then peacemind = 0;
else if peacemind = 1 then peacemind = 25;
else if peacemind = 2 then peacemind = 50;
else if peacemind = 3 then peacemind = 75;
else if peacemind = 4 then peacemind = 100;

if peacemind in (75, 100) then peacemind1 = 1;
else peacemind1 = 0;

* My actions would reduce the risk of fire spreading to other homes;
altruism = fx_prv_10;

if altruism = 0 then altruism = 0;
else if altruism = 1 then altruism = 25;
else if altruism = 2 then altruism = 50;
else if altruism = 3 then altruism = 75;
else if altruism = 4 then altruism = 100;

if altruism in (75, 100) then altruism1 = 1;
else altruism1 = 0;

* I could not afford losing this much from a fire;
notaffloss = fx_prv_11;

if notaffloss = 0 then notaffloss = 0;
else if notaffloss = 1 then notaffloss = 25;
else if notaffloss = 2 then notaffloss = 50;
else if notaffloss = 3 then notaffloss = 75;
else if notaffloss = 4 then notaffloss = 100;

if notaffloss in (75, 100) then notaffloss1 = 1;
else notaffloss1 = 0;

* I cannot afford the cost;
cannotafford = fx_pub_1;

if cannotafford = 0 then cannotafford = 0;
else if cannotafford = 1 then cannotafford = 25;
else if cannotafford = 2 then cannotafford = 50;
else if cannotafford = 3 then cannotafford = 75;
else if cannotafford = 4 then cannotafford = 100;

if cannotafford in (75, 100) then cannotafford1 = 1;
else cannotafford1 = 0;

* This program has no value to me;
prognovalue = fx_pub_2;

if prognovalue = 0 then prognovalue = 0;
else if prognovalue = 1 then prognovalue = 25;
else if prognovalue = 2 then prognovalue = 50;
else if prognovalue = 3 then prognovalue = 75;
else if prognovalue = 4 then prognovalue = 100;

if prognovalue in (75, 100) then prognovalue1 = 1;
else prognovalue1 = 0;

* I like that the program reduces risk to the entire community;
data COMMUNITY;
set COMMUNITY;
altrusimpub = fx_pub_3;

if altrusimpub = 0 then altrusimpub = 0;
else if altrusimpub = 1 then altrusimpub = 25;
else if altrusimpub = 2 then altrusimpub = 50;
else if altrusimpub = 3 then altrusimpub = 75;
else if altrusimpub = 4 then altrusimpub = 100;

if altrusimpub in (75, 100) then altrusimpub1 = 1;
else altrusimpub1 = 0;

* I don't believe that the work would be done;
dontbelieve = fx_pub_4;

if dontbelieve = 0 then dontbelieve = 0;
else if dontbelieve = 1 then dontbelieve = 25;
else if dontbelieve = 2 then dontbelieve = 50;
else if dontbelieve = 3 then dontbelieve = 75;
else if dontbelieve = 4 then dontbelieve = 100;

if dontbelieve in (75, 100) then dontbelieve1 = 1;
else dontbelieve1 = 0;

* I prefer to spend the money on defensible space for my own property;
ownpropertydfs = fx_pub_5;

if ownpropertydfs = 0 then ownpropertydfs = 0;
else if ownpropertydfs = 1 then ownpropertydfs = 25;
else if ownpropertydfs = 2 then ownpropertydfs = 50;
else if ownpropertydfs = 3 then ownpropertydfs = 75;
else if ownpropertydfs = 4 then ownpropertydfs = 100;

if ownpropertydfs in (75, 100) then ownpropertydfs1 = 1;
else ownpropertydfs1 = 0;

* The changes in risk due to the program are too small to matter to me;
smallriskchange = fx_pub_6;

if smallriskchange = 0 then smallriskchange = 0;
else if smallriskchange = 1 then smallriskchange = 25;
else if smallriskchange = 2 then smallriskchange = 50;
else if smallriskchange = 3 then smallriskchange = 75;
else if smallriskchange = 4 then smallriskchange = 100;

if smallriskchange in (75, 100) then smallriskchange1 = 1;
else smallriskchange1 = 0;


* This is important to me;
data IMPORTANCE;
set IMPORTANCE;
important = fx_pub_7;

if important = 0 then important = 0;
else if important = 1 then important = 25;
else if important = 2 then important = 50;
else if important = 3 then important = 75;
else if important = 4 then important = 100;

if important in (75, 100) then important1 = 1;
else important1 = 0;

* I wouldn't want to lose my house to wildfire if I can prevent it;
preventpub = fx_pub_8;

if preventpub = 0 then preventpub = 0;
else if preventpub = 1 then preventpub = 25;
else if preventpub = 2 then preventpub = 50;
else if preventpub = 3 then preventpub = 75;
else if preventpub = 4 then preventpub = 100;

if preventpub in (75, 100) then preventpub1 = 1;
else preventpub1 = 0;

* I might move before realizing the full benefits of the program;/

movebeforebenefit = fx_pub_9;
if movebeforebenefit = 0 then movebeforebenefit = 0;
else if movebeforebenefit = 1 then movebeforebenefit = 25;
else if movebeforebenefit = 2 then movebeforebenefit = 50;
else if movebeforebenefit = 3 then movebeforebenefit = 75;
else if movebeforebenefit = 4 then movebeforebenefit = 100;

if movebeforebenefit in (75, 100) then movebeforebenefit1 = 1;
else movebeforebenefit1 = 0;

* My insurance would cover anything I might lose from wildfire;


insurancecoveredall = fx_pub_10;
if insurancecoveredall = 0 then insurancecoveredall = 0;
else if insurancecoveredall = 1 then insurancecoveredall = 25;
else if insurancecoveredall = 2 then insurancecoveredall = 50;
else if insurancecoveredall = 3 then insurancecoveredall = 75;
else if insurancecoveredall = 4 then insurancecoveredall = 100;

if insurancecoveredall in (75, 100) then insurancecoveredall1 = 1;
else insurancecoveredall1 = 0;


* I value the peace of mind from reducing risk of wildfire;
data PEACE_OF_MIND;
set PEACE_OF_MIND;
peacemindpub = fx_pub_11;

if peacemindpub = 0 then peacemindpub = 0;
else if peacemindpub = 1 then peacemindpub = 25;
else if peacemindpub = 2 then peacemindpub = 50;
else if peacemindpub = 3 then peacemindpub = 75;
else if peacemindpub = 4 then peacemindpub = 100;

if peacemindpub in (75, 100) then peacemindpub1 = 1;
else peacemindpub1 = 0;

* This might cause conflict in the community;
data COMM_CONFLICT;
set COMM_CONFLICT;
conflictcommunity = fx_pub_12;

if conflictcommunity = 0 then conflictcommunity = 0;
else if conflictcommunity = 1 then conflictcommunity = 25;
else if conflictcommunity = 2 then conflictcommunity = 50;
else if conflictcommunity = 3 then conflictcommunity = 75;
else if conflictcommunity = 4 then conflictcommunity = 100;

if conflictcommunity in (75, 100) then conflictcommunity1 = 1;
else conflictcommunity1 = 0;

* I am very attached to this community;
data COMM_ATT;
set COMM_ATT;
commatt_1 = feel_1;

if commatt_1 = 0 then commatt_1 = 0;
else if commatt_1 = 1 then commatt_1 = 25;
else if commatt_1 = 2 then commatt_1 = 50;
else if commatt_1 = 3 then commatt_1 = 75;
else if commatt_1 = 4 then commatt_1 = 100;

if commatt_1 in (75, 100) then commatt_11 = 1;
else commatt_11 = 0;

* I identify strongly with this community;
commatt_2 = feel_2;

if commatt_2 = 0 then commatt_2 = 0;
else if commatt_2 = 1 then commatt_2 = 25;
else if commatt_2 = 2 then commatt_2 = 50;
else if commatt_2 = 3 then commatt_2 = 75;
else if commatt_2 = 4 then commatt_2 = 100;

if commatt_2 in (75, 100) then commatt_21 = 1;
else commatt_21 = 0;

* No other place can compare to this community;
commatt_3 = feel_3;

if commatt_3 = 0 then commatt_3 = 0;
else if commatt_3 = 1 then commatt_3 = 25;
else if commatt_3 = 2 then commatt_3 = 50;
else if commatt_3 = 3 then commatt_3 = 75;
else if commatt_3 = 4 then commatt_3 = 100;

if commatt_3 in (75, 100) then commatt_31 = 1;
else commatt_31 = 0;


* This community is the best place for me to live;
data COMM_ATT;
set COMM_ATT;
commatt_4 = feel_4;

if commatt_4 = 0 then commatt_4 = 0;
else if commatt_4 = 1 then commatt_4 = 25;
else if commatt_4 = 2 then commatt_4 = 50;
else if commatt_4 = 3 then commatt_4 = 75;
else if commatt_4 = 4 then commatt_4 = 100;

if commatt_4 in (75, 100) then commatt_41 = 1;
else commatt_41 = 0;

* This is a tight-knit community;
commatt_5 = feel_5;

if commatt_5 = 0 then commatt_5 = 0;
else if commatt_5 = 1 then commatt_5 = 25;
else if commatt_5 = 2 then commatt_5 = 50;
else if commatt_5 = 3 then commatt_5 = 75;
else if commatt_5 = 4 then commatt_5 = 100;

if commatt_5 in (75, 100) then commatt_51 = 1;
else commatt_51 = 0;

* I know the names of all my neighbors;
commatt_6 = feel_6;

if commatt_6 = 0 then commatt_6 = 0;
else if commatt_6 = 1 then commatt_6 = 25;
else if commatt_6 = 2 then commatt_6 = 50;
else if commatt_6 = 3 then commatt_6 = 75;
else if commatt_6 = 4 then commatt_6 = 100;

if commatt_6 in (75, 100) then commatt_61 = 1;
else commatt_61 = 0;

* I know my nearest neighbors well;
commatt_7 = feel_7;

if commatt_7 = 0 then commatt_7 = 0;
else if commatt_7 = 1 then commatt_7 = 25;
else if commatt_7 = 2 then commatt_7 = 50;
else if commatt_7 = 3 then commatt_7 = 75;
else if commatt_7 = 4 then commatt_7 = 100;

if commatt_7 in (75, 100) then commatt_71 = 1;
else commatt_71 = 0;

* In your community …;
data COMM_NETWORK;
set COMM_NETWORK;
commnetwork1 = network_1;

if commnetwork1 = 0 then commnetwork1 = 0;
else if commnetwork1 = 1 then commnetwork1 = 25;
else if commnetwork1 = 2 then commnetwork1 = 50;
else if commnetwork1 = 3 then commnetwork1 = 75;
else if commnetwork1 = 4 then commnetwork1 = 100;

if commnetwork1 in (75, 100) then commnetwork11 = 1;
else commnetwork11 = 0;

* Have there been many community events/meetings about fire risk?;
data COMM_NETWORK;
set COMM_NETWORK;
commnetwork2 = network_2;

if commnetwork2 = 0 then commnetwork2 = 0;
else if commnetwork2 = 1 then commnetwork2 = 25;
else if commnetwork2 = 2 then commnetwork2 = 50;
else if commnetwork2 = 3 then commnetwork2 = 75;
else if commnetwork2 = 4 then commnetwork2 = 100;

if commnetwork2 in (75, 100) then commnetwork21 = 1;
else commnetwork21 = 0;

* Have you attended many of these events?;
commnetwork3 = network_3;

if commnetwork3 = 0 then commnetwork3 = 0;
else if commnetwork3 = 1 then commnetwork3 = 25;
else if commnetwork3 = 2 then commnetwork3 = 50;
else if commnetwork3 = 3 then commnetwork3 = 75;
else if commnetwork3 = 4 then commnetwork3 = 100;

if commnetwork3 in (75, 100) then commnetwork31 = 1;
else commnetwork31 = 0;

* Did many of your neighbors go?;
commnetwork4 = network_4;

if commnetwork4 = 0 then commnetwork4 = 0;
else if commnetwork4 = 1 then commnetwork4 = 25;
else if commnetwork4 = 2 then commnetwork4 = 50;
else if commnetwork4 = 3 then commnetwork4 = 75;
else if commnetwork4 = 4 then commnetwork4 = 100;

if commnetwork4 in (75, 100) then commnetwork41 = 1;
else commnetwork41 = 0;

* Have you and your neighbors discussed coordinating to reduce fire risk?;
commnetwork5 = network_5;

if commnetwork5 = 0 then commnetwork5 = 0;
else if commnetwork5 = 1 then commnetwork5 = 25;
else if commnetwork5 = 2 then commnetwork5 = 50;
else if commnetwork5 = 3 then commnetwork5 = 75;
else if commnetwork5 = 4 then commnetwork5 = 100;

if commnetwork5 in (75, 100) then commnetwork51 = 1;
else commnetwork51 = 0;

* Have you coordinated actions to reduce fire risk with neighbors?;
commnetwork6 = network_6;

if commnetwork6 = 0 then commnetwork6 = 0;
else if commnetwork6 = 1 then commnetwork6 = 25;
else if commnetwork6 = 2 then commnetwork6 = 50;
else if commnetwork6 = 3 then commnetwork6 = 75;
else if commnetwork6 = 4 then commnetwork6 = 100;

if commnetwork6 in (75, 100) then commnetwork61 = 1;
else commnetwork61 = 0;

* Do you plan to coordinate defensible space with neighbors in the future?;
commnetwork7 = network_7;

if commnetwork7 = 0 then commnetwork7 = 0;
else if commnetwork7 = 1 then commnetwork7 = 25;
else if commnetwork7 = 2 then commnetwork7 = 50;
else if commnetwork7 = 3 then commnetwork7 = 75;
else if commnetwork7 = 4 then commnetwork7 = 100;

if commnetwork7 in (75, 100) then commnetwork71 = 1;
else commnetwork71 = 0;

* Is there general agreement among neighbors about wildfire risk?;
commnetwork8 = network_8;

if commnetwork8 = 0 then commnetwork8 = 0;
else if commnetwork8 = 1 then commnetwork8 = 25;
else if commnetwork8 = 2 then commnetwork8 = 50;
else if commnetwork8 = 3 then commnetwork8 = 75;
else if commnetwork8 = 4 then commnetwork8 = 100;

if commnetwork8 in (75, 100) then commnetwork81 = 1;
else commnetwork81 = 0;

* Is there agreement about the need for taking action to reduce fire risk?;
commnetwork9 = network_9;

if commnetwork9 = 0 then commnetwork9 = 0;
else if commnetwork9 = 1 then commnetwork9 = 25;
else if commnetwork9 = 2 then commnetwork9 = 50;
else if commnetwork9 = 3 then commnetwork9 = 75;
else if commnetwork9 = 4 then commnetwork9 = 100;

if commnetwork9 in (75, 100) then commnetwork91 = 1;
else commnetwork91 = 0;

* Taking steps to protect one's home from fire should be voluntary;
protectvoluntary = agree_1;

if protectvoluntary = 0 then protectvoluntary = 0;
else if protectvoluntary = 1 then protectvoluntary = 25;
else if protectvoluntary = 2 then protectvoluntary = 50;
else if protectvoluntary = 3 then protectvoluntary = 75;
else if protectvoluntary = 4 then protectvoluntary = 100;

if protectvoluntary in (75, 100) then protectvoluntary1 = 1;
else protectvoluntary1 = 0;

* Homeowners should coordinate creating and maintaining defensible space;
coordinatedfs = agree_5;

if coordinatedfs = 0 then coordinatedfs = 0;
else if coordinatedfs = 1 then coordinatedfs = 25;
else if coordinatedfs = 2 then coordinatedfs = 50;
else if coordinatedfs = 3 then coordinatedfs = 75;
else if coordinatedfs = 4 then coordinatedfs = 100;

if coordinatedfs in (75, 100) then coordinatedfs1 = 1;
else coordinatedfs1 = 0;

* Communities should invest more in education about defensible space;
comminvestdfs = agree_7;

if comminvestdfs = 0 then comminvestdfs = 0;
else if comminvestdfs = 1 then comminvestdfs = 25;
else if comminvestdfs = 2 then comminvestdfs = 50;
else if comminvestdfs = 3 then comminvestdfs = 75;
else if comminvestdfs = 4 then comminvestdfs = 100;

if comminvestdfs in (75, 100) then comminvestdfs1 = 1;
else commcomminvestdfs = 0;


* Would you be more likely to work on defensible space if …;
* Your nearest neighbor does;
nearneighbor = more_1;

if nearneighbor = 0 then nearneighbor = 0;
else if nearneighbor = 1 then nearneighbor = 25;
else if nearneighbor = 2 then nearneighbor = 50;
else if nearneighbor = 3 then nearneighbor = 75;
else if nearneighbor = 4 then nearneighbor = 100;

if nearneighbor in (75, 100) then nearneighbor1 = 1;
else nearneighbor1 = 0;

* Other neighbors do;
otherneighbor = more_2;

if otherneighbor = 0 then otherneighbor = 0;
else if otherneighbor = 1 then otherneighbor = 25;
else if otherneighbor = 2 then otherneighbor = 50;
else if otherneighbor = 3 then otherneighbor = 75;
else if otherneighbor = 4 then otherneighbor = 100;

if otherneighbor in (75, 100) then otherneighbor1 = 1;
else otherneighbor1 = 0;

* Respected community members do;
respcommmunity = more_3;

if respcommmunity = 0 then respcommmunity = 0;
else if respcommmunity = 1 then respcommmunity = 25;
else if respcommmunity = 2 then respcommmunity = 50;
else if respcommmunity = 3 then respcommmunity = 75;
else if respcommmunity = 4 then respcommmunity = 100;

if respcommmunity in (75, 100) then respcommmunity1 = 1;
else respcommmunity1 = 0;

* Family members living elsewhere do;
familyelse = more_4;

if familyelse = 0 then familyelse = 0;
else if familyelse = 1 then familyelse = 25;
else if familyelse = 2 then familyelse = 50;
else if familyelse = 3 then familyelse = 75;
else if familyelse = 4 then familyelse = 100;

if familyelse in (75, 100) then familyelse1 = 1;
else familyelse1 = 0;

* You hear about people losing their homes to wildfire somewhere else;
losehomeelse = more_5;

if losehomeelse = 0 then losehomeelse = 0;
else if losehomeelse = 1 then losehomeelse = 25;
else if losehomeelse = 2 then losehomeelse = 50;
else if losehomeelse = 3 then losehomeelse = 75;
else if losehomeelse = 4 then losehomeelse = 100;

if losehomeelse in (75, 100) then losehomeelse1 = 1;
else losehomeelse1 = 0;

* You knew where to start;
knewstart = more_6;

if knewstart = 0 then knewstart = 0;
else if knewstart = 1 then knewstart = 25;
else if knewstart = 2 then knewstart = 50;
else if knewstart = 3 then knewstart = 75;
else if knewstart = 4 then knewstart = 100;

if knewstart in (75, 100) then knewstart1 = 1;
else knewstart1 = 0;

* You knew which actions would be most effective for you;
effactions = more_7;

if effactions = 0 then effactions = 0;
else if effactions = 1 then effactions = 25;
else if effactions = 2 then effactions = 50;
else if effactions = 3 then effactions = 75;
else if effactions = 4 then effactions = 100;

if effactions in (75, 100) then effactions1 = 1;
else effactions1 = 0;

* In your community, what do you think reduced wildfire risk in 2011;
* Many residents take extensive defensible space actions;
extensivedfs = reduce_1;

if extensivedfs = 0 then extensivedfs = 0;
else if extensivedfs = 1 then extensivedfs = 25;
else if extensivedfs = 2 then extensivedfs = 50;
else if extensivedfs = 3 then extensivedfs = 75;
else if extensivedfs = 4 then extensivedfs = 100;

if extensivedfs in (75, 100) then extensivedfs1 = 1;
else extensivedfs1 = 0;

* Information provided by community groups about defensible space;
informationdfs = reduce_2;

if informationdfs = 0 then informationdfs = 0;
else if informationdfs = 1 then informationdfs = 25;
else if informationdfs = 2 then informationdfs = 50;
else if informationdfs = 3 then informationdfs = 75;
else if informationdfs = 4 then informationdfs = 100;

if informationdfs in (75, 100) then informationdfs1 = 1;
else informationdfs1 = 0;

* Vegetation on nearby public lands is managed well;
vegepubland = reduce_3;

if vegepubland = 0 then vegepubland = 0;
else if vegepubland = 1 then vegepubland = 25;
else if vegepubland = 2 then vegepubland = 50;
else if vegepubland = 3 then vegepubland = 75;
else if vegepubland = 4 then vegepubland = 100;

if vegepubland in (75, 100) then vegepubland1 = 1;
else vegepubland1 = 0;


* Neighbors or community groups will help others with defensible space;
commhelpdfs = reduce_4;

if commhelpdfs = 0 then commhelpdfs = 0;
else if commhelpdfs = 1 then commhelpdfs = 25;
else if commhelpdfs = 2 then commhelpdfs = 50;
else if commhelpdfs = 3 then commhelpdfs = 75;
else if commhelpdfs = 4 then commhelpdfs = 100;

if commhelpdfs in (75, 100) then commhelpdfs1 = 1;
else commhelpdfs1 = 0;

* Neighbors would help evacuate people;
neighevacuate = reduce_5;

if neighevacuate = 0 then neighevacuate = 0;
else if neighevacuate = 1 then neighevacuate = 25;
else if neighevacuate = 2 then neighevacuate = 50;
else if neighevacuate = 3 then neighevacuate = 75;
else if neighevacuate = 4 then neighevacuate = 100;

if neighevacuate in (75, 100) then neighevacuate1 = 1;
else neighevacuate1 = 0;

* Neighbors would help to evacuate other peoples' animals;
neievaanimal = reduce_6;

if neievaanimal = 0 then neievaanimal = 0;
else if neievaanimal = 1 then neievaanimal = 25;
else if neievaanimal = 2 then neievaanimal = 50;
else if neievaanimal = 3 then neievaanimal = 75;
else if neievaanimal = 4 then neievaanimal = 100;

if neievaanimal in (75, 100) then neievaanimal1 = 1;
else neievaanimal1 = 0;

* Neighbors would help each other protect homes by fighting fires;
neiprotecthome = reduce_7;

if neiprotecthome = 0 then neiprotecthome = 0;
else if neiprotecthome = 1 then neiprotecthome = 25;
else if neiprotecthome = 2 then neiprotecthome = 50;
else if neiprotecthome = 3 then neiprotecthome = 75;
else if neiprotecthome = 4 then neiprotecthome = 100;

if neiprotecthome in (75, 100) then neiprotecthome1 = 1;
else neiprotecthome1 = 0;


* People who create and maintain defensible space should get tax breaks;
taxbreaks = agree_2;

if taxbreaks = 0 then taxbreaks = 0;
else if taxbreaks = 1 then taxbreaks = 25;
else if taxbreaks = 2 then taxbreaks = 50;
else if taxbreaks = 3 then taxbreaks = 75;
else if taxbreaks = 4 then taxbreaks = 100;

if taxbreaks in (75, 100) then taxbreaks1 = 1;
else taxbreaks1 = 0;

* People who maintain defensible space should have lower insurance rates;
lowinsurance = agree_3;

if lowinsurance = 0 then lowinsurance = 0;
else if lowinsurance = 1 then lowinsurance = 25;
else if lowinsurance = 2 then lowinsurance = 50;
else if lowinsurance = 3 then lowinsurance = 75;
else if lowinsurance = 4 then lowinsurance = 100;

if lowinsurance in (75, 100) then lowinsurance1 = 1;
else lowinsurance1 = 0;

* People should be required by law to maintain defensible space;
lawmaintain = agree_4;

if lawmaintain = 0 then lawmaintain = 0;
else if lawmaintain = 1 then lawmaintain = 25;
else if lawmaintain = 2 then lawmaintain = 50;
else if lawmaintain = 3 then lawmaintain = 75;
else if lawmaintain = 4 then lawmaintain = 100;

if lawmaintain in (75, 100) then lawmaintain1 = 1;
else lawmaintain1 = 0;

* Government should subsidize creation of defensible space through grants;
govtsubsidy = agree_6;

if govtsubsidy = 0 then govtsubsidy = 0;
else if govtsubsidy = 1 then govtsubsidy = 25;
else if govtsubsidy = 2 then govtsubsidy = 50;
else if govtsubsidy = 3 then govtsubsidy = 75;
else if govtsubsidy = 4 then govtsubsidy = 100;

if govtsubsidy in (75, 100) then govtsubsidy1 = 1;
else govtsubsidy1 = 0;

* Thinking about the agencies that manage public lands near to your house; do you feel that they…;
* Share similar values as you;
similarvalue = govt_1;

if similarvalue = 0 then similarvalue = 0;
else if similarvalue = 1 then similarvalue = 25;
else if similarvalue = 2 then similarvalue = 50;
else if similarvalue = 3 then similarvalue = 75;
else if similarvalue = 4 then similarvalue = 100;

if similarvalue in (75, 100) then similarvalue1 = 1;
else similarvalue1 = 0;


* People who create and maintain defensible space should get tax breaks;
taxbreaks = agree_2;

if taxbreaks = 0 then taxbreaks = 0;
else if taxbreaks = 1 then taxbreaks = 25;
else if taxbreaks = 2 then taxbreaks = 50;
else if taxbreaks = 3 then taxbreaks = 75;
else if taxbreaks = 4 then taxbreaks = 100;

if taxbreaks in (75, 100) then taxbreaks1 = 1;
else taxbreaks1 = 0;

* People who maintain defensible space should have lower insurance rates;
lowinsurance = agree_3;

if lowinsurance = 0 then lowinsurance = 0;
else if lowinsurance = 1 then lowinsurance = 25;
else if lowinsurance = 2 then lowinsurance = 50;
else if lowinsurance = 3 then lowinsurance = 75;
else if lowinsurance = 4 then lowinsurance = 100;

if lowinsurance in (75, 100) then lowinsurance1 = 1;
else lowinsurance1 = 0;

* People should be required by law to maintain defensible space;
lawmaintain = agree_4;

if lawmaintain = 0 then lawmaintain = 0;
else if lawmaintain = 1 then lawmaintain = 25;
else if lawmaintain = 2 then lawmaintain = 50;
else if lawmaintain = 3 then lawmaintain = 75;
else if lawmaintain = 4 then lawmaintain = 100;

if lawmaintain in (75, 100) then lawmaintain1 = 1;
else lawmaintain1 = 0;

* Government should subsidize creation of defensible space through grants;
govtsubsidy = agree_6;

if govtsubsidy = 0 then govtsubsidy = 0;
else if govtsubsidy = 1 then govtsubsidy = 25;
else if govtsubsidy = 2 then govtsubsidy = 50;
else if govtsubsidy = 3 then govtsubsidy = 75;
else if govtsubsidy = 4 then govtsubsidy = 100;

if govtsubsidy in (75, 100) then govtsubsidy1 = 1;
else govtsubsidy1 = 0;

* Thinking about the agencies that manage public lands near to your house; do you feel that they…;
* Share similar values as you;
similarvalue = govt_1;

if similarvalue = 0 then similarvalue = 0;
else if similarvalue = 1 then similarvalue = 25;
else if similarvalue = 2 then similarvalue = 50;
else if similarvalue = 3 then similarvalue = 75;
else if similarvalue = 4 then similarvalue = 100;

if similarvalue in (75, 100) then similarvalue1 = 1;
else similarvalue1 = 0;


* Share similar goals as you;
similargoal = govt_2;

if similargoal = 0 then similargoal = 0;
else if similargoal = 1 then similargoal = 25;
else if similargoal = 2 then similargoal = 50;
else if similargoal = 3 then similargoal = 75;
else if similargoal = 4 then similargoal = 100;

if similargoal in (75, 100) then similargoal1 = 1;
else similargoal1 = 0;

* Think in a similar way as you;
similarthink = govt_3;

if similarthink = 0 then similarthink = 0;
else if similarthink = 1 then similarthink = 25;
else if similarthink = 2 then similarthink = 50;
else if similarthink = 3 then similarthink = 75;
else if similarthink = 4 then similarthink = 100;

if similarthink in (75, 100) then similarthink1 = 1;
else similarthink1 = 0;

* Have the same priorities as you;
samepriorities = govt_4;

if samepriorities = 0 then samepriorities = 0;
else if samepriorities = 1 then samepriorities = 25;
else if samepriorities = 2 then samepriorities = 50;
else if samepriorities = 3 then samepriorities = 75;
else if samepriorities = 4 then samepriorities = 100;

if samepriorities in (75, 100) then samepriorities1 = 1;
else samepriorities1 = 0;


* Perceived Wildfire Risk;
* FIRE_RISK Chance a fire reaches a community;

if chcn_1 = 0 then fchcn_1 = 0.00;
else if chcn_1 = 1 then fchcn_1 = 0.125;
else if chcn_1 = 2 then fchcn_1 = 0.25;
else if chcn_1 = 3 then fchcn_1 = 0.375;
else if chcn_1 = 4 then fchcn_1 = 0.5;
else if chcn_1 = 5 then fchcn_1 = 0.625;
else if chcn_1 = 6 then fchcn_1 = 0.75;
else if chcn_1 = 7 then fchcn_1 = 0.875;
else if chcn_1 = 8 then fchcn_1 = 1.000;

if chcn_2 = 0 then fchcn_2 = 0.00;
else if chcn_2 = 1 then fchcn_2 = 0.125;
else if chcn_2 = 2 then fchcn_2 = 0.25;
else if chcn_2 = 3 then fchcn_2 = 0.375;
else if chcn_2 = 4 then fchcn_2 = 0.5;
else if chcn_2 = 5 then fchcn_2 = 0.625;
else if chcn_2 = 6 then fchcn_2 = 0.75;
else if chcn_2 = 7 then fchcn_2 = 0.875;
else if chcn_2 = 8 then fchcn_2 = 1.000;

fire_risk = fchcn_1 * fchcn_2;

* EFFICACY Trust in Defensible Space;

if all_1 = 8 then eff_1 = 0.00;
else if all_1 = 7 then eff_1 = 0.125;
else if all_1 = 6 then eff_1 = 0.25;
else if all_1 = 5 then eff_1 = 0.375;
else if all_1 = 4 then eff_1 = 0.5;
else if all_1 = 3 then eff_1 = 0.625;
else if all_1 = 2 then eff_1 = 0.75;
else if all_1 = 1 then eff_1 = 0.875;
else if all_1 = 0 then eff_1 = 1.00;

if all_2 = 8 then eff_2 = 0.00;
else if all_2 = 7 then eff_2 = 0.125;
else if all_2 = 6 then eff_2 = 0.25;
else if all_2 = 5 then eff_2 = 0.375;
else if all_2 = 4 then eff_2 = 0.5;
else if all_2 = 3 then eff_2 = 0.625;
else if all_2 = 2 then eff_2 = 0.75;
else if all_2 = 1 then eff_2 = 0.875;
else if all_2 = 0 then eff_2 = 1.00;

if all_3 = 8 then eff_3 = 0.00;
else if all_3 = 7 then eff_3 = 0.125;
else if all_3 = 6 then eff_3 = 0.25;
else if all_3 = 5 then eff_3 = 0.375;
else if all_3 = 4 then eff_3 = 0.5;
else if all_3 = 3 then eff_3 = 0.625;
else if all_3 = 2 then eff_3 = 0.75;
else if all_3 = 1 then eff_3 = 0.875;
else if all_3 = 0 then eff_3 = 1.00;

efficacy = (eff_1 + eff_2 + eff_3) / 3;



* Summary Statistics/Perceived wild fire risk;


* Previous Fire Safe Investment;

proc summary data=mydata;
    var hh_work hh_spend iz_work iz_spend oz_work oz_spend;
    output out=sumstat sum=;
run;

data mydata;
    set mydata;
    if hh_work = 1 or hh_spend = 1 or iz_work = 1 or iz_spend = 1 or oz_work = 1 or oz_spend = 1 then fsi = 1;
    else fsi = 0;

    if hh_spend = 1 or iz_spend = 1 or oz_spend = 1 then money = 1;
    else money = 0;

    if hh_work = 1 or iz_work = 1 or oz_work = 1 then time2 = 1;
    else time2 = 0;
run;

* Replace "defsp" with the appropriate variable name in your dataset;



* woodpile1;
data mydata;
    set mydata;
    woodpile1 = woodpile;
    if woodpile1 = 0 then woodpile1 = 0;
    else if woodpile1 = 1 then woodpile1 = 1;
run;

* access1;
data mydata;
    set mydata;
    access1 = access;
    if access1 = 0 then access1 = 0;
    else if access1 = 1 then access1 = 1;
run;


* Are there one or more wooden sheds within 30 feet of this house?;
data mydata;
    set mydata;
    shed1 = shed;
    if shed1 = 0 then shed1 = 0;
    else if shed1 = 1 then shed1 = 1;
run;

* Are there any outdoor tanks for heating oil or propane within 500 feet of this house?;
data mydata;
    set mydata;
    tank1 = tank;
    if tank1 = 0 then tank1 = 0;
    else if tank1 = 1 then tank1 = 1;
run;

* Do you have a cedar shake roof?;
data mydata;
    set mydata;
    roof1 = roof;
    if roof1 = 0 then roof1 = 0;
    else if roof1 = 1 then roof1 = 1;
run;

* Do you have a water supply for fire (hydrant, tank, pond, ditch) within 30 feet of this house?;
data mydata;
    set mydata;
    water1 = water;
    if water1 = 0 then water1 = 0;
    else if water1 = 1 then water1 = 1;
run;



* Why not do more to this house (the structure itself) to reduce fire risk?;

* Already done enough to the house;
data mydata;
    set mydata;
    denhouse = more_hh_1;
    if denhouse = 0 then denhouse1 = 0;
    else if denhouse = 1 then denhouse1 = 0;
    else if denhouse = 2 then denhouse1 = 0;
    else if denhouse = 3 then denhouse1 = 1;
    else if denhouse = 4 then denhouse1 = 1;
run;

* My inner zone already protects the house well enough;
data mydata;
    set mydata;
    izaprotect = more_hh_2;
    if izaprotect = 0 then izaprotect1 = 0;
    else if izaprotect = 1 then izaprotect1 = 0;
    else if izaprotect = 2 then izaprotect1 = 0;
    else if izaprotect = 3 then izaprotect1 = 1;
    else if izaprotect = 4 then izaprotect1 = 1;
run;

* My outer zone already protects the house well enough;
data mydata;
    set mydata;
    ozaprotect = more_hh_3;
    if ozaprotect = 0 then ozaprotect1 = 0;
    else if ozaprotect = 1 then ozaprotect1 = 0;
    else if ozaprotect = 2 then ozaprotect1 = 0;
    else if ozaprotect = 3 then ozaprotect1 = 1;
    else if ozaprotect = 4 then ozaprotect1 = 1;
run;

* It would cost more than I could gain;
data mydata;
    set mydata;
    costmore = more_hh_6;
    if costmore = 0 then costmore1 = 0;
    else if costmore = 1 then costmore1 = 0;
    else if costmore

* It would cost more than I could gain;
data mydata;
    set mydata;
    costmore = more_hh_6;
    if costmore = 0 then costmore1 = 0;
    else if costmore = 1 then costmore1 = 0;
    else if costmore = 2 then costmore1 = 0;
    else if costmore = 3 then costmore1 = 1;
    else if costmore = 4 then costmore1 = 1;
run;

* (For SAS, consider using PROC FREQ or PROC MEANS to obtain summary statistics);

* Why not do more to the inner zone around this house?;
data mydata;
    set mydata;
    izdoneenough = more_iz_1;
    if izdoneenough = 0 then izdoneenough1 = 0;
    else if izdoneenough = 1 then izdoneenough1 = 0;
    else if izdoneenough = 2 then izdoneenough1 = 0;
    else if izdoneenough = 3 then izdoneenough1 = 1;
    else if izdoneenough = 4 then izdoneenough1 = 1;
run;

* Why not do more to the outer zone around this house?;
data mydata;
    set mydata;
    ozdoneenough = more_iz_1;
    if ozdoneenough = 0 then ozdoneenough1 = 0;
    else if ozdoneenough = 1 then ozdoneenough1 = 0;
    else if ozdoneenough = 2 then ozdoneenough1 = 0;
    else if ozdoneenough = 3 then ozdoneenough1 = 1;
    else if ozdoneenough = 4 then ozdoneenough1 = 1;
run;


* What is in the inner zone around your house;
* Green Lawn;
data mydata;
    set mydata;
    if iz_1 = 0 then greenlawn = 0.00;
    else if iz_1 = 1 then greenlawn = 0.20;
    else if iz_1 = 2 then greenlawn = 0.40;
    else if iz_1 = 3 then greenlawn = 0.60;
    else if iz_1 = 4 then greenlawn = 0.80;
    else if iz_1 = 5 then greenlawn = 1.00;
run;

data mydata;
    set mydata;
    if iz_1 = 0 then greenlawn1 = 0;
    else if iz_1 = 1 then greenlawn1 = 20;
    else if iz_1 = 2 then greenlawn1 = 40;
    else if iz_1 = 3 then greenlawn1 = 60;
    else if iz_1 = 4 then greenlawn1 = 80;
    else if iz_1 = 5 then greenlawn1 = 100;
run;

* Rock/sand/other non flammable landscaping materials;
data mydata;
    set mydata;
    if iz_2 = 0 then nonflammable = 0.00;
    else if iz_2 = 1 then nonflammable = 0.20;
    else if iz_2 = 2 then nonflammable = 0.40;
    else if iz_2 = 3 then nonflammable = 0.60;
    else if iz_2 = 4 then nonflammable = 0.80;
    else if iz_2 = 5 then nonflammable = 1.00;
run;

data mydata;
    set mydata;
    if iz_2 = 0 then nonflammable1 = 0;
    else if iz_2 = 1 then nonflammable1 = 20;
    else if iz_2 = 2 then nonflammable1 = 40;
    else if iz_2 = 3 then nonflammable1 = 60;
    else if iz_2 = 4 then nonflammable1 = 80;
    else if iz_2 = 5 then nonflammable1 = 100;
run;

* Cheatgrass and other invasive grasses and weeds;
data mydata;
    set mydata;
    if iz_3 = 0 then cheatinvagrass = 0.00;
    else if iz_3 = 1 then cheatinvagrass = 0.20;
    else if iz_3 = 2 then cheatinvagrass = 0.40;
    else if iz_3 = 3 then cheatinvagrass = 0.60;
    else if iz_3 = 4 then cheatinvagrass = 0.80;
    else if iz_3 = 5 then cheatinvagrass = 1.00;
run;

data mydata;
    set mydata;
    if iz_3 = 0 then cheatinvagrass1 = 0;
    else if iz_3 = 1 then cheatinvagrass1 = 20;
    else if iz_3 = 2 then cheatinvagrass1 = 40;
    else if iz_3 = 3 then cheatinvagrass1 = 60;
    else if iz_3 = 4 then cheatinvagrass1 = 80;
    else if iz_3 = 5 then cheatinvagrass1 = 100;
run;

* Leafy trees like maples or oaks;
data mydata;
    set mydata;
    if iz_4 = 0 then mapleoaks = 0.00;
    else if iz_4 = 1 then mapleoaks = 0.20;
    else if iz_4 = 2 then mapleoaks = 0.40;
    else if iz_4 = 3 then mapleoaks = 0.60;
    else if iz_4 = 4 then mapleoaks = 0.80;
    else if iz_4 = 5 then mapleoaks = 1.00;
run;

data mydata;
    set mydata;
    if iz_4 = 0 then mapleoaks1 = 0;
    else if iz_4 = 1 then mapleoaks1 = 20;
    else if iz_4 = 2 then mapleoaks1 = 40;
    else if iz_4 = 3 then mapleoaks1 = 60;
    else if iz_4 = 4 then mapleoaks1 = 80;
    else if iz_4 = 5 then mapleoaks1 = 100;
run;

* Evergreen trees (pines, spruce, and fir trees);
data mydata;
    set mydata;
    if iz_5 = 0 then evgreentrees = 0.00;
    else if iz_5 = 1 then evgreentrees = 0.20;
    else if iz_5 = 2 then evgreentrees = 0.40;
    else if iz_5 = 3 then evgreentrees = 0.60;
    else if iz_5 = 4 then evgreentrees = 0.80;
    else if iz_5 = 5 then evgreentrees = 1.00;
run;

data mydata;
    set mydata;
    if iz_5 = 0 then evgreentrees1 = 0;
    else if iz_5 = 1 then evgreentrees1 = 20;
    else if iz_5 = 2 then evgreentrees1 = 40;
    else if iz_5 = 3 then evgreentrees1 = 60;
    else if iz_5 = 4 then evgreentrees1 = 80;
    else if iz_5 = 5 then evgreentrees1 = 100;
run;

* Juniper bushes;
data mydata;
    set mydata;
    if iz_6 = 0 then junibushes = 0.00;
    else if iz_6 = 1 then junibushes = 0.20;
    else if iz_6 = 2 then junibushes = 0.40;
    else if iz_6 = 3 then junibushes = 0.60;
    else if iz_6 = 4 then junibushes = 0.80;
    else if iz_6 = 5 then junibushes = 1.00;
run;

data mydata;
    set mydata;
    if iz_6 = 0 then junibushes1 = 0;
    else if iz_6 = 1 then junibushes1 = 20;
    else if iz_6 = 2 then junibushes1 = 40;
    else if iz_6 = 3 then junibushes1 = 60;
    else if iz_6 = 4 then junibushes1 = 80;
    else if iz_6 = 5 then junibushes1 = 100;
run;

* Sagebrush and other native shrubs;
data mydata;
    set mydata;
    if iz_7 = 0 then nativeshrubs = 0.00;
    else if iz_7 = 1 then nativeshrubs = 0.20;
    else if iz_7 = 2 then nativeshrubs = 0.40;
    else if iz_7 = 3 then nativeshrubs = 0.60;
    else if iz_7 = 4 then nativeshrubs = 0.80;
    else if iz_7 = 5 then nativeshrubs = 1.00;
run;

data mydata;
    set mydata;
    if iz_7 = 0 then nativeshrubs1 = 0;
    else if iz_7 = 1 then nativeshrubs1 = 20;
    else if iz_7 = 2 then nativeshrubs1 = 40;
    else if iz_7 = 3 then nativeshrubs1 = 60;
    else if iz_7 = 4 then nativeshrubs1 = 80;
    else if iz_7 = 5 then nativeshrubs1 = 100;
run;

* Summary Statistics;
proc means data=mydata n mean min max;
    var greenlawn1 nonflammable1 cheatinvagrass1 mapleoaks1 evgreentrees1 junibushes1 nativeshrubs1;
run;

proc means data=mydata n mean min max;
    var greenlawn nonflammable cheatinvagrass mapleoaks evgreentrees junibushes nativeshrubs;
run;

* What is in the outer zone around your house;
data mydata;
    set mydata;
    if oz_1 = 0 then ozgreenlawn = 0.00;
    else if oz_1 = 1 then ozgreenlawn = 0.20;
    else if oz_1 = 2 then ozgreenlawn = 0.40;
    else if oz_1 = 3 then ozgreenlawn = 0.60;
    else if oz_1 = 4 then ozgreenlawn = 0.80;
    else if oz_1 = 5 then ozgreenlawn = 1.00;
run;

data mydata;
    set mydata;
    if oz_1 = 0 then ozgreenlawn1 = 0;
    else if oz_1 = 1 then ozgreenlawn1 = 20;
    else if oz_1 = 2 then ozgreenlawn1 = 40;
    else if oz_1 = 3 then ozgreenlawn1 = 60;
    else if oz_1 = 4 then ozgreenlawn1 = 80;
    else if oz_1 = 5 then ozgreenlawn1 = 100;
run;


* Rock/sand/other non-flammable landscaping materials;
data mydata;
    set mydata;
    if oz_2 = 0 then oznonflammable = 0.00;
    else if oz_2 = 1 then oznonflammable = 0.20;
    else if oz_2 = 2 then oznonflammable = 0.40;
    else if oz_2 = 3 then oznonflammable = 0.60;
    else if oz_2 = 4 then oznonflammable = 0.80;
    else if oz_2 = 5 then oznonflammable = 1.00;
run;

data mydata;
    set mydata;
    if oz_2 = 0 then oznonflammable1 = 0;
    else if oz_2 = 1 then oznonflammable1 = 20;
    else if oz_2 = 2 then oznonflammable1 = 40;
    else if oz_2 = 3 then oznonflammable1 = 60;
    else if oz_2 = 4 then oznonflammable1 = 80;
    else if oz_2 = 5 then oznonflammable1 = 100;
run;

* Leafy trees like maples or oaks;
data mydata;
    set mydata;
    if oz_3 = 0 then ozmapleoaks = 0.00;
    else if oz_3 = 1 then ozmapleoaks = 0.20;
    else if oz_3 = 2 then ozmapleoaks = 0.40;
    else if oz_3 = 3 then ozmapleoaks = 0.60;
    else if oz_3 = 4 then ozmapleoaks = 0.80;
    else if oz_3 = 5 then ozmapleoaks = 1.00;
run;

data mydata;
    set mydata;
    if oz_3 = 0 then ozmapleoaks1 = 0;
    else if oz_3 = 1 then ozmapleoaks1 = 20;
    else if oz_3 = 2 then ozmapleoaks1 = 40;
    else if oz_3 = 3 then ozmapleoaks1 = 60;
    else if oz_3 = 4 then ozmapleoaks1 = 80;
    else if oz_3 = 5 then ozmapleoaks1 = 100;
run;


* Evergreen trees (pines, spruce, and fir trees);
data mydata;
    set mydata;
    if oz_4 = 0 then ozevgreentrees = 0.00;
    else if oz_4 = 1 then ozevgreentrees = 0.20;
    else if oz_4 = 2 then ozevgreentrees = 0.40;
    else if oz_4 = 3 then ozevgreentrees = 0.60;
    else if oz_4 = 4 then ozevgreentrees = 0.80;
    else if oz_4 = 5 then ozevgreentrees = 1.00;
run;

data mydata;
    set mydata;
    if oz_4 = 0 then ozevgreentrees1 = 0;
    else if oz_4 = 1 then ozevgreentrees1 = 20;
    else if oz_4 = 2 then ozevgreentrees1 = 40;
    else if oz_4 = 3 then ozevgreentrees1 = 60;
    else if oz_4 = 4 then ozevgreentrees1 = 80;
    else if oz_4 = 5 then ozevgreentrees1 = 100;
run;

* Juniper shrubs;
data mydata;
    set mydata;
    if oz_5 = 0 then ozjunishurbs = 0.00;
    else if oz_5 = 1 then ozjunishurbs = 0.20;
    else if oz_5 = 2 then ozjunishurbs = 0.40;
    else if oz_5 = 3 then ozjunishurbs = 0.60;
    else if oz_5 = 4 then ozjunishurbs = 0.80;
    else if oz_5 = 5 then ozjunishurbs = 1.00;
run;

data mydata;
    set mydata;
    if oz_5 = 0 then ozjunishurbs1 = 0;
    else if oz_5 = 1 then ozjunishurbs1 = 20;
    else if oz_5 = 2 then ozjunishurbs1 = 40;
    else if oz_5 = 3 then ozjunishurbs1 = 60;
    else if oz_5 = 4 then ozjunishurbs1 = 80;
    else if oz_5 = 5 then ozjunishurbs1 = 100;
run;

* Sagebrush and other native plants;
data mydata;
    set mydata;
    if oz_6 = 0 then oznativeplants = 0.00;
    else if oz_6 = 1 then oznativeplants = 0.20;
    else if oz_6 = 2 then oznativeplants = 0.40;
    else if oz_6 = 3 then oznativeplants = 0.60;
    else if oz_6 = 4 then oznativeplants = 0.80;
    else if oz_6 = 5 then oznativeplants = 1.00;
run;

data mydata;
    set mydata;
    if oz_6 = 0 then oznativeplants1 = 0;
    else if oz_6 = 1 then oznativeplants1 = 20;
    else if oz_6 = 2 then oznativeplants1 = 40;
    else if oz_6 = 3 then oznativeplants1 = 60;
    else if oz_6 = 4 then oznativeplants1 = 80;
    else if oz_6 = 5 then oznativeplants1 = 100;
run;

* Heavily overgrown brushy areas;
data mydata;
    set mydata;
    if oz_7 = 0 then ozovgrbrushy = 0.00;
    else if oz_7 = 1 then ozovgrbrushy = 0.20;
    else if oz_7 = 2 then ozovgrbrushy = 0.40;
    else if oz_7 = 3 then ozovgrbrushy = 0.60;
    else if oz_7 = 4 then ozovgrbrushy = 0.80;
    else if oz_7 = 5 then ozovgrbrushy = 1.00;
run;

data mydata;
    set mydata;
    if oz_7 = 0 then ozovgrbrushy1 = 0;
    else if oz_7 = 1 then ozovgrbrushy1 = 20;
    else if oz_7 = 2 then ozovgrbrushy1 = 40;
    else if oz_7 = 3 then ozovgrbrushy1 = 60;
    else if oz_7 = 4 then ozovgrbrushy1 = 80;
    else if oz_7 = 5 then ozovgrbrushy1 = 100;
run;


/* Well pruned and trimmed trees, shrubs, and plants */
data want;
set have;
oztrimtrees = .;
select (oz_8);
when (0) oztrimtrees = 0.00;
when (1) oztrimtrees = 0.20;
when (2) oztrimtrees = 0.40;
when (3) oztrimtrees = 0.60;
when (4) oztrimtrees = 0.80;
when (5) oztrimtrees = 1.00;
end;
oztrimtrees1 = 0;
select (oz_8);
when (0) oztrimtrees1 = 0;
when (1) oztrimtrees1 = 20;
when (2) oztrimtrees1 = 40;
when (3) oztrimtrees1 = 60;
when (4) oztrimtrees1 = 80;
when (5) oztrimtrees1 = 100;
end;

/* Dead trees and shrubs */
ozdeadtrees = .;
select (oz_9);
when (0) ozdeadtrees = 0.00;
when (1) ozdeadtrees = 0.20;
when (2) ozdeadtrees = 0.40;
when (3) ozdeadtrees = 0.60;
when (4) ozdeadtrees = 0.80;
when (5) ozdeadtrees = 1.00;
end;
ozdeadtrees1 = 0;
select (oz_9);
when (0) ozdeadtrees1 = 0;
when (1) ozdeadtrees1 = 20;
when (2) ozdeadtrees1 = 40;
when (3) ozdeadtrees1 = 60;
when (4) ozdeadtrees1 = 80;
when (5) ozdeadtrees1 = 100;
end;
run;

/* Don't want to make my house less attractive */
data want;
set have;
c5 = choice_5;
c5 = recode(c5, 0=0 1=25 2=50 3=75 4=100);
label c5 "Index of Utility Hits on House Aesthetics";
label define c5 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!";
c5HLA = .;
if c5 in (75, 100) then c5HLA = 1;
else if c5 in (0, 25, 50) then c5HLA = 0;

/* Don't want to make my landscaping less attractive */
c6 = choice_6;
c6 = recode(c6, 0=0 1=25 2=50 3=75 4=100);
label c6 "Index of Utility Hits on Landscaping Aesthetics";
label define c6 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!";
c6LLA = .;
if c6 in (75, 100) then c6LLA = 1;
else if c6 in (0, 25, 50) then c6LLA = 0;

/* Changes to landscaping may reduce my privacy */
c7 = choice_7;
c7 = recode(c7, 0=0 1=25 2=50 3=75 4=100);
label c7 "Index of Utility Hits on Privacy";
label define c7 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!";
c7LRP = .;
if c7 in (75, 100) then c7LRP = 1;
else if c7 in (0, 25, 50) then c7LRP = 0;
label private "Index of Privacy as a Barrier to Defensible Space";
label values private private;

/* Changes to CONVERN WILDLIFE */
c8 = choice_8;
c8 = recode(c8, 0=0 1=25 2=50 3=75 4=100);
label c8 "Index of Utility Hits on Wildlife Conservation";
label define c8 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!";
c8WLH = .;
if c8 in (75, 100) then c8WLH = 1;
else if c8 in (0, 25, 50) then c8WLH = 0;

/* Rename variables */
house_attr = c5;
land_attr = c6;
drop c5 c6 c7 c8;
run;



/* Fire-resistant roof (tile, cement, asphalt) */

tabulate hh_1_1, gen(dum)

gen hhfirerroof = .
if dum3 = 1 or dum4 = 1 then hhfirerroof = 1;
if dum1 = 1 or dum2 = 1 then hhfirerroof = 0;

tabulate hh_2_1, gen(dum)

gen hhfirenoplan = .
if dum2 = 1 then hhfirenoplan = 1;
if dum1 = 1 then hhfirenoplan = 0;

tabulate hh_3_1, gen(dum)

gen hhfireyesbought = .
if dum2 = 1 then hhfireyesbought = 1;
if dum1 = 1 then hhfireyesbought = 0;

tabulate hh_4_1, gen(dum)

gen hhfireyesadd = .
if dum2 = 1 then hhfireyesadd = 1;
if dum1 = 1 then hhfireyesadd = 0;

/* Fire-resistant siding (stucco, cement fibreboard, brick) */
tabulate hh_1_2, gen(dum)

gen hhfirersiding = .
if dum3 = 1 or dum4 = 1 then hhfirersiding = 1;
if dum1 = 1 or dum2 = 1 then hhfirersiding = 0;

tabulate hh_2_2, gen(dum)

gen hhsidingnoplan = .
if dum2 = 1 then hhsidingnoplan = 1;
if dum1 = 1 then hhsidingnoplan = 0;

tabulate hh_3_2, gen(dum)

gen hhsidingyesbought = .
if dum2 = 1 then hhsidingyesbought = 1;
if dum1 = 1 then hhsidingyesbought = 0;

tabulate hh_4_2, gen(dum)

gen hhsidingyesadd = .
if dum2 = 1 then hhsidingyesadd = 1;
if dum1 = 1 then hhsidingyesadd = 0;


/* Fire-resistant roof (tile, cement, asphalt) */
proc freq data=have;
tables hh_1_1 / out=dum;
run;

data want;
set have;
hhfirerroof = .;
if dum3=1 or dum4=1 then hhfirerroof=1;
else if dum1=1 or dum2=1 then hhfirerroof=0;

proc freq data=have;
tables hh_2_1 / out=dum;
run;

hhfirenoplan = .;
if dum2=1 then hhfirenoplan=1;
else if dum1=1 then hhfirenoplan=0;

proc freq data=have;
tables hh_3_1 / out=dum;
run;

hhfireyesbought = .;
if dum2=1 then hhfireyesbought=1;
else if dum1=1 then hhfireyesbought=0;

proc freq data=have;
tables hh_4_1 / out=dum;
run;

hhfireyesadd = .;
if dum2=1 then hhfireyesadd=1;
else if dum1=1 then hhfireyesadd=0;

/* Fire-resistant siding (stucco, cement fibreboard, brick) */
proc freq data=have;
tables hh_1_2 / out=dum;
run;

hhfirersiding = .;
if dum3=1 or dum4=1 then hhfirersiding=1;
else if dum1=1 or dum2=1 then hhfirersiding=0;

proc freq data=have;
tables hh_2_2 / out=dum;
run;

hhsidingnoplan = .;
if dum2=1 then hhsidingnoplan=1;
else if dum1=1 then hhsidingnoplan=0;

proc freq data=have;
tables hh_3_2 / out=dum;
run;

hhsidingyesbought = .;
if dum2=1 then hhsidingyesbought=1;
else if dum1=1 then hhsidingyesbought=0;

proc freq data=have;
tables hh_4_2 / out=dum;
run;

hhsidingyesadd = .;
if dum2=1 then hhsidingyesadd=1;
else if dum1=1 then hhsidingyesadd=0;

drop dum1-dum4;
run;
