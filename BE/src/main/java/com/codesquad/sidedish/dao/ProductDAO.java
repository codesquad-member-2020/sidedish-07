package com.codesquad.sidedish.dao;

import com.codesquad.sidedish.dto.SimpleDTO;
import com.codesquad.sidedish.entity.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;

@Repository
public class ProductDAO {

    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Autowired
    public ProductDAO(DataSource dataSource) {
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public List<SimpleDTO> selectByMenu(Menu menu) {
        List<SimpleDTO> products = queryFromProductByMenu(menu);
        String sqlForDeliveryTypes = "SELECT d.name as name" +
                " FROM product_delivery pd" +
                " LEFT OUTER JOIN delivery d ON pd.delivery = d.id" +
                " WHERE product = :productId";
        String sqlForBadges = "SELECT b.name as name" +
                " FROM product_badge pb" +
                " LEFT OUTER JOIN badge b ON pb.badge = b.id" +
                " WHERE product = :productId";

        for (SimpleDTO product : products) {
            product.setDeliveryTypes(queryByProductId(sqlForDeliveryTypes, product.getId()));
            product.setBadges(queryByProductId(sqlForBadges, product.getId()));
        }
        return products;
    }

    private List<SimpleDTO> queryFromProductByMenu(Menu menu) {
        String sql = "SELECT id, hash, title, description, CONCAT(FORMAT(s_price, 0), '원') as s_price, CONCAT(FORMAT(n_price, 0), '원') as n_price, image" +
                " FROM product" +
                " WHERE menu = :menu";
        return namedParameterJdbcTemplate.query(sql,
                new MapSqlParameterSource("menu", menu.toString()),
                (rs, rowNum) ->
                        new SimpleDTO(
                                rs.getInt("id"),
                                rs.getString("hash"),
                                rs.getString("title"),
                                rs.getString("title"),
                                rs.getString("description"),
                                rs.getString("s_price"),
                                rs.getString("n_price"),
                                rs.getString("image")
                        )
        );
    }

    private List<String> queryByProductId(String sql, Integer productId) {
        return namedParameterJdbcTemplate.query(sql,
                new MapSqlParameterSource("productId", productId),
                (rs, rowNum) ->
                        new String(rs.getString("name"))
        );
    }
}
