package com.korea.movie;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;

@Controller
public class LocationController {

	@RequestMapping("/location.do")
	public String location() {
		return Common.Location.VIEW_PATH + "location.jsp";
	}
	
	
}
