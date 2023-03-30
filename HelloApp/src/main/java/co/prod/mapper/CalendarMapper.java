package co.prod.mapper;

import java.util.List;

import co.prod.vo.CalendarVO;

public interface CalendarMapper {
	public List<CalendarVO> selectCalendar();
	
	public int insertCal(CalendarVO vo);
	
	public int deleteCal(String title);
}
