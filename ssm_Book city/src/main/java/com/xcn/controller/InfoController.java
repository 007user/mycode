package com.xcn.controller;

import cn.dsna.util.images.ValidateCode;
import com.google.gson.Gson;
import com.xcn.entity.Types;
import com.xcn.service.InfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class InfoController {

    @Autowired
    InfoService infoService;

    @RequestMapping(value="/info",produces="text/html;charset=utf-8")
    @ResponseBody
    public String  info() {
        System.out.println("info!");
        List<Types> list = infoService.queryInfo();
        System.out.println(list);
        Map<String,Object> maps = new HashMap<String, Object>();
        maps.put("code", 0);
        maps.put("msg", "");
        maps.put("count", 0);
        maps.put("data", list);
        return new Gson().toJson(maps);
    }


    @RequestMapping(value="/code",produces="text/html;charset=utf-8")
    @ResponseBody
    public void  code(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse){
        System.out.println("code!");
        ValidateCode validateCode = new ValidateCode(300,100,4,10);
        String code = validateCode.getCode();
        httpServletRequest.getSession().setAttribute("code",code);
        System.out.println(code);
        try {
            validateCode.write(httpServletResponse.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        //System.out.println(httpServletRequest.getSession().getAttribute("users"));
    }

    @RequestMapping(value="/login",produces="text/html;charset=utf-8")
    @ResponseBody
    public  String login(HttpServletRequest httpServletRequest, String uname, String upwd, String code,String c){
        System.out.println(uname);
        System.out.println(upwd);
        System.out.println(code);
        System.out.println(httpServletRequest.getSession().getAttribute("code"));
        String str = "false";
        if(("admin".equals(uname) && "admin".equals(upwd)) && (httpServletRequest.getSession().getAttribute("code").equals(code))){
            str = "true";
            httpServletRequest.getSession().setAttribute("users","admin");
        }else if(httpServletRequest.getSession().getAttribute("code") != (code)){
            str = "false";
            httpServletRequest.getSession().setAttribute("msg","验证码错误或者登录用户不存在！");
        }
        System.out.println(str);
        return str;
    }

    @RequestMapping(value="/zx",produces="text/html;charset=utf-8")
    @ResponseBody
    public  void zx(HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse){
        httpServletRequest.getSession().invalidate();
        httpServletRequest.getSession().removeAttribute("users");
        try {
            httpServletResponse.sendRedirect("login.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
