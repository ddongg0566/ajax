package co.prod.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.MembersService;
import co.prod.service.MembersServiceMybatis;
import co.prod.vo.MembersVO;

public class MemberAddJquery implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
				MembersVO vo = new MembersVO();
				// id, name, pw, mail, auth
				vo.setMemberId(request.getParameter("id"));
				vo.setMemberName(request.getParameter("name"));
				vo.setMemberTel(request.getParameter("tel"));
				vo.setMemberAddr(request.getParameter("addr"));
				vo.setMemberPw(request.getParameter("passwd"));
				System.out.println(vo);
				MembersService service = new MembersServiceMybatis();
				boolean result = service.addMember(vo); // 입력처리.
				Map<String, Object> map = new HashMap<>();

				Gson gson = new GsonBuilder().create();
				String json = "";
				if (result) {
					map.put("retCode", "Success");
					map.put("member", vo);
				} else {
					map.put("retCode", "Fail");
					map.put("member", null);
				}
				json = gson.toJson(map);

				return json + ".ajax";
			}

}
