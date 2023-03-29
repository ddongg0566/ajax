package co.prod.service;

import java.util.List;
import java.util.Map;

import co.prod.vo.ProductVO;
import co.prod.vo.ReplyVO;

public interface ProductService {
	public List<ProductVO> products();
	public ProductVO getProduct(String code);
	
	// 상품에 대한 댓글목록.
	public List<ReplyVO> replyList(String code);
	// 댓글삭제.
	public boolean removeReply(int replyId);
	// 댓글등록.
	public boolean addReply(ReplyVO vo);
	//한건 댓글 조회
	
	public ReplyVO getReply(int rid);
	
	//댓글 저장
	public boolean saveReply(ReplyVO vo);
	
	//차트
	public List<Map<String,Object>> chartInfo();
	
}
