package com.codesquad.sidedish.api;

import com.codesquad.sidedish.entity.OAuthGithubToken;
import com.codesquad.sidedish.entity.User;
import com.codesquad.sidedish.response.ResponseData;
import com.codesquad.sidedish.security.JwtToken;
import com.codesquad.sidedish.service.OAuthService;
import com.fasterxml.jackson.databind.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.io.IOException;

@Controller
public class LoginController {

    private static final Logger log = LoggerFactory.getLogger(SidedishController.class);

    private final OAuthService oauthService;
    private JwtToken jwtToken = new JwtToken();

    public LoginController(OAuthService oAuthService) {
        this.oauthService = oAuthService;
    }

    @GetMapping("/login")
    public String OauthTest(@PathParam("code") String code, HttpServletResponse response) throws IOException {
        log.debug("{}", code);
        OAuthGithubToken oAuthGithubToken = oauthService.getAccessToken(code);
        log.debug("{}", oAuthGithubToken.getAuthorization());
        String accessToken = oAuthGithubToken.getAuthorization();

        ResponseEntity<JsonNode> jsonNode = oauthService.getUserEmailFromOAuthToken(accessToken);
        JsonNode body = jsonNode.getBody();

        User newUser = null;
        for (JsonNode child : body) {
            if(child.get("primary").asText().equals("true")) {
                newUser = new User(child.get("email").asText());
            }
        }
        log.debug("{}", newUser.getGithubEmail());

        String jwt = jwtToken.JwtTokenMaker(newUser);
        log.debug("{}", jwt);

        response.addCookie(new Cookie("Authorization", jwt));
        return "redirect:/";
    }

}
