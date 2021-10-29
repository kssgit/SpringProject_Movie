package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.SeatVO;

public class SeatDAO {
	SqlSession sqlSession;
	public SeatDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//예약된 좌석 DB에 추가 
	public int seatinsert(SeatVO vo) {
		
		int res =sqlSession.insert("s.seatsave" , vo);
		return res;
	}
	
	//예약된 좌석 조회
	public List<SeatVO> foundseat(SeatVO vo){
		List<SeatVO> list= null;
		list=sqlSession.selectList("s.foundseat" ,vo);
		return list;
	}
	
	
}
