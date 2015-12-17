// CArtAgO artifact code for project addPlanArtifact

package smartHomeModel;

import cartago.Artifact;
import cartago.INTERNAL_OPERATION;
import cartago.OPERATION;
import cartago.OpFeedbackParam;

public class ClockDate extends Artifact {
	private  String day[]={"sun", "mon", "tue", "wed", "thu", "fri", "sat" };
	private int hourNow = 0;		
	
	
	@OPERATION
	void timeNow(OpFeedbackParam<Integer> status){
		status.set(hourNow);
	}
	
	@OPERATION
	void start(){
		execInternalOp("run");
	}
	
	@INTERNAL_OPERATION void run() {
		while(true){
			for(int d = 0; d<7; d++){
				signal("today", day[d]);
				for(int h = 0; h<23; h++){
					hourNow = h;
					signal("hour", h);
					await_time(2500);
				}
			}
		}
	}
	
}

