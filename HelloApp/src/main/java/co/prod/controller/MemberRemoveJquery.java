package co.prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.MembersService;
import co.prod.service.MembersServiceMybatis;

public class MemberRemoveJquery implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String[] members = request.getParameterValues("memberId");
		for (String member : members) {
			System.out.println(member);
		}
		MembersService service = new MembersServiceMybatis();
		service.removeMembersAry(members);
		String json = "{\"retcode\": \"Success\"}";
		
		return json + ".ajax";
	}

}
