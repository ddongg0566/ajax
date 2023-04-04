package co.prod.mapper;

import java.util.List;

import co.prod.vo.MembersVO;

public interface MembersMapper {
	// 매퍼(MemberMapper.xml) 에서 실행할 메소드 정의
	public List<MembersVO> getMembers();
	// 회원등록.
	public int insertMember(MembersVO vo);
	
	public int deleteMembersAry(String[] users);
}
