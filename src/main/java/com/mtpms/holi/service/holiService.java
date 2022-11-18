package com.mtpms.holi.service;

import java.util.List;
import java.util.Map;

import com.mtpms.dto.holiManageDto;
import com.mtpms.dto.menuManageDto;
import com.mtpms.dto.db.pmsholiDto;

public interface holiService {

	public Map<String, Object> selectHoliUsageList(holiManageDto holiManageDto) throws Exception;
	
	public List<holiManageDto> selectNameList() throws Exception;
	
	public List<holiManageDto> selectYearList() throws Exception;

	public Map<String, Object> selectHoliNameList(holiManageDto holiManageDto) throws Exception;

	public List<holiManageDto> selectHoliTypeList() throws Exception;

	public int pmsholiUsageUpdate(pmsholiDto pmsholiDto) throws Exception;

	public int pmsholiUsageDelete(pmsholiDto pmsholiDto) throws Exception;

	public Map<String, Object> selectAOHoliUsageList(holiManageDto holiManageDto) throws Exception;

	public List<holiManageDto> selectMonthList() throws Exception;

	public List<holiManageDto> calendarList() throws Exception;
}
