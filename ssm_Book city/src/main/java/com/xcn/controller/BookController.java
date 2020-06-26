package com.xcn.controller;

import com.google.gson.Gson;
import com.xcn.entity.Author;
import com.xcn.entity.Book;
import com.xcn.entity.Types;
import com.xcn.service.BookService;
import com.xcn.service.InfoService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class BookController {

    @Autowired
    BookService bookService;


    @RequestMapping(value="/bookAll",produces="text/html;charset=utf-8")
    @ResponseBody
    public String  queryBook_All(HttpServletRequest httpServletRequestpRequest) throws UnsupportedEncodingException {

        /*从前端获取参数开始*/
        String pa = httpServletRequestpRequest.getParameter("page");
        String li = httpServletRequestpRequest.getParameter("limit");
        String bookname = httpServletRequestpRequest.getParameter("bookname");
        String bookauthor = httpServletRequestpRequest.getParameter("bookauthor");
        String booktype = httpServletRequestpRequest.getParameter("booktype");
        String btm = httpServletRequestpRequest.getParameter("btm");
        String atm = httpServletRequestpRequest.getParameter("atm");
        /*从前端获取结束*/

        System.out.println(btm);
        System.out.println(atm);
        if("".equals(btm) && "".equals(atm)){
            btm = null;
            atm = null;
        }

        int rows = Integer.parseInt(pa);
        int cols = Integer.parseInt(li);
        List<Book>  books = bookService.queryBook_All((rows * cols) - cols, cols, bookname, bookauthor, booktype, btm, atm);
        Map<String,Object> maps = new HashMap<String, Object>();
        maps.put("code", 0);
        maps.put("msg", "");
        maps.put("count", bookService.queryBook_All_count(bookname, bookauthor, booktype, btm, atm));
        maps.put("data", books);

        System.out.println("------------------------------------");
        System.out.println(bookService.queryBook_All_count(bookname, bookauthor, booktype, btm, atm));
        System.out.println(books);
        System.out.println("------------------------------------");
        System.out.println(atm);
        System.out.println(btm);
        System.out.println("".equals(btm));

      /*System.out.println("------------------------------------");
        System.out.println(rows+"/////"+cols);
        System.out.println((rows*cols)-cols+"/////"+cols);
        System.out.println("------------------------------------");
        System.out.println(bookService);*/
        return new Gson().toJson(maps) ;
    }


    @RequestMapping(value="/delbook",produces="text/html;charset=utf-8")
    @ResponseBody
    public String  delbook(HttpServletRequest httpServletRequestpRequest){
        String ids = httpServletRequestpRequest.getParameter("id");/* Util.getSqlInStrByStrArray();*/
        System.out.println(ids);
        String[] strs  = ids.split(",");
        int [] arr = new int[strs.length];
        for(int i = 0;i<strs.length;i++){
            arr[i] = Integer.parseInt(strs[i]);
        }
        System.out.println(strs);
        int a = bookService.delBook(arr);
        System.out.println(a);
        String str = "false";
        if (a > 0){
            str = "true";
        }else {
            str = "false";
        }
        return str;
    }


    @RequestMapping(value="/updataBook",produces="text/html;charset=utf-8")
    @ResponseBody
    public String  updataBook(HttpServletRequest httpServletRequestpRequest){
        String time = httpServletRequestpRequest.getParameter("time");
        String pices = httpServletRequestpRequest.getParameter("pices");
        int id = Integer.parseInt(httpServletRequestpRequest.getParameter("id"));
        System.out.println(time);
        System.out.println(pices);
        System.out.println(id);
        int a = bookService.updataBook(time,pices,id);
        System.out.println(a);
        String str = "false";
        if (a > 0){
            str = "true";
        }else {
            str = "false";
        }
        return str;
    }

    @RequestMapping(value="/select",produces="text/html;charset=utf-8")
    @ResponseBody
    public String  select(){
        List<Types> list = bookService.selects();
        System.out.println(list);
        Map<String,Object> maps = new HashMap<String, Object>();
        maps.put("code", 0);
        maps.put("msg", "");
        maps.put("count", 0);
        maps.put("data", list);
        return new Gson().toJson(maps);
    }

    @RequestMapping(value="/selec",produces="text/html;charset=utf-8")
    @ResponseBody
    public String  selec(){
        List<Author> list = bookService.selectss();
        System.out.println(list);
        Map<String,Object> maps = new HashMap<String, Object>();
        maps.put("code", 0);
        maps.put("msg", "");
        maps.put("count", 0);
        maps.put("data", list);
        return new Gson().toJson(maps);
    }

    @RequestMapping(value="/add_book",produces="text/html;charset=utf-8")
    @ResponseBody
    public String  selec(HttpServletRequest httpServletRequestpRequest){

        int num = bookService.add_Book(httpServletRequestpRequest.getParameter("bookname"),
                        Integer.parseInt(httpServletRequestpRequest.getParameter("booktypeid")),
                        httpServletRequestpRequest.getParameter("booktime"),
                        Float.parseFloat(httpServletRequestpRequest.getParameter("booktpice")),
                        Integer.parseInt(httpServletRequestpRequest.getParameter("bookauthorid"))
                        );
        String str = "false";
        if (num > 0){
            str = "true";
        }else {
            str = "false";
        }
        return str;
    }
}
