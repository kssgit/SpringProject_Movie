package com.korea.movie;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.MovieListDAO;
import vo.MovieRankPosterVO;
import vo.MovieRecordVO;

@Controller
public class MovieListController {

	MovieListDAO movieListDAO;

	public void setMovieListDAO(MovieListDAO movieListDAO) {
		this.movieListDAO = movieListDAO;
	}

	@Autowired
	HttpServletRequest request;

	@RequestMapping ("/movieReleaseList.do" )
	public String movieReleaseList() {
		return Common.Movie.VIEW_PATH + "movie_list.jsp";
	}

	/*
	 * @RequestMapping("/movieInfoDetail.do") public String goMovieInfoDetail( Model
	 * model, String movieId, String movieSeq ) { int type = 1;
	 * 
	 * model.addAttribute("type", type); model.addAttribute("movieId", movieId);
	 * model.addAttribute("movieSeq", movieSeq);
	 * 
	 * return "redirect:review.do"; }
	 */

	/*
	 * @RequestMapping("/movieInfoDetailRank.do") public String
	 * goMovieInfoDetail2(Model model, String releaseDts, String
	 * title, String trailer) { int type = 2;
	 * 
	 * model.addAttribute("type", type); model.addAttribute("releaseDts",
	 * releaseDts); model.addAttribute("title", title);
	 * model.addAttribute("trailer", trailer); return Common.Movie.VIEW_PATH +
	 * "movie_detail.jsp"; }
	 */

	@RequestMapping("/moviePosterLoad.do")
	@ResponseBody
	public List<MovieRankPosterVO> loadRankPoster() {
		List<MovieRankPosterVO> list = null;
		list = movieListDAO.selectList();
		return list;
	}

	@RequestMapping("/movieQueryRecord.do")
	@ResponseBody
	public int insert(MovieRecordVO vo) {
		int res = 0;

		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		res = movieListDAO.insert(vo);
		return res;
	}

}
