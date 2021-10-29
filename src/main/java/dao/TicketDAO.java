package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.TicketVO;

public class TicketDAO {
	
	SqlSession sqlSession;
	
	public TicketDAO(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	
	//회원 ticket db에 예약 정보 저장
	public int saveticket(TicketVO vo) {
		System.out.println(vo.getM_name());
		System.out.println(vo.getDate_s());
		int res = sqlSession.insert("ticket.saveticket" , vo);
		return res ;
	}
	
	
	//회원 id로 예약 정보 조회
	public List<TicketVO> selectTicket(String id){
		List<TicketVO> list = null;
		list =sqlSession.selectList("ticket.selectticket" , id);
		return list;
	}
	
}
