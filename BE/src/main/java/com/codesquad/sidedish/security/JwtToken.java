package com.codesquad.sidedish.security;

import com.codesquad.sidedish.entity.User;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtToken {

    public String JwtTokenMaker(User user) {
        String secretKey = "sidedish";
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
        String githubEmail = user.getGithubEmail();

        Long expiredTime = 1000 * 60 * 60 * 24L;
        Date now = new Date();
        now.setTime(now.getTime()+expiredTime);

        byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(secretKey);
        Key key = new SecretKeySpec(apiKeySecretBytes, signatureAlgorithm.getJcaName());

        Map<String,Object> header = new HashMap<>();
        Map<String,Object> payload = new HashMap<>();

        header.put("typ","JWT");
        header.put("alg","HS256");

        payload.put("sub","userInfo");
        payload.put("exp",now);
        payload.put("githubEmail",githubEmail);

        return Jwts.builder()
                .setHeader(header)
                .setClaims(payload)
                .signWith(signatureAlgorithm,key)
                .compact();
    }
}
