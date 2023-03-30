package co.prod.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prod.common.DataSource;
import co.prod.mapper.CalendarMapper;
import co.prod.vo.CalendarVO;

public class CalendarServiceImpl implements CalendarService {

	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	// Mapper.xml 파일의 메소드를 호출.
	private CalendarMapper mapper = sqlSession.getMapper(CalendarMapper.class);


	@Override
	public List<CalendarVO> selectCalendar() {
		// TODO Auto-generated method stub
		return mapper.selectCalendar();
	}


	@Override
	public boolean addCal(CalendarVO vo) {
		// TODO Auto-generated method stub
		return mapper.insertCal(vo)==1;
	}


	@Override
	public boolean removeCal(String title) {
		// TODO Auto-generated method stub
		return mapper.deleteCal(title)==1;
	}

}
