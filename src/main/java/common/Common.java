package common;

public class Common {

	public static final String VIEW_PATH = "WEB-INF/views/";

	//게시판별 관리를 편하게 하기 위한 클래스

	//Board
	public static class Board{
		public static final String VIEW_PATH = "WEB-INF/views/board/";
		//한 페이지당 보여줄 게시물 수
		public final static int BLOCKLIST = 3;
		public final static int BLOCKLIST2 = 10;
		
		//한 화면에 보여지는 페이지 메뉴 수
		//◀  1 2 3 4 5  ▶
		public final static int BLOCKPAGE = 5;
	}

	//Movie
	public static class Movie{
		public static final String VIEW_PATH = "WEB-INF/views/movie/";
		//한 페이지당 보여줄 게시물 수
		public final static int BLOCKLIST = 10;

		//한 화면에 보여지는 페이지 메뉴 수
		//◀  1 2 3 4 5  ▶
		public final static int BLOCKPAGE = 5;
	}

	//User
	public static class User{
		public static final String VIEW_PATH = "WEB-INF/views/user/";
		//한 페이지당 보여줄 게시물 수
		public final static int BLOCKLIST = 10;

		//한 화면에 보여지는 페이지 메뉴 수
		//◀  1 2 3 4 5  ▶
		public final static int BLOCKPAGE = 5;
	}

	//Location
	public static class Location{
		public static final String VIEW_PATH = "WEB-INF/views/location/";
		//한 페이지당 보여줄 게시물 수
		public final static int BLOCKLIST = 10;

		//한 화면에 보여지는 페이지 메뉴 수
		//◀  1 2 3 4 5  ▶
		public final static int BLOCKPAGE = 5;
	}
}








