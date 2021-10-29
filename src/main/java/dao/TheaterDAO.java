package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.DateVO;
import vo.TheaterVO;

public class TheaterDAO {
	
	SqlSession sqlSession;
	
	public TheaterDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//지역 검색
	public List<TheaterVO> selectCity(String m_name){
		
		List<TheaterVO> list = sqlSession.selectList("t.selectcity" ,m_name );
		return list;
		
	}
	
	//구 검색
	public List<TheaterVO> selectDistrict(String m_name , String city){
		HashMap<String , Object> map = new HashMap<String, Object>();
		map.put("m_name",m_name);
		map.put("city",city);
		System.out.println(city);
		List<TheaterVO> list = sqlSession.selectList("t.selectdistrict" ,map );
		System.out.println(list.get(0).getDistrict());
		return list;
		
	}
	
	//날짜 검색
	public List<DateVO> selectDate(String m_name , String city , String district){
		
		HashMap<String , Object> map = new HashMap<String, Object>();
		map.put("m_name",m_name);
		map.put("city",city);
		map.put("district",district);
		List<DateVO> list = sqlSession.selectList("t.selectdate" ,map );
		return list;
		
	}
	
	//시간 검색
	public List<TheaterVO> selectTime(String m_name , String city , String district ,String date_s){
		
		HashMap<String , String> map = new HashMap();
		map.put("m_name",m_name);
		map.put("city",city);
		map.put("district",district);
		map.put("date_s",date_s);
		System.out.println(date_s);
		//System.out.println("m_name : " + m_name);
		//System.out.println("city : " + city);
		//System.out.println("district : " +district);
		
		List<TheaterVO> list = sqlSession.selectList("t.selectTime",map);
		System.out.println(list.get(0).getTime());
		return list;
	}
	
	//좌석수 줄이기 
	public int seatchange(int count , String m_name , String city , String district ,String date_s ,String time) {
		HashMap<String , Object> map = new HashMap();
		map.put("count",count);
		map.put("m_name",m_name);
		map.put("city",city);
		map.put("district",district);
		map.put("date_s",date_s);
		map.put("time",time);
		int res = sqlSession.update("t.seatchange" , map);
		return res;
	}
	
}
