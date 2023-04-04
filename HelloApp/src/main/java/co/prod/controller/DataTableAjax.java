package co.prod.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.MemberService;
import co.prod.service.MemberServiceMybatis;
import co.prod.vo.EmpVO;

public class DataTableAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {

		
		/*
		 * { "data": [ [ "Tiger Nixon", "System Architect", "Edinburgh", "5421",
		 * "2011/04/25", "$320,800" ], [ "Garrett Winters", "Accountant", "Tokyo",
		 * "8422", "2011/07/25", "$170,750" ]] }
		 */
		
		MemberService service = new MemberServiceMybatis();
		List<EmpVO> list =service.employeeList();
		String json = "{\"data\":[";
		for (EmpVO vo : list) {
			
			json += "[\""+vo.getEmployeeId() + "\", \"" + vo.getFirstName()+ "\", \"" + vo.getLastName() + "\", \"" + vo.getEmail() +"\", \"" + vo.getHireDate().substring(0,10) +"\", \"" + vo.getSalary() +"\"],";
					
			
		}
		json = json.substring(0,json.length() -1); //마지막 쉼표 빼는것
		json +="]}";
		
		
		
	
		
		
		
		return json + ".ajax";
	}

}
