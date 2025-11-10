package br.com.institutobuscalonge.controller;


import br.com.institutobuscalonge.domain.Auth;
import br.com.institutobuscalonge.domain.Instructor;
import br.com.institutobuscalonge.dto.instructor.InstructorDTO;
import br.com.institutobuscalonge.repositories.InstructorRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.apache.tomcat.util.net.openssl.ciphers.Encryption;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/instructor")
@Tag(name = "Instrutores", description = "Controle de Instrutores")
@SecurityRequirement(name = "BearerAuth")
public class InstructorController {

    @Autowired
    InstructorRepository instructorRepository;

    @PostMapping(path = "/register", consumes = MediaType.APPLICATION_JSON_VALUE)
    @Operation(summary = "Realizar o cadastro", description = "Realizar a verificação se tem usuário com os mesmo dados cadastrado no sistema...")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<Instructor> registerInstructor(Authentication authentication, @RequestBody @Valid InstructorDTO data){

        Auth user = null;
        if (authentication != null && authentication.getPrincipal() instanceof Auth) {
            user = (Auth) authentication.getPrincipal();
        }

        if (this.instructorRepository.findByEmail(data.email()) != null) {
             return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        String encryptedPasword = new BCryptPasswordEncoder().encode(data.senha());

        Instructor instructor = new Instructor(data.firstName(), data.firstName(), data.email(), encryptedPasword, data.contact(), data.cpf(), data.birthDate());

        if (user != null) {
            instructor.setCreatedBy(user);
        }
        instructorRepository.save(instructor);
        return ResponseEntity.ok(instructor);

    }
}
