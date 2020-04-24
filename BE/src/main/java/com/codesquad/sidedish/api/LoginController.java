package com.codesquad.sidedish.api;

import com.codesquad.sidedish.entity.OAuthGithubToken;
import com.codesquad.sidedish.service.OAuthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;

@Controller
public class LoginController {

    private static final Logger log = LoggerFactory.getLogger(SidedishController.class);

    private final OAuthService oAuthService;

    public LoginController(OAuthService oAuthService) {
        this.oAuthService = oAuthService;
    }

    @GetMapping("/login")
    public String OauthTest(@PathParam("code") String code, HttpServletResponse response) {
        log.debug("{}", code);
        OAuthGithubToken oAuthGithubToken = oAuthService.getAccessToken(code);
        response.setHeader("Authorization", oAuthGithubToken.getAuthorization());
        log.debug("{}", oAuthGithubToken.getAuthorization());

        return "/";
    }
}
