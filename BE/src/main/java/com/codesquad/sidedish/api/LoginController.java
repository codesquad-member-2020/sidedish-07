package com.codesquad.sidedish.api;

import com.codesquad.sidedish.service.OAuthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.websocket.server.PathParam;

@RestController
public class LoginController {

    private static final Logger log = LoggerFactory.getLogger(SidedishController.class);

    private final OAuthService oAuthService;

    public LoginController(OAuthService oAuthService) {
        this.oAuthService = oAuthService;
    }

    @GetMapping("/login/oauth2/code/github")
    public String OauthTest(@PathParam("code") String code) {
        log.debug("{}", code);
        oAuthService.getAccessToken(code);
        return "login Success";
    }
}
