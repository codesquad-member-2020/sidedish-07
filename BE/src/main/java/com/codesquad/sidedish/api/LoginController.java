package com.codesquad.sidedish.api;

import com.codesquad.sidedish.entity.OAuthGithubToken;
import com.codesquad.sidedish.entity.User;
import com.codesquad.sidedish.service.OAuthService;
import com.fasterxml.jackson.databind.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;

@Controller
public class LoginController {

    private static final Logger log = LoggerFactory.getLogger(SidedishController.class);

    private final OAuthService oauthService;

    public LoginController(OAuthService oAuthService) {
        this.oauthService = oAuthService;
    }

    @GetMapping("/login")
    public String OauthTest(@PathParam("code") String code, HttpServletResponse response) {
        log.debug("{}", code);
        OAuthGithubToken oAuthGithubToken = oauthService.getAccessToken(code);
        response.setHeader("Authorization", oAuthGithubToken.getAuthorization());
        log.debug("{}", oAuthGithubToken.getAuthorization());

        return "/";
    }

    @PostMapping("/users")
    public ResponseEntity<String> signIn(HttpServletResponse response, HttpServletRequest request) {
        String accessToken = request.getHeader("Authorization");
        log.debug("{}", accessToken);
        ResponseEntity<JsonNode> jsonNode = oauthService.getUserEmailFromOAuthToken(accessToken);
        JsonNode body = jsonNode.getBody();

        User newUser = null;
        for (JsonNode child : body) {
            if(child.get("primary").asText().equals("true")) {
                newUser = new User(child.get("email").asText());
            }
        }
        log.debug("{}", newUser.getGithubEmail());

        return ResponseEntity.ok(newUser.getGithubEmail());
    }
}
