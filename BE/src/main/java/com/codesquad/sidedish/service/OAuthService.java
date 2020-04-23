package com.codesquad.sidedish.service;

import com.codesquad.sidedish.entity.OAuthGithubToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class OAuthService {

    private static final Logger log = LoggerFactory.getLogger(OAuthService.class);

    private final String CLIENTID = "71186054709e9adda0f9";
    private final String CLIENTSECRET = "c0195e8d988b81aee4d7565da58941dd8e8fcc5a";
    private final String URL = "https://github.com/login/oauth/access_token";

    public void getAccessToken(String code) {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<String, String>();
        Map map = new HashMap<String, String>();
        map.put("Content-Type", "application/json");

        headers.setAll(map);

        Map req_payload = new HashMap();
        req_payload.put("code", code);
        req_payload.put("client_id", CLIENTID);
        req_payload.put("client_secret", CLIENTSECRET);

        HttpEntity<?> request = new HttpEntity<>(req_payload, headers);

        ResponseEntity<?> response = new RestTemplate().postForEntity(URL, request, String.class);
        log.debug("{}", response.getBody());
    }

}
