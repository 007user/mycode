package com.xcn.entity;

public class Types {
    private Integer type_id;
    private String typer_name;

    public Types() {
    }

    public Types(Integer type_id, String typer_name) {
        type_id = this.type_id;
        typer_name = this.typer_name;
    }

    public Integer getType_id() {
        return type_id;
    }

    public void setType_id(Integer type_id) {
        this.type_id = type_id;
    }

    public String getTyper_name() {
        return typer_name;
    }

    public void setTyper_name(String typer_name) {
        this.typer_name = typer_name;
    }

    @Override
    public String toString() {
        return "Types{" +
                "type_id=" + type_id +
                ", typer_name='" + typer_name + '\'' +
                '}';
    }
}
