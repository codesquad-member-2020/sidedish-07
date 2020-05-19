package com.codesquad.sidedish.security;

import com.codesquad.sidedish.entity.User;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.expression.ExpressionException;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtToken {

    private static final Logger log = LoggerFactory.getLogger(JwtToken.class);
    private static final String SECRET_KEY = "sidedish";
    private static final String USER_INFO_KEY = "githubEmail";

    public static String JwtTokenMaker(User user) {
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
        String githubEmail = user.getGithubEmail();

        Long expiredTime = 1000 * 60 * 60 * 24L;
        Date now = new Date();
        now.setTime(now.getTime()+expiredTime);

        byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(SECRET_KEY);
        Key key = new SecretKeySpec(apiKeySecretBytes, signatureAlgorithm.getJcaName());

        Map<String,Object> header = new HashMap<>();
        Map<String,Object> payload = new HashMap<>();

        header.put("typ","JWT");
        header.put("alg","HS256");

        payload.put("sub","userInfo");
        payload.put("exp",now);
        payload.put(USER_INFO_KEY,githubEmail);

        return Jwts.builder()
                .setHeader(header)
                .setClaims(payload)
                .signWith(signatureAlgorithm,key)
                .compact();
    }

    public static String validateToken(String token) throws ExpressionException, JwtException {
        return (String) Jwts.parser()
                .setSigningKey(DatatypeConverter.parseBase64Binary(SECRET_KEY))
                .parseClaimsJws(token).getBody()
                .get(USER_INFO_KEY);
    }

    private JwtToken() {}
}
