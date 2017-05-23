package com.ai.yc.protal.web.model;

import com.ai.yc.order.api.orderquery.param.RecordOrderResponse;

public class OrderPageResParam extends RecordOrderResponse {
	private static final long serialVersionUID = 1L;
	private long platFeePage;
	private long iterperFeePage;
	private long totalFeePage;

	public long getPlatFeePage() {
		return platFeePage;
	}

	public void setPlatFeePage(long platFeePage) {
		this.platFeePage = platFeePage;
	}

	public long getIterperFeePage() {
		return iterperFeePage;
	}

	public void setIterperFeePage(long iterperFeePage) {
		this.iterperFeePage = iterperFeePage;
	}

	public long getTotalFeePage() {
		return totalFeePage;
	}

	public void setTotalFeePage(long totalFeePage) {
		this.totalFeePage = totalFeePage;
	}

}
