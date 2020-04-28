package com.codesquad.sidedish.api;

import com.codesquad.sidedish.dao.ProductDAO;
import com.codesquad.sidedish.dto.DetailDTO;
import com.codesquad.sidedish.dto.SimpleDTO;
import com.codesquad.sidedish.entity.Menu;
import com.codesquad.sidedish.repository.UserRepository;
import com.codesquad.sidedish.response.ResponseData;
import com.codesquad.sidedish.security.JwtToken;
import io.jsonwebtoken.JwtException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.expression.ExpressionException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/products")
public class SidedishController {

    private static final Logger log = LoggerFactory.getLogger(SidedishController.class);
    private ProductDAO productDAO;
    private UserRepository userRepository;

    public SidedishController(ProductDAO productDAO, UserRepository userRepository) {
        this.productDAO = productDAO;
        this.userRepository = userRepository;
    }

    @GetMapping("/{menu}")
    public ResponseEntity<ResponseData> showProductsByMenu(@PathVariable String menu) {
        List<SimpleDTO> products = null;
        try {
            products = productDAO.selectByMenu(Menu.valueOf(menu.toUpperCase()));
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(new ResponseData(ResponseData.STATUS.ERROR, "API URL 오류"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.STATUS.SUCCESS, products), HttpStatus.OK);
    }

    @GetMapping("/detail/{hash}")
    public ResponseEntity<ResponseData> showDetail(@PathVariable String hash) {
        DetailDTO product = null;
        try {
            product = productDAO.selectDetailByHash(hash);
            processDeliveryInfo(product);
        } catch (EmptyResultDataAccessException e) {
            return new ResponseEntity<>(new ResponseData(ResponseData.STATUS.ERROR, "존재하지 않는 상품입니다."), HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(new ResponseData(ResponseData.STATUS.SUCCESS, product), HttpStatus.OK);
    }

    @PostMapping("/detail/{hash}/order")
    public ResponseEntity<ResponseData> order(@PathVariable String hash, HttpServletRequest request) {
        if (request.getCookies() == null)
            throw new SecurityException("No Any Cookies");

        String token = null;
        try {
            token = getToken(request).orElseThrow(() -> new SecurityException("No Authorization Cookie"));
        } catch (ExpressionException | JwtException e) {
            throw new SecurityException("Invalid Jwt token");
        }
        if (userRepository.countByGithubEmail(token) > 0)
            return new ResponseEntity<>(new ResponseData(ResponseData.STATUS.SUCCESS, "Order Success"), HttpStatus.OK);

        throw new SecurityException("Not Logged in User");
    }

    private void processDeliveryInfo(DetailDTO product) {
        String deliveryInfo = new StringBuilder(product.getDeliveryTypes().stream()
                .map((type) -> {
                    if(type.equals("새벽배송"))
                        return "서울 경기 새벽배송";
                    return "전국택배 (제주 및 도서산간 불가)";
                })
                .collect(Collectors.joining(" / ")))
                .append(product.getDeliveryInfo())
                .append(" 수령 가능한 상품입니다.").toString();
        product.setDeliveryInfo(deliveryInfo);
    }

    private Optional<String> getToken(HttpServletRequest request) {
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("Authorization")) {
                return Optional.of(JwtToken.validateToken(cookie.getValue()));
            }
        }
        return Optional.empty();
    }

    @ExceptionHandler(SecurityException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ResponseData handleSecurityException(SecurityException e) {
        return new ResponseData(ResponseData.STATUS.ERROR, e.getMessage());
    }
}
