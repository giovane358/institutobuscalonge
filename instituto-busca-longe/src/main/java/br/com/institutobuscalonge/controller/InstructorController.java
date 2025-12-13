package br.com.institutobuscalonge.controller;


import br.com.institutobuscalonge.domain.Auth;
import br.com.institutobuscalonge.domain.Instructor;
import br.com.institutobuscalonge.domain.Student;
import br.com.institutobuscalonge.dto.instructor.InstructorDTO;
import br.com.institutobuscalonge.dto.instructor.InstructorDeleteDTO;
import br.com.institutobuscalonge.dto.instructor.InstructorUpdateDTO;
import br.com.institutobuscalonge.repositories.InstructorRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.persistence.PreUpdate;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.net.openssl.ciphers.Encryption;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping("/instructor")
@Tag(name = "Instrutores.", description = "Observação: esses endpoints exigem autenticação. Algumas operações (ex.: delete, update) podem exigir a role ADMIN ou INSTRUCTOR_MANAGER.")
@SecurityRequirement(name = "BearerAuth")
public class InstructorController {

    @Autowired
    InstructorRepository instructorRepository;

    @PostMapping(path = "/register", consumes = MediaType.APPLICATION_JSON_VALUE)
    @Operation(summary = "Realizar o cadastro", description = "Cria um novo instrutor no sistema.")
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

        Instructor instructor = new Instructor(data.firstName(), data.lastName(), data.email(), encryptedPasword, data.contact(), data.cpf(), data.birthDate());

        if (user != null) {
            instructor.setCreatedBy(user);
        }
        instructorRepository.save(instructor);
        return ResponseEntity.ok(instructor);

    }
    @GetMapping(path = "/list/enable")
    @Operation(summary = "Listar Instrutores habilitados", description = "Retorna a lista de instrutores com enabled = true", method = "POST")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<List<Instructor>> getInscrutorEnable(Authentication authentication){
        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Auth auth = (Auth) authentication.getPrincipal();
        UUID userId = auth.getId();

        List<Instructor> insctructor = this.instructorRepository.findAllByCreatedBy_IdAndActiveTrue(userId);

        return ResponseEntity.ok(insctructor);
    }

    @GetMapping(path = "/list/disabled")
    @Operation(summary = "Listar Instrutores desabilitados", description = "Retorna a lista de instrutores com enabled = false.", method = "POST")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<List<Instructor>> getInscrutorDisabled(Authentication authentication){
        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Auth auth = (Auth) authentication.getPrincipal();
        UUID userId = auth.getId();

        List<Instructor> insctructor = this.instructorRepository.findAllByCreatedBy_IdAndActiveFalse(userId);

        return ResponseEntity.ok(insctructor);
    }


    @DeleteMapping(
            path = "/delete",
            consumes = MediaType.APPLICATION_JSON_VALUE
    )
    public ResponseEntity<Instructor> deleteInstructor(
            Authentication authentication,
            @RequestBody @Valid InstructorDeleteDTO data
    ) {
        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        Auth authUser = (Auth) authentication.getPrincipal();
        UUID userId = authUser.getId();

        Instructor instructor = instructorRepository.findById(data.ri()).orElse(null);

        if (instructor == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        if (instructor.getCreatedBy() == null ||
                !instructor.getCreatedBy().getId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        instructor.setActive(false);
        instructorRepository.save(instructor);

        return ResponseEntity.ok(instructor);
    }


    @PutMapping("/update")
    @Operation(summary = "Atualizar dados do instrutor", description = "Atualiza os dados de um instrutor existente. Enviar o id e os campos a alterar.", method = "PUT")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<Instructor> updateInstructor(Authentication authentication, @RequestBody @Valid InstructorUpdateDTO data){

        // pega Auth do Authentication (se presente)
        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        Auth authUser = (Auth) authentication.getPrincipal();
        UUID userId = authUser.getId();

        Instructor instructor = instructorRepository.findById(data.ri()).orElse(null);

        if (instructor == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        // Verifica se o estudante pertence ao usuário logado
        if (instructor.getCreatedBy() == null || !instructor.getCreatedBy().getId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        instructor.setRi(data.ri());
        instructor.setEmail(data.email());
        instructor.setContact(data.contact());
        instructorRepository.save(instructor);
        return ResponseEntity.ok(instructor);
    }
}
