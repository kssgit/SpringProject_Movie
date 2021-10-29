package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.BoardVO;

public class BoardDAO {
	
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//영화 게시글 조회
	public List<BoardVO> selectList(String m_name){
		
		List<BoardVO> list = null;
		list = sqlSession.selectList("b.board_list", m_name);
		return list;	
	}
	
	//평점 조회
	public int selectSum( String m_name ) {
	
		int sum = sqlSession.selectOne("b.sum", m_name);
		return sum;
	}
	
	public int selectNum( String m_name ) {
		
		int num = sqlSession.selectOne("b.num", m_name);
		return num;
	}
	
	//리뷰썼는지 확인
	public String selectReview(String id, String m_name) {//String id
		/*
		 * BoardVO vo = sqlSession.selectOne("b.user_content", id);
		 * return vo;
		 */
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("id", id);
		map.put("m_name", m_name);
		String content = sqlSession.selectOne("b.user_contnet", map);
		return content;
	}
	
	
	
	//게시글 추가
	public int insert( BoardVO vo ) {
		
	//HashMap<Object, Object> map = new HashMap<Object, Object>();
	//map.put("vo", vo);
	//map.put("scope", scope);
	
		
	int res = sqlSession.insert("b.board_insert", vo);
	
	return res;
			
	}
	
	//게시글 수정하기 위해 정보 하나 얻어오기
	public BoardVO selectModify(String id, String m_name) {
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("id", id);
		map.put("m_name", m_name);
		BoardVO res = sqlSession.selectOne("b.board_modify", map);
		return res;
	}
	
	public int update(BoardVO vo) {
		int res = sqlSession.update("b.board_update", vo);
		return res;
	}
	
	//삭제
	public int delete(String id, String m_name) {
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("id", id);
		map.put("m_name", m_name);
		int res = sqlSession.delete("b.board_delete", map);
		return res;
	}
	
	//페이징을 포함한 검색
	public List<BoardVO> selectList(Map<String, Object> map){	
		List<BoardVO> list = null;
		list = sqlSession.selectList("b.board_list_condition", map);
		return list;
	}
		
	//페이징을 포함한 검색
	public List<BoardVO> selectListTotal(Map<String, Object> map){	
		List<BoardVO> list = null;
		list = sqlSession.selectList("b.board_list_total_condition", map);
		return list;
	}
	
	//게시판의 해당영화 게시물 수
	public int getRowTotal(String m_name) {
	
		int count = sqlSession.selectOne("board_count", m_name);
		return count;
	}
	
	//게시물 수
	public int getRowTotal2() {
		
		int count = sqlSession.selectOne("board_total_count");
		return count;
	}
	
	//마이페이지 리뷰블러오기
	public List<BoardVO> myReview(String id){
		 List<BoardVO> list = null;
		 list=sqlSession.selectList("b.board_myreviews", id);
		 return list;
		
	}
	
	
}
















