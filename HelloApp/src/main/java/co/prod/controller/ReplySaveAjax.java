package co.prod.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;
import co.prod.vo.ReplyVO;

public class ReplySaveAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String rid = request.getParameter("replyNo");
		String rc = request.getParameter("replyContent");
		System.out.println(rid);
		
		ReplyVO vo =new ReplyVO();
		vo.setReplyNo(Integer.parseInt(rid));
		vo.setReplyContent(rc);
		
		ProductService service = new ProductServiceImpl();
		
		boolean result = service.saveReply(vo);
		ReplyVO reply =new ReplyVO();
		reply = service.getReply(Integer.parseInt(rid));
		
		Map<String,Object> resultMap = new HashMap<>();
		
		if (result) {
			resultMap.put("retCode", "Success");
			resultMap.put("reply", reply);

		} else {
			resultMap.put("retCode", "Fail");
			resultMap.put("reply", null);

		}
		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(resultMap);

		return json + ".ajax";
	}

}
