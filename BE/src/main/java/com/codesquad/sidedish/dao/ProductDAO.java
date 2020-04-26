package com.codesquad.sidedish.dao;

import com.codesquad.sidedish.dto.DetailDTO;
import com.codesquad.sidedish.dto.SimpleDTO;
import com.codesquad.sidedish.entity.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;

@Repository
public class ProductDAO {

    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Autowired
    public ProductDAO(DataSource dataSource) {
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public List<SimpleDTO> selectByMenu(Menu menu) {
        String sql = "SELECT p.id, p.hash," +
                " p.title, p.description," +
                " CONCAT(FORMAT(p.s_price, 0), '원') AS s_price, CONCAT(FORMAT(p.n_price, 0), '원') AS n_price," +
                " p.image," +
                " GROUP_CONCAT(DISTINCT d.name SEPARATOR ',') AS deliver_types," +
                " GROUP_CONCAT(DISTINCT b.name SEPARATOR ',') AS badge_types" +
                " FROM product p" +
                " LEFT OUTER JOIN product_delivery pd ON p.id = pd.product" +
                " LEFT OUTER JOIN delivery d ON pd.delivery = d.id" +
                " LEFT OUTER JOIN product_badge pb ON p.id = pb.product" +
                " LEFT OUTER JOIN badge b ON pb.badge = b.id" +
                " WHERE menu = :menu" +
                " GROUP BY p.id, p.hash," +
                    " p.title, p.description," +
                    " CONCAT(FORMAT(p.s_price, 0), '원'), CONCAT(FORMAT(p.n_price, 0), '원')," +
                    " p.image";
        return namedParameterJdbcTemplate.query(sql,
                new MapSqlParameterSource("menu", menu.toString()),
                (rs, rowNum) -> {
                    List<String> badges= rs.getString("badge_types") == null
                            ? Collections.emptyList() : Arrays.asList(rs.getString("badge_types").split(","));
                    return new SimpleDTO(
                            rs.getInt("id"),
                            rs.getString("hash"),
                            rs.getString("title"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getString("s_price"),
                            rs.getString("n_price"),
                            rs.getString("image"),
                            Arrays.asList(rs.getString("deliver_types").split(",")),
                            badges
                    );
                }

        );
    }

    public DetailDTO selectDetailByHash(String hash) throws EmptyResultDataAccessException {
        final String sql = "SELECT p.id, p.hash," +
                " p.title, p.description," +
                " CONCAT(FORMAT(p.s_price, 0), '원') AS s_price_currency_format," +
                " CONCAT(FORMAT(p.n_price, 0), '원') AS n_price_currency_format," +
                " p.s_price, p.n_price," +
                " p.delivery_fee, p.delivery_possible," +
                " p.image," +
                " (SELECT group_concat(ti.url  SEPARATOR ',') FROM thumb_image ti WHERE p.id = ti.product) AS thumb_images," +
                " (SELECT group_concat(di.url SEPARATOR ',') FROM detail_image di WHERE p.id = di.product) AS detail_images," +
                " GROUP_CONCAT(d.name SEPARATOR ',') AS deliver_types" +
                " FROM product p, product_delivery pd, delivery d" +
                " WHERE hash = :hash" +
                " AND p.id = pd.product" +
                " AND d.id = pd.delivery" +
                " GROUP BY p.id, p.hash," +
                    " p.title, p.description," +
                    " CONCAT(FORMAT(p.s_price, 0), '원'), CONCAT(FORMAT(p.n_price, 0), '원'), p.s_price, p.n_price," +
                    " p.delivery_fee, p.delivery_possible," +
                    " p.image";
        return namedParameterJdbcTemplate.queryForObject(sql,
                new MapSqlParameterSource("hash", hash),
                (rs, rowNum) ->
                        new DetailDTO(
                                rs.getInt("id"),
                                rs.getString("hash"),
                                rs.getString("title"),
                                rs.getString("description"),
                                rs.getString("s_price_currency_format"),
                                rs.getString("n_price_currency_format"),
                                getPoint(rs.getInt("s_price"), rs.getInt("n_price")),
                                rs.getString("delivery_fee"),
                                rs.getString("delivery_possible"),
                                rs.getString("image"),
                                Arrays.asList(rs.getString("thumb_images").split(",")),
                                Arrays.asList(rs.getString("detail_images").split(",")),
                                Arrays.asList(rs.getString("deliver_types").split(","))
                        )
        );
    }

    private String getPoint(int sPrice, int nPrice) {
        final float POINT_RATIO = 0.01f;
        return sPrice == 0 ? (int)(nPrice * POINT_RATIO) + "원" : (int)(sPrice * POINT_RATIO) + "원";
    }
}
