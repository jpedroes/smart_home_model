// CArtAgO artifact code for project addPlanArtifact

package smartHomeModel;

import java.util.Random;

import cartago.*;

public class Learn extends Artifact {
		
	@OPERATION
	void newValueForPlan( OpFeedbackParam<Integer> value,  OpFeedbackParam<Integer> time){
		value.set(18 + new Random().nextInt(45));
		time.set(1500 + new Random().nextInt(1500));
	}

}

