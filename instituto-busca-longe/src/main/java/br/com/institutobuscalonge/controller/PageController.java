package br.com.institutobuscalonge.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {
    @GetMapping("/login")
    public String loginPage() {
        return "forward:/WEB-INF/view/login.jsp"; // espera /WEB-INF/views/login.jsp (com spring.mvc.view.prefix/suffix configurado)
    }

    @GetMapping("/dashboard")
    public String dashboardPage() {
        return "forward:/WEB-INF/view/dashboard.jsp"; // espera /WEB-INF/views/login.jsp (com spring.mvc.view.prefix/suffix configurado)
    }

    @GetMapping("/register")
    public String registerPage() {
        return "forward:/WEB-INF/view/register.jsp"; // espera /WEB-INF/views/login.jsp (com spring.mvc.view.prefix/suffix configurado)
    }

    @GetMapping("/homePage")
    public String homePage() {
        return "forward:/WEB-INF/view/homePage.jsp"; // espera /WEB-INF/views/login.jsp (com spring.mvc.view.prefix/suffix configurado)
    }

}
