package com.codesquad.sidedish.dao;

import com.codesquad.sidedish.dto.DetailDTO;
import com.codesquad.sidedish.dto.SimpleDTO;
import com.codesquad.sidedish.entity.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

@Repository
public class ProductDAO {

    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Autowired
    public ProductDAO(DataSource dataSource) {
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public List<SimpleDTO> selectByMenu(Menu menu) {
        List<SimpleDTO> products = queryFromProductByMenu(menu);
        final String sqlForDeliveryTypes = "SELECT d.name as name" +
                " FROM product_delivery pd" +
                " LEFT OUTER JOIN delivery d ON pd.delivery = d.id" +
                " WHERE product = :productId";
        final String sqlForBadges = "SELECT b.name as name" +
                " FROM product_badge pb" +
                " LEFT OUTER JOIN badge b ON pb.badge = b.id" +
                " WHERE product = :productId";
        for (SimpleDTO product : products) {
            product.setDeliveryTypes(queryByProductId(sqlForDeliveryTypes, product.getId(), "name"));
            product.setBadges(queryByProductId(sqlForBadges, product.getId(), "name"));
        }
        return products;
    }

    public DetailDTO selectDetailByHash(String hash) {
        DetailDTO product = queryFromProductByHash(hash);
        final String sqlForThumbImages = "SELECT ti.url as url" +
                " FROM thumb_image ti" +
                " WHERE ti.product = :productId";
        final String sqlForDetailImages = "SELECT di.url as url" +
                " FROM detail_image di" +
                " WHERE di.product = :productId";
        final String sqlForDeliveryTypes = "SELECT d.name as name" +
                " FROM product_delivery pd" +
                " LEFT OUTER JOIN delivery d ON pd.delivery = d.id" +
                " WHERE product = :productId";
        product.setThumbImages(queryByProductId(sqlForThumbImages, product.getId(), "url"));
        product.setDetailImages(queryByProductId(sqlForDetailImages, product.getId(), "url"));
        product.setDeliveryTypes(queryByProductId(sqlForDeliveryTypes, product.getId(), "name"));
        return product;
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

    private DetailDTO queryFromProductByHash(String hash) throws DataAccessException {
        final String sql = "SELECT id, hash, title, description, CONCAT(FORMAT(s_price, 0), '원') as s_price_currency_format, CONCAT(FORMAT(n_price, 0), '원') as n_price_currency_format, s_price, n_price, delivery_fee, delivery_possible, image" +
                " FROM product" +
                " WHERE hash = :hash";
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
                                rs.getString("image")
                        )
        );
    }

    private List<String> queryByProductId(String sql, Integer productId, String namedParameter) {
        return namedParameterJdbcTemplate.query(sql,
                new MapSqlParameterSource("productId", productId),
                (rs, rowNum) ->
                        new String(rs.getString(namedParameter))
        );
    }

    private String getPoint(int sPrice, int nPrice) {
        final float POINT_RATIO = 0.01f;
        return sPrice == 0 ? (int)(nPrice * POINT_RATIO) + "원" : (int)(sPrice * POINT_RATIO) + "원";
    }
}
