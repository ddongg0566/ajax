package co.prod.service;

import java.util.List;

import co.prod.vo.MembersVO;

public interface MembersService {
	// 회원목록.
		public List<MembersVO> getMembers();
		
	//회원등록
		public boolean addMember(MembersVO vo);
		
		public boolean removeMembersAry(String[] users);
}
