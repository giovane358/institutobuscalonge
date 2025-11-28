package br.com.institutobuscalonge.infra.security;

import br.com.institutobuscalonge.domain.Auth;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;

@Service
public class TokenService {

    @Value("${api.security.token.secret}")
    String secret;

    public String generateToken(Auth auth) { //Criando o token
        try {
            Algorithm algorithm = Algorithm.HMAC256(secret); // O tipo da Hash do token no caso HMC256
            String token = JWT
                    .create() // Cria o Tokne
                    .withIssuer("instituto-busca-longe"). // Quem criou o token
                    withSubject(auth.getUsername()) // QUem criou o token
                    .withClaim("id", auth.getId().toString())
                    .withClaim("roles", auth.getRole().toString())
                    .withExpiresAt(generateExpiresDate()) // Tempo de expiração do token
                    .sign(algorithm);
            return token;

        } catch (JWTCreationException exception) {
            throw new RuntimeException("Erro ao generar JWT", exception); // Quando da erro ao criar o token ele dispara uma exception
        }
    }

    public  String validateToken(String token) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(secret);
            return JWT.require(algorithm).withIssuer("instituto-busca-longe").build().verify(token).getSubject();
        }catch (JWTVerificationException exception){
            throw new RuntimeException("Erro ao validar JWT", exception); // Quando não e possível validar o token
        }
    }

    private Instant generateExpiresDate() {
        return LocalDateTime.now().plusHours(2).toInstant(ZoneOffset.of("-03:00")); // Tempo de duração do token de 2 horas de acordo com o horario de brasilia
    }
}
