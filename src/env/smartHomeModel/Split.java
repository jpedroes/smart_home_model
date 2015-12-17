// CArtAgO artifact code for project addPlanArtifact

package smartHomeModel;

import cartago.*;

public class Split extends Artifact {
	private boolean state;
	private int value;
	private int time;
	
	
	@OPERATION
	void start( int value, int time, OpFeedbackParam<String> status) {
		this.state = true;
		this.value = value;
		this.time = time;
		status.set("Temperatura: "+ this.value + " Tempo de execução "+this.time);
	}
	
	@OPERATION
	void off(OpFeedbackParam<String> status) {
		this.state = false;
		status.set("Split is off");
	}
}

