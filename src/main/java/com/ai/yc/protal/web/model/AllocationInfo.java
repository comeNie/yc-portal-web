package com.ai.yc.protal.web.model;

import java.util.List;

public class AllocationInfo {
	private List<InterperInfo> interperInfoList;
	private List<StepInfo> stepInfoList;

	public List<InterperInfo> getInterperInfoList() {
		return interperInfoList;
	}

	public void setInterperInfoList(List<InterperInfo> interperInfoList) {
		this.interperInfoList = interperInfoList;
	}

	public List<StepInfo> getStepInfoList() {
		return stepInfoList;
	}

	public void setStepInfoList(List<StepInfo> stepInfoList) {
		this.stepInfoList = stepInfoList;
	}

}
