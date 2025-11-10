package br.com.institutobuscalonge.controller;

import br.com.institutobuscalonge.domain.Auth;
import br.com.institutobuscalonge.dto.auth.AuthenticationDTO;
import br.com.institutobuscalonge.dto.auth.LoginDTO;
import br.com.institutobuscalonge.dto.auth.RegisterDTO;
import br.com.institutobuscalonge.infra.security.SecurityFilter;
import br.com.institutobuscalonge.infra.security.TokenService;
import br.com.institutobuscalonge.repositories.AuthRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("auth")
@Tag(name = "Usuario", description = "Controle de Criar e Login")
@SecurityRequirement(name = SecurityFilter.SECURITY)
public class AuthenticationController {
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private AuthRepository authRepository;

    @Autowired
    private TokenService tokenService;

    @PostMapping("/login")
    @Operation(summary = "Realizar o login", description = "Realizar a validação do usuário e gera o token", method = "POST")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity login(@RequestBody @Valid AuthenticationDTO data) {
        var userNamePassword = new UsernamePasswordAuthenticationToken(data.email(), data.password());
        var auth = this.authenticationManager.authenticate(userNamePassword);
        var token = tokenService.generateToken((Auth) auth.getPrincipal());
        return ResponseEntity.ok(new LoginDTO(token));
    }

    @PostMapping("/register")
    @Operation(summary = "Realizar o cadastro", description = "Realizar a verificação se tem usuário com os mesmo dados cadastrado no sistema se não tiver e possível realizar o cadastro", method = "POST")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<Auth> register(@RequestBody @Valid RegisterDTO data) {
        if (this.authRepository.findByEmail(data.email()) != null) {
            return ResponseEntity.badRequest().build();
        }
        String encryptedPasword = new BCryptPasswordEncoder().encode(data.password());
        String statusUser = "Ativo";
        Auth newUser = new Auth(data.email(), encryptedPasword, data.role(), data.firstName(), data.lastName(), statusUser);

        this.authRepository.save(newUser);
        return ResponseEntity.ok().build();
    }
}
