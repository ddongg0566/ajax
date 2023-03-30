package co.prod.service;

import java.util.List;

import co.prod.vo.CalendarVO;

public interface CalendarService {
	public List<CalendarVO> selectCalendar();
	
	public boolean addCal(CalendarVO vo);
	
	public boolean removeCal(String title);
	
}
