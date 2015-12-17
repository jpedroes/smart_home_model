// Agent sample_agent in project smartHomeModel

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

timeSeriesFri(T):-
T = 22 
.

timeSportWed(T):-
T = 22 
.

 timeSportSun(T):-
 T =16
 .
 
 timeSerieSun(T):-
 T =22
 .
 
 
timeNews(T):-
T = 20
.

isSun(D) :- 
D = "sun"
.

isWed(D) :- 
D = "wed"
.

isDFi(D) :- 
D = "fri"
.

isWeekend(D) :- 
D = "sat" | D = "sun"
.

!use.

+?setup(Tv, ClockDate):true<-
	makeArtifact("c1","smartHomeModel.Tv",[], Tv);
	makeArtifact("c2","smartHomeModel.ClockDate",[], ClockDate);
	focus(ClockDate);
	start[artifact_id(ClockDate)]
	.

-?setup(Tv, ClockDate):true<-	
	lookupArtifact("c1", Tv);
	lookupArtifact("c2", ClockDate);
	focus(ClockDate).

+!use: true
	<-	?setup(Tv, ClockDate).
	

@sportSun
+!sportSun(Tv):true
	<-open(26, 50, 5000,Status)[artifact_id(Tv)];
		.print(Status);
		.wait(5000);
		close(M);
		.print(M)
		.
		
@news
+!news(Tv):true					
	<-open(10, 50, 2500,Status)[artifact_id(Tv)];
		.print(Status);
		.wait(2500);
		close(M);
		.print(M)
		.


@serieSun
+!serieSun(Tv):true					
	<-open(54, 50, 2500,Status)[artifact_id(Tv)];
		.print(Status);
		.wait(2500);
		close(M);
		.print(M).

@serieFri
+!serieFri(Tv):true
	<-open(54, 50, 2500,Status)[artifact_id(Tv)];
		.print(Status);
		.wait(2500);
		close(M);
		.print(M).


		
+today(D):isSun(D)<- 
timeNow(T)[artifact_id(ClockDate)];
.print("´today is Sunday, Sports: ", D );
!plansForSun(T)
.

+!plansForSun(T): timeSportSun(T)<-
	!sportSun(Tv)
.

-!plansForSun(T):  not timeSportSun(T) <-
	.wait(2500);
	timeNow(NewTime)[artifact_id(ClockDate)];
	!plansForSun(NewTime)
.

+!plansForSun(T): timeSerieSun(T)<-
	!serieSun(Tv)
.

-!plansForSun(T):  not timeSerieSun(T) <-
	.wait(2500);
	timeNow(NewTime)[artifact_id(ClockDate)];
	!plansForSun(NewTime)
.

+today(D):isWed(D)
<- timeNow(T)[artifact_id(ClockDate)];
.print("´today is Wednesday, Sports: ", D);
!plansForWed(T)
.

+!plansForWed(T): timeSportWed(T)<-
	!sportWed(Tv)
.

-!plansForWed(T): not timeSportWed(T)<-
	.wait(2500);
	timeNow(NewTime)[artifact_id(ClockDate)];
	!plansForWed(NewTime);
	.
	
+today(D):not isWeekend(D) | isWed(D) | isFri(D)
<-  timeNow(T)[artifact_id(ClockDate)];
	.print("´today we have news", D);
	!plansForNotWeekend(T);
.

+!plansForNotWeekend(T): timeNews(T)<-
	!news(Tv)
.

-!plansForNotWeekend(T): not timeNews(T)<-
	.wait(2500);
	timeNow(NewTime)[artifact_id(ClockDate)];
	!plansForNotWeekend(NewTime);
	.


+today(D): isFri(D)
<-timeNow(T)[artifact_id(ClockDate)];
	.print("Friday, today we have Series", D);
	!plansForFri(T);
.

+!plansForFri(T): timeSeriesFri(T)<-
	!serieFri(Tv)
.

-!plansForFri(T): not timeSeriesFri(T)<-
	.wait(2500);
	timeNow(NewTime)[artifact_id(ClockDate)];
	!plansForFri(NewTime);
	.

+hour(T)<- .print("Hour:",T).
 