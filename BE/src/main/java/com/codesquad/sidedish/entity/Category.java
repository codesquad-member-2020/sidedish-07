package com.codesquad.sidedish.entity;

import org.springframework.data.annotation.Id;

public class Category {

    @Id
    private Integer id;

    private String name;

    public Category(String name) {
        this.name = name;
    }

    public Integer getId() {
        return id;
    }
}
