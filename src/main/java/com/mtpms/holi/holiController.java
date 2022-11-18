package com.mtpms.holi;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.eclipse.jdt.internal.compiler.batch.Main;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mtpms.dto.holiManageDto;
import com.mtpms.dto.db.pmsholiDto;
import com.mtpms.holi.service.holiService;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


@Controller
public class holiController {	
	
	@Resource(name = "holiService")
	private holiService holiService;
	
	protected static Logger logger = Logger.getLogger(Main.class.getName());
	
	//###################################################################### 휴가 사용 내역 페이지
	@RequestMapping(value="/holi/holiUsageList.do", method={RequestMethod.GET, RequestMethod.POST})
    public String bbsMangeList(ModelMap model) throws Exception {
		
		List<holiManageDto> list = holiService.selectYearList();
    	model.addAttribute("yearList", list);
    	
    	List<holiManageDto> holiTypeList = holiService.selectHoliTypeList();
    	model.addAttribute("holiTypeList", holiTypeList);
    	
		model.addAttribute("pageUrl", "/holi/holiUsageList.jsp");
	   	return "main";
    	
    }
	// jqgrid에 띄울 휴가 사용 내역 리스트 
    @RequestMapping(value="/holi/holiUsageList.ajax", method={RequestMethod.POST})
    public ModelAndView holiUsageList(@ModelAttribute("holiManageDto") holiManageDto holiManageDto, HttpSession session, Model model) throws Exception {

		Map<String, Object> map = holiService.selectHoliUsageList(holiManageDto);
		ModelAndView modelAndView = new ModelAndView("jsonView",map);

		return modelAndView;
    }
	// option에 넣어줄 이름 리스트
    @RequestMapping(value="/holi/selectNameList.ajax", method={RequestMethod.POST,RequestMethod.GET})
    public @ResponseBody List<holiManageDto> selectNameList(@ModelAttribute("holiManageDto") holiManageDto holiManageDto, HttpSession session, Model model) throws Exception {

    	List<holiManageDto> list = holiService.selectNameList();
    	return list;
    }
	// 성명 검색용 팝업 jqgrid에 띄울 리스트    
    @RequestMapping(value="/holi/holiNameList.ajax", method={RequestMethod.POST})
    public ModelAndView holiNameList(@ModelAttribute("holiManageDto") holiManageDto holiManageDto, HttpSession session, Model model) throws Exception {

		Map<String, Object> map = holiService.selectHoliNameList(holiManageDto);
		ModelAndView modelAndView = new ModelAndView("jsonView",map);

		return modelAndView;
    }
	// 휴가 사용 내역 데이터 추가
    @RequestMapping(value="/holi/holiUsageUpdate.ajax", method={RequestMethod.POST})
    public ResponseEntity<String> holiUsageUpdate(@ModelAttribute("pmsholiDto") pmsholiDto pmsholiDto, HttpSession session, Model model) throws Exception {

		int rtn = holiService.pmsholiUsageUpdate(pmsholiDto);

		logger.info("rtn =>" + rtn);

		ResponseEntity<String> resRtn = null;
   		if (rtn == 1) {
   			resRtn = new ResponseEntity<>(HttpStatus.OK);
   		} else {
   			resRtn = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
   		}

   		return resRtn;
    }
	// 휴가 사용 내역 데이터 삭제
    @RequestMapping(value="/holi/holiUsageDelete.ajax", method={RequestMethod.POST})
    public ResponseEntity<String> holiUsageDelete(@ModelAttribute("pmsholiDto") pmsholiDto pmsholiDto, HttpSession session, Model model) throws Exception {

		int rtn = holiService.pmsholiUsageDelete(pmsholiDto);

		logger.info("rtn =>" + rtn);

		ResponseEntity<String> resRtn = null;
   		if (rtn == 1) {
   			resRtn = new ResponseEntity<>(HttpStatus.OK);
   		} else {
   			resRtn = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
   		}

   		return resRtn;
    }

    //############################################################## 월별 휴가 사용 내역 페이지
    @RequestMapping("/holi/MHoliUsageList.do")
	public String MHoliUsageList(ModelMap model) throws Exception {
		
		List<holiManageDto> yearList = holiService.selectYearList();
    	model.addAttribute("yearList", yearList);
    	
    	List<holiManageDto> monthList = holiService.selectMonthList();
    	model.addAttribute("monthList", monthList);
    	
		model.addAttribute("pageUrl", "/holi/MHoliUsageList.jsp");
	   	return "main";
	}
	// 달력
	@GetMapping("/holi/calendar.do")
	@ResponseBody
	public List<Map<String, Object>> calendar() throws Exception {
		List<holiManageDto> listAll = holiService.calendarList();

		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();

		HashMap<String, Object> hash = new HashMap<>();

		for (int i = 0; i < listAll.size(); i++) {
			hash.put("title", listAll.get(i).getTitle());
			hash.put("start", listAll.get(i).getHoliDateFrom());
			hash.put("end", listAll.get(i).getHoliDateTo());

			jsonObj = new JSONObject(hash);
			jsonArr.add(jsonObj);
		}
		// logger.info("jsonArrCheck: {}" + jsonArr);
		return jsonArr;
	}
	
	//############################################################## 연도별 운영자별 휴가 사용 내역 페이지
    @RequestMapping("/holi/AOHoliUsageList.do")
	public String AOHoliUsageList(ModelMap model) throws Exception {

    	List<holiManageDto> list = holiService.selectYearList();
    	model.addAttribute("yearList", list);
    	
    	model.addAttribute("pageUrl", "/holi/AOHoliUsageList.jsp");
	   	return "main";
	}
    // jqgrid에 띄울 연도별 운영자별 휴가 사용 내역
    @RequestMapping(value="/holi/AOHoliUsageList.ajax", method={RequestMethod.POST})
    public ModelAndView AOHoliUsageList(@ModelAttribute("holiManageDto") holiManageDto holiManageDto, HttpSession session, Model model) throws Exception {

		Map<String, Object> map = holiService.selectAOHoliUsageList(holiManageDto);
		ModelAndView modelAndView = new ModelAndView("jsonView",map);

		return modelAndView;
    }
    //############################################################## 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /////////////////////////////////////////////////// 테스트용 
	@RequestMapping("/holi/test.do")
	public String test(ModelMap model) throws Exception {

    	return "/holi/test";
	}
	
	
	
}
