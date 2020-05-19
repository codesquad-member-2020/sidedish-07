package com.codesquad.sidedish.repository;

import com.codesquad.sidedish.entity.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Integer> {

    @Query("SELECT COUNT(github_email) FROM user WHERE github_email = :githubEmail")
    public Integer countByGithubEmail(String githubEmail);
}
