package com.mtpms.dto;

import java.io.Serializable;
import java.text.DecimalFormat;

public class holiManageDto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 702544984882568553L;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
		
	
	private int holiNo;
	private String pernNo;
	private String name; // 이름은 직원정보 테이블에서 가져와야되는데 일단 만들어놓음
	private String holiDateFrom;
	private String holiDateTo;
	private double holiDays;
	private String holiType;
	private String holiTypeName;
	

	

	private String holiEtc;
		
	private String years;
	private String code;	
	
	public int getHoliNo() {
		return holiNo;
	}
	public void setHoliNo(int holiNo) {
		this.holiNo = holiNo;
	}
	
	public String getPernNo() {
		return pernNo;
	}
	public void setPernNo(String pernNo) {
		this.pernNo = pernNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHoliDateFrom() {
		return holiDateFrom;
	}
	public void setHoliDateFrom(String holiDateFrom) {
		this.holiDateFrom = holiDateFrom;
	}
	public String getHoliDateTo() {
		return holiDateTo;
	}
	public void setHoliDateTo(String holiDateTo) {
		this.holiDateTo = holiDateTo;
	}
	public double getHoliDays() {
		return holiDays;
	}
	public void setHoliDays(double holiDays) {
		this.holiDays = holiDays;
	}
	public String getHoliType() {
		return holiType;
	}
	public void setHoliType(String holiType) {
		this.holiType = holiType;
	}
	public String getHoliTypeName() {
		return holiTypeName;
	}
	public void setHoliTypeName(String holiTypeName) {
		this.holiTypeName = holiTypeName;
	}


	public String getHoliEtc() {
		return holiEtc;
	}
	public void setHoliEtc(String holiEtc) {
		this.holiEtc = holiEtc;
	}
	
	public String getYears() {
		return years;
	}
	public void setYears(String years) {
		this.years = years;
	}	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	

	//////////////////

	private String totalHoli;
	private String usedHoli;
	private String m1;
	private String m2;
	private String m3;
	private String m4;
	private String m5;
	private String m6;
	private String m7;
	private String m8;
	private String m9;
	private String m10;
	private String m11;
	private String m12;
	private boolean except;

	
	public String getTotalHoli() {
		return totalHoli;
	}

	public void setTotalHoli(String totalHoli) {
		this.totalHoli = totalHoli;
	}

	public String getUsedHoli() {
		return usedHoli;
	}

	public void setUsedHoli(String usedHoli) {
		this.usedHoli = usedHoli;
	}

	public String getM1() {
		return m1;
	}

	public void setM1(String m1) {
		this.m1 = m1;
	}

	public String getM2() {
		return m2;
	}

	public void setM2(String m2) {
		this.m2 = m2;
	}

	public String getM3() {
		return m3;
	}

	public void setM3(String m3) {
		this.m3 = m3;
	}

	public String getM4() {
		return m4;
	}

	public void setM4(String m4) {
		this.m4 = m4;
	}

	public String getM5() {
		return m5;
	}

	public void setM5(String m5) {
		this.m5 = m5;
	}

	public String getM6() {
		return m6;
	}

	public void setM6(String m6) {
		this.m6 = m6;
	}

	public String getM7() {
		return m7;
	}

	public void setM7(String m7) {
		this.m7 = m7;
	}

	public String getM8() {
		return m8;
	}

	public void setM8(String m8) {
		this.m8 = m8;
	}

	public String getM9() {
		return m9;
	}

	public void setM9(String m9) {
		this.m9 = m9;
	}

	public String getM10() {
		return m10;
	}

	public void setM10(String m10) {
		this.m10 = m10;
	}

	public String getM11() {
		return m11;
	}

	public void setM11(String m11) {
		this.m11 = m11;
	}

	public String getM12() {
		return m12;
	}

	public void setM12(String m12) {
		this.m12 = m12;
	}

	public boolean  getExcept() {
		return except;
	}
	public void setExcept(boolean except) {
		this.except = except;
	}
	//////////////////	
	
	private String months;

	public String getMonths() {
		return months;
	}
	public void setMonths(String months) {
		this.months = months;
	}
	
	private String title;

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
