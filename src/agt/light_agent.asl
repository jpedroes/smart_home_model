// Agent observer in project smartHomeModel

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */
night(T):- T>17 | T<6.

!use.
/* Initial goals */
+!use<-
	?setup(Light, PresenceSensor, ClockDate);
	//.wait(1000)
	.

+?setup( Tv, PresenceSensor, ClockDate):true<-
	makeArtifact("c3","smartHomeModel.Light",[], Light);
	makeArtifact("c4","smartHomeModel.PresenceSensor",[], PresenceSensor);
	focus(PresenceSensor);
	start[artifact_id(PresenceSensor)]
	.

-?setup( Tv, PresenceSensor, ClockDate):true<-	
	lookupArtifact("c2", ClockDate);
	lookupArtifact("c3", Light);
	lookupArtifact("c4", PresenceSensor);
	focus(PresenceSensor).
	
+detected(D) <- 
timeNow(T)[artifact_id(ClockDate)];
!openLight(T).

+isVoid(D) <- 
timeNow(T)[artifact_id(ClockDate)];
!closeLight(T).		

+!closeLight(T) <-
close(S)[artifact_id(Light)];
.print(T);
.print(S).

-!closeLight(T) <-
.print(T);
.print("detected, but its night")
.

+!openLight(T): night(T)<-
open(S)[artifact_id(Light)];
.print(T);
.print(S);.

-!openLight(T): not night<-
.print(T);
.print("detected, but its night")
.
 