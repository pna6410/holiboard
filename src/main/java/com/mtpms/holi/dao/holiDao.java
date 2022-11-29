package com.mtpms.holi.dao;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import com.mtpms.dto.holiManageDto;
import com.mtpms.dto.db.pmsholiDto;


@Repository("holiDao")
public class holiDao extends EgovAbstractMapper {
	
	//############################################################## 휴가 사용 내역 페이지
	public List<holiManageDto> selectHoliUsageList(holiManageDto holiManageDto) throws Exception {
    	return selectList("holiDaoSql.selectHoliUsageList",holiManageDto);
    }

	public List<holiManageDto> selectNameList() throws Exception {
    	return selectList("holiDaoSql.selectNameList");
    }
	
	public List<holiManageDto> selectYearList() throws Exception {
    	return selectList("holiDaoSql.selectYearList");
    }

	public List<holiManageDto> selectHoliNameList(holiManageDto holiManageDto) throws Exception {
		return selectList("holiDaoSql.selectHoliNameList",holiManageDto);
	}

	public List<holiManageDto> selectHoliTypeList() throws Exception {
		return selectList("holiDaoSql.selectHoliTypeList");
	}

	public int pmsholiUsageUpdate(pmsholiDto pmsholiDto) throws Exception {
		return update("holiDaoSql.pmsholiUsageUpdate",pmsholiDto);
	}

	public int pmsholiUsageDelete(pmsholiDto pmsholiDto) throws Exception {
		return delete("holiDaoSql.pmsholiUsageDelete",pmsholiDto);
	}
	
	//############################################################## 연도별 운영자별 휴가 사용 내역 페이지

	public List<holiManageDto> selectAOHoliUsageList(holiManageDto holiManageDto) throws Exception {
		return selectList("holiDaoSql.selectAOHoliUsageList",holiManageDto);
	}

	public List<holiManageDto> selectMonthList() throws Exception {
		return selectList("holiDaoSql.selectMonthList");
	}

	public List<holiManageDto> calendarList() throws Exception {
		return selectList("holiDaoSql.calendarList");
	}

	public boolean checkPosDay(holiManageDto holiManageDto) throws Exception {
		return selectOne("holiDaoSql.checkPosDay",holiManageDto);
	}
}
