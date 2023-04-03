package co.prod.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prod.common.DataSource;
import co.prod.mapper.MembersMapper;
import co.prod.vo.MembersVO;

public class MembersServiceMybatis implements MembersService {
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	// Mapper.xml 파일의 메소드를 호출.
	private MembersMapper mapper = sqlSession.getMapper(MembersMapper.class);
	@Override
	public List<MembersVO> getMembers() {
		// TODO Auto-generated method stub
		return mapper.getMembers();
	}
	@Override
	public boolean addMember(MembersVO vo) {
		// TODO Auto-generated method stub
		return mapper.insertMember(vo) == 1;
	}
	

}
