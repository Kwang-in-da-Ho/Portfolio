package com.koreait.cset.dto;

public class CartJoinVO {

	private int cNo, pNo, cAmount; // 카트 번호, 상품 번호, 장바구니에 담은 상품 수량
	private String mId, cSize; // 회원 아이디, 장바구니에 담은 상품 사이즈

	private String mName; // 회원 이름

	private String pName, pBrand, pFilename; // 상품 이름, 상품 브랜드, 상품 이미지
	private int pPrice, pDisrate, productPrice, sAmount; // 상품 가격, 상품 할인율, 상품 가격, 해당 상품 재고

	public CartJoinVO() {
	}

	public CartJoinVO(int cNo, int pNo, int cAmount, String mId, String cSize, String mName, String pName,
			String pBrand, String pFilename, int pPrice, int pDisrate, int productPrice, int sAmount) {
		super();
		this.cNo = cNo;
		this.pNo = pNo;
		this.cAmount = cAmount;
		this.mId = mId;
		this.cSize = cSize;
		this.mName = mName;
		this.pName = pName;
		this.pBrand = pBrand;
		this.pFilename = pFilename;
		this.pPrice = pPrice;
		this.pDisrate = pDisrate;
		this.productPrice = productPrice;
		this.sAmount = sAmount;
	}

	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public int getcAmount() {
		return cAmount;
	}

	public void setcAmount(int cAmount) {
		this.cAmount = cAmount;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getcSize() {
		return cSize;
	}

	public void setcSize(String cSize) {
		this.cSize = cSize;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getpBrand() {
		return pBrand;
	}

	public void setpBrand(String pBrand) {
		this.pBrand = pBrand;
	}

	public String getpFilename() {
		return pFilename;
	}

	public void setpFilename(String pFilename) {
		this.pFilename = pFilename;
	}

	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}

	public int getpDisrate() {
		return pDisrate;
	}

	public void setpDisrate(int pDisrate) {
		this.pDisrate = pDisrate;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getsAmount() {
		return sAmount;
	}

	public void setsAmount(int sAmount) {
		this.sAmount = sAmount;
	}
	
}

	