package com.xcn.entity;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Book implements Serializable {
    private Integer book_id;
    private String book_name;
    private Author author;
    private String book_time;
    private float book_pice;
    private Types type;
    public Book() {
    }

    public Integer getBook_id() {
        return book_id;
    }

    public void setBook_id(Integer book_id) {
        this.book_id = book_id;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    public String getBook_time() {
        return book_time;
    }

    public void setBook_time(String book_time) {
        this.book_time = book_time;
    }

    public Types getType() {
        return type;
    }

    public void setType(Types type) {
        this.type = type;
    }

    public float getBook_pice() {
        return book_pice;
    }

    public void setBook_pice(float book_pice) {
        this.book_pice = book_pice;
    }

  public Types getBook_type() {
        return type;
    }

    public void setBook_type(Types book_type) {
        this.type = book_type;
    }

    @Override
    public String toString() {
        return "Book{" +
                "book_id=" + book_id +
                ", book_name='" + book_name + '\'' +
                ", author=" + author +
                ", book_time='" + book_time + '\'' +
                ", book_pice=" + book_pice +
                ", type=" + type +
                '}';
    }
}
