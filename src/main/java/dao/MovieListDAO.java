package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import vo.BoardVO;
import vo.MovieRankPosterVO;
import vo.MovieRecordVO;

public class MovieListDAO {
	
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<MovieRankPosterVO> selectList(){ 
		List<MovieRankPosterVO> list = null;
		list = sqlSession.selectList("m.movie_poster_list");
		return list;
	}
	
	public MovieRankPosterVO selectOne(String movieNm){ 
		MovieRankPosterVO vo = null;
		vo = sqlSession.selectOne("m.movie_trailer", movieNm);
		return vo;
	}
	
	public int insert( MovieRecordVO vo ) {
		int res = sqlSession.insert("m.movie_query_record", vo);
		return res;
	}
	
}
