// Agent cold_agent in project smartHomeModel

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */

!use.

+?setup(Learn, Split):true<-
	makeArtifact("c0","smartHomeModel.Learn",[], Learn);
	makeArtifact("c5","smartHomeModel.Split",[], Split).

-?setup(Learn, Tv):true<-	
	lookupArtifact("c0", Learn);
	lookupArtifact("c5", Tv).

+!use: true<-
	?setup(Learn, Split);
	!b(Split);
	newValueForPlan(Value, Time)[artifact_id(Learn)];
	.remove_plan(b);
    .add_plan({@b	+!b(Split):true<- start(Value, Time,Status)[artifact_id(Split)]; .print(Status); .wait(Time); off(S); .print(S)}); !use.
		
@b		
+!b(Split):true<-
		start(26, 1500,Status)[artifact_id(Split)];
		.print(Status);
		.wait(1500);
		off(S);
		.print(S).		
		

