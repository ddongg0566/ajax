package co.prod.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.CalendarService;
import co.prod.service.CalendarServiceImpl;
import co.prod.vo.CalendarVO;

public class CalendarForm implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
	
		CalendarService service = new CalendarServiceImpl();

		List<CalendarVO> list = service.selectCalendar();
		// json포맷으로 생성.
		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(list);

		return json + ".ajax";
	}

}
