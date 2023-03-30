package co.prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.CalendarService;
import co.prod.service.CalendarServiceImpl;

public class CalendarRemove implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		
		String title= request.getParameter("title");
		CalendarService service = new CalendarServiceImpl();
		boolean result = service.removeCal(title);
		String json = "";
		if (result) {
			// {"retCode": "Success"}
			json = "{\"retCode\": \"Success\"}";
		} else {
			// {"retCode": "Fail"}
			json = "{\"retCode\": \"Fail\"}";
		}
		return json + ".ajax";
	}

}
