package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import vo.UserVO;

@Repository("user_dao")
public class UserDAO {

	@Autowired
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public UserDAO() {
		// TODO Auto-generated constructor stub
	}

	// 회원가입
	public int register_member(UserVO vo) {

		int res = sqlSession.insert("u.register_member", vo);
		return res;

	}
	
	// 회원가입 (아이디 중복체크)
	public int id_check(String id) {
		int res = sqlSession.selectOne("u.id_check", id);
		return res;
	}
	
	// 회원가입 (이메일 중복체크)
	public int check_email(String email) {
		int res = sqlSession.selectOne("u.check_email", email);
		return res;
	}
	
	// 로그인 시도할 id 조회
	public UserVO selectOne(String id, String pwd) {
		UserVO vo = null;
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pwd", pwd);
		
		vo = sqlSession.selectOne("u.user_one", map);
		return vo;
	}
	
	// 찾을 id 조회
	public UserVO find_id(String name, String email) {
		UserVO vo = null;
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("email", email);
		
		vo = sqlSession.selectOne("u.find_id", map);
		return vo;
	}
	
	// pwd찾을 id 조회
	public UserVO check_id(String id, String email) {
		UserVO vo = null;
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("email", email);
		
		vo = sqlSession.selectOne("u.check_id", map);
		return vo;
	}
	
	// 로그인한 회원 정보 가져오기
	public UserVO selectOne(int l_idx) {
		
		UserVO vo = sqlSession.selectOne("u.select_one", l_idx);
		return vo;
		
	}
	
	// 회원정보 수정
	public int change_user_info(UserVO vo) {
		int res = sqlSession.update("u.change_user_info", vo);
		return res;
	}
	
	// 회원정보 수정한 정보 다시 가져오기
	public UserVO call_changed_info(int l_idx) {
		UserVO vo = sqlSession.selectOne("u.call_changed_info", l_idx);
		System.out.println("DAO");
		System.out.println(vo.getId());
		System.out.println(vo.getName());
		System.out.println(vo.getPostcode());
		System.out.println(vo.getAddr());
		System.out.println(vo.getD_addr());
		return vo;
	}
	
	// 비밀번호 찾기 (비밀버호 재설정)
	public int change_pwd(UserVO vo) {
		
		int res = sqlSession.update("u.change_pwd", vo);
		return res;
	}
	
	// 회원 탈퇴 (회원정보 삭제)
	public int delete(int l_idx, String input_pwd) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("l_idx", l_idx);
		map.put("input_pwd", input_pwd);
		
		int res = sqlSession.delete("u.delete_info", map);
		if(res == 0) {
			res = 0;
			return res;
		}
		
		return res;
	}



}
