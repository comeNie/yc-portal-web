package com.ai.yc.protal.web.controller.user.interpreter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/interpreter")
@Controller
public class InterpreterController {
	@RequestMapping("/interpreterInfoPager")
	public ModelAndView toInterpreterBaseInfo(){
		return new ModelAndView("/user/authentication/interpreter_info");
	}
}
