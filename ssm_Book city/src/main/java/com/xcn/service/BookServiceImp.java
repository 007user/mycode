package com.xcn.service;

import com.xcn.dao.BookDao;
import com.xcn.entity.Author;
import com.xcn.entity.Book;
import com.xcn.entity.Types;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BookServiceImp implements BookService {

    @Resource
    private BookDao bookDao;


    @Override
    public List<Book> queryBook_All(int rows, int cols, String bookname, String bookauthor, String booktype, String btm, String atm) {
        return bookDao.queryBook_All(rows,cols,bookname,bookauthor,booktype,btm,atm);
    }

    @Override
    public int queryBook_All_count(String bookname, String bookauthor, String booktype, String btm, String atm) {
        return bookDao.queryBook_All_count(bookname, bookauthor, booktype, btm, atm);
    }


    @Override
    public void addBook(Book book) {

    }


    @Override
    public int delBook(int[] ids) {
      int a =  bookDao.delBook(ids);
      return a;
    }

    @Override
    public int updataBook(String time, String pices,int id) {
        return bookDao.updataBook(time,pices,id);
    }

    @Override
    public List<Types> selects() {
        return bookDao.selects();
    }

    @Override
    public List<Author> selectss() {
        return bookDao.selectss();
    }

    @Override
    public int add_Book(String bookname, Integer bookauthor_id, String booktime, Float bookpice, int booktype_id) {
        return bookDao.add_Book(bookname,bookauthor_id,booktime,bookpice,booktype_id);
    }

}
