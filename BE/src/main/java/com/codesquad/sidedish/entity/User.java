package com.codesquad.sidedish.entity;

import org.springframework.data.annotation.Id;

public class User {

    @Id
    private Long id;

    private String githubEmail;

    public User(String githubEmail) {
        this.githubEmail = githubEmail;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getGithubEmail() {
        return githubEmail;
    }

    public void setGithubEmail(String githubEmail) {
        this.githubEmail = githubEmail;
    }
}
