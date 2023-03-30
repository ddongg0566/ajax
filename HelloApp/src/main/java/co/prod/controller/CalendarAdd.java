package co.prod.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.CalendarService;
import co.prod.service.CalendarServiceImpl;
import co.prod.vo.CalendarVO;

public class CalendarAdd implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String title = request.getParameter("title");
		String startdate = request.getParameter("start");
		String enddate = request.getParameter("end");
		
		
		CalendarVO vo = new CalendarVO();
		vo.setTitle(title);
		vo.setStartDate(startdate);
		vo.setEndDate(enddate);
		
		CalendarService service = new CalendarServiceImpl();
		
		boolean result = service.addCal(vo);
		
		Map<String,Object> resultMap = new HashMap<>();
		
		if(result) {
			resultMap.put("retCode","Success");
			resultMap.put("reply",vo);
			
		}else {
			resultMap.put("retCode","Fail");
			resultMap.put("reply",null);
		}
		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(resultMap);

		return json + ".ajax";
	}
	}


