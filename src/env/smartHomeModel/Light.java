// CArtAgO artifact code for project addPlanArtifact

package smartHomeModel;

import cartago.*;

public class Light extends Artifact {
	private String state;
			
	@OPERATION
	void open( OpFeedbackParam<String> status){
		this.state = "isOpen";
		status.set(state);
	}
	
	@OPERATION
	void close(OpFeedbackParam<String> status) {
		this.state = "isClose";
		status.set(state);
	}
}

