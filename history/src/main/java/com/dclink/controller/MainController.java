package com.dclink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping("/main.do")
	public String index() {
        return "index";
    }
	
	@RequestMapping("/game.do")
	public String game() {
        return "game";
    }

	@RequestMapping("/scenario.do")
	public String scenario() {
        return "scenario";
    }
	
	@RequestMapping("/light.do")
	public String light() {
        return "light";
    }
	
	@RequestMapping("/admin.do")
	public String admin() {
        return "admin";
        
    }
	
	@RequestMapping("/meta.do")
	public String meta() {
        return "meta";
    }

	@RequestMapping("/heroes.do")
	public String heroes() {
        return "heroes";
    }

	
	@RequestMapping("/test.do")
	public String test() {
        return "test";
    }
	
	@RequestMapping("/makeFile.do")
	public String makeFile() {
        return "makeFile";
    }
}