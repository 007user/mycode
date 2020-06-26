package com.xcn.service;

import com.xcn.entity.Author;
import com.xcn.entity.Book;
import com.xcn.entity.Types;
import org.apache.ibatis.annotations.Param;

import java.util.List;
public interface BookService {

    /*查询所有书籍*/
    public List<Book> queryBook_All(@Param("rows") int rows,@Param("cols") int cols,@Param("bookname") String bookname,@Param("bookauthor") String bookauthor,@Param("booktype") String booktype,@Param("btm") String btm,@Param("atm") String atm);

    /*查询书籍总数*/
    public int queryBook_All_count(@Param("bookname") String bookname,@Param("bookauthor") String bookauthor,@Param("booktype") String booktype,@Param("btm") String btm,@Param("atm") String atm);

    public  void addBook(Book book);

    public int delBook(int[] ids);

    public int updataBook(@Param("time") String time,@Param("pices") String pices,@Param("id") int id);

    public List<Types> selects();

    public List<Author> selectss();

    public int add_Book(@Param("bookname") String bookname,@Param("bookauthor_id") Integer bookauthor_id,@Param("booktime") String booktime,@Param("bookpice") Float bookpice,@Param("booktype_id") int booktype_id);
}
