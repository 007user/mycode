package com.xcn.entity;

public class Author {
    private Integer author_id;
    private String author_name;

    public Author() {
    }

    public Author(Integer author_id, String author_name) {
        this.author_id = author_id;
        this.author_name = author_name;
    }

    public Integer getAuthor_id() {
        return author_id;
    }

    public String getAuthor_name() {
        return author_name;
    }

    public void setAuthor_id(Integer author_id) {
        this.author_id = author_id;
    }

    public void setAuthor_name(String author_name) {
        this.author_name = author_name;
    }

    @Override
    public String toString() {
        return "Author{" +
                "author_id=" + author_id +
                ", author_name='" + author_name + '\'' +
                '}';
    }
}
