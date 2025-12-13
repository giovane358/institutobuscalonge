package br.com.institutobuscalonge.infra.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfigurations {

    @Autowired
    SecurityFilter securityFilter;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .csrf(csrf -> csrf.disable()) // ok para teste; em produção, reavalie
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(auth -> auth
                        // permitir a página de login (GET) e recursos estáticos
                        .requestMatchers(HttpMethod.GET, "/login").permitAll()
                        .requestMatchers("/css/**", "/js/**", "/images/**", "/webjars/**").permitAll()

                        .requestMatchers(HttpMethod.GET, "/dashboard").permitAll()
                        .requestMatchers(HttpMethod.GET, "/register").permitAll()
                        .requestMatchers(HttpMethod.GET, "/homePage").permitAll()

                        // permitir todos os endpoints de auth (opcional; mantém POST autorizar)
                        .requestMatchers("/auth/**", "/api/auth/**").permitAll()

                        // permitir acesso para os forwards internos ao JSP (IMPORTANTE)
                        .requestMatchers(HttpMethod.GET, "/WEB-INF/**").permitAll()
                        .requestMatchers("/error").permitAll()

                        // endpoints já protegidos por role (exemplo)
                        .requestMatchers(HttpMethod.POST, "/student/register").hasRole("ADMIN")
                        .requestMatchers(HttpMethod.GET, "/student/listar/enabled").hasRole("ADMIN")
                        .requestMatchers(HttpMethod.POST, "/student/listar/disabled").hasRole("ADMIN")
                        .requestMatchers(HttpMethod.PUT, "/student/update").hasRole("ADMIN")
                        .requestMatchers(HttpMethod.DELETE, "/student/delete").hasRole("ADMIN")
                        .requestMatchers(HttpMethod.POST, "/instructor/register").hasRole("ADMIN")

                        .requestMatchers(HttpMethod.DELETE, "/instructor/**").hasRole("ADMIN")


                        // Swagger
                        .requestMatchers(
                                "/v3/api-docs/**",
                                "/v3/api-docs.yaml",
                                "/swagger-ui/**",
                                "/swagger-ui.html",
                                "/swagger-ui/index.html",
                                "/webjars/**",
                                "/doc/**"
                        ).permitAll()

                        .anyRequest().authenticated()
                )
                .addFilterBefore(securityFilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
