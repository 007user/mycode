package com.xcn.entity;

import java.util.ArrayList;
import java.util.List;

public class User {

    private Integer id;
    private String name;
    private  String sex;
    private List<Book> books = new ArrayList<Book>();

    /*用户收藏书本的方法*/
    public void Book_Collection(Book book){
        books.add(book);
    }

    public User() {

    }

    public User(Integer id, String name, String sex) {
        this.id = id;
        this.name = name;
        this.sex = sex;
    }

    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getSex() {
        return sex;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", sex='" + sex + '\'' +
                '}';
    }
}
