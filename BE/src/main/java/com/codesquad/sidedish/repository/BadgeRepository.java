package com.codesquad.sidedish.repository;

import com.codesquad.sidedish.entity.Badge;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface BadgeRepository extends CrudRepository<Badge, Integer> {

    @Query("SELECT b.id, b.name FROM badge b WHERE b.name = :name")
    Optional<Badge> findByName(String name);
}
