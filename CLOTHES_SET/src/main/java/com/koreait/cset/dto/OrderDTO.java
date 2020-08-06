package com.koreait.cset.dto;

import java.sql.Date;

public class OrderDTO {
	
	private int oNo, pNo, oAmount, oPayment, oPrice;
	private String mId, oAddr, oPhone, oNote, oSize;
	private Date oDate;
	
	public OrderDTO() {	}

	public OrderDTO(int oNo, int pNo, int oAmount, int oPayment, int oPrice, String mId, String oAddr, String oPhone,
			String oNote, String oSize, Date oDate) {
		super();
		this.oNo = oNo;
		this.pNo = pNo;
		this.oAmount = oAmount;
		this.oPayment = oPayment;
		this.oPrice = oPrice;
		this.mId = mId;
		this.oAddr = oAddr;
		this.oPhone = oPhone;
		this.oNote = oNote;
		this.oSize = oSize;
		this.oDate = oDate;
	}

	public int getoNo() {
		return oNo;
	}

	public void setoNo(int oNo) {
		this.oNo = oNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public int getoAmount() {
		return oAmount;
	}

	public void setoAmount(int oAmount) {
		this.oAmount = oAmount;
	}

	public int getoPayment() {
		return oPayment;
	}

	public void setoPayment(int oPayment) {
		this.oPayment = oPayment;
	}

	public int getoPrice() {
		return oPrice;
	}

	public void setoPrice(int oPrice) {
		this.oPrice = oPrice;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getoAddr() {
		return oAddr;
	}

	public void setoAddr(String oAddr) {
		this.oAddr = oAddr;
	}

	public String getoPhone() {
		return oPhone;
	}

	public void setoPhone(String oPhone) {
		this.oPhone = oPhone;
	}

	public String getoNote() {
		return oNote;
	}

	public void setoNote(String oNote) {
		this.oNote = oNote;
	}

	public String getoSize() {
		return oSize;
	}

	public void setoSize(String oSize) {
		this.oSize = oSize;
	}

	public Date getoDate() {
		return oDate;
	}

	public void setoDate(Date oDate) {
		this.oDate = oDate;
	}
	
	
	
	
}
