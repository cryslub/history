package com.dclink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping("/main.do")
	public String index() {
        return "index";
    }
	
	@RequestMapping("/admin.do")
	public String admin() {
        return "admin";
    }
	
	@RequestMapping("/meta.do")
	public String meta() {
        return "meta";
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