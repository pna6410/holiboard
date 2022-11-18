package com.mtpms.holi.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import com.mtpms.dto.comCodeDto;
import com.mtpms.dto.holiManageDto;
import com.mtpms.dto.db.pmsholiDto;
import com.mtpms.holi.dao.holiDao;
import com.mtpms.holi.service.holiService;

@Service("holiService")
public class holiServiceImpl extends EgovAbstractServiceImpl implements holiService {
	
	@Resource(name = "holiDao")
	private holiDao holiDao;
	
	//############################################################## 휴가 사용 내역 페이지
	public Map<String, Object> selectHoliUsageList(holiManageDto holiManageDto) throws Exception {

    	List<holiManageDto> list = holiDao.selectHoliUsageList(holiManageDto);

    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("resultList", list);

    	return map;
    }

	public List<holiManageDto> selectNameList() throws Exception {
		List<holiManageDto> list = holiDao.selectNameList();
    	return list;
	}
	
	public List<holiManageDto> selectYearList() throws Exception {
		List<holiManageDto> list = holiDao.selectYearList();
    	return list;
	}

	public Map<String, Object> selectHoliNameList(holiManageDto holiManageDto) throws Exception {
		List<holiManageDto> list = holiDao.selectHoliNameList(holiManageDto);

    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("resultList", list);

    	return map;
	}
	
	public List<holiManageDto> selectHoliTypeList() throws Exception {		
		List<holiManageDto> list = holiDao.selectHoliTypeList();
    	return list;
	}

	public int pmsholiUsageUpdate(pmsholiDto pmsholiDto) throws Exception {
		int rtn = holiDao.pmsholiUsageUpdate(pmsholiDto);

    	return rtn;
	}
	
	public int pmsholiUsageDelete(pmsholiDto pmsholiDto) throws Exception {
		int rtn = holiDao.pmsholiUsageDelete(pmsholiDto);

    	return rtn;
	}

	//############################################################## 연도별 운영자별 휴가 사용 내역 페이지
	public Map<String, Object> selectAOHoliUsageList(holiManageDto holiManageDto) throws Exception {
		List<holiManageDto> list = holiDao.selectAOHoliUsageList(holiManageDto);

    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("resultList", list);

    	return map;
	}
	
	public List<holiManageDto> selectMonthList() throws Exception {
		List<holiManageDto> list = holiDao.selectMonthList();
    	return list;
	}

	//############################################################## 월별 휴가 사용 내역 페이지
	public List<holiManageDto> calendarList() throws Exception {
		List<holiManageDto> list = holiDao.calendarList();
    	return list;
	}

}
