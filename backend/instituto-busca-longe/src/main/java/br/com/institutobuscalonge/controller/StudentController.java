package br.com.institutobuscalonge.controller;

import br.com.institutobuscalonge.domain.Auth;
import br.com.institutobuscalonge.domain.Student;
import br.com.institutobuscalonge.dto.StudentDTO;
import br.com.institutobuscalonge.repositories.StudentRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/student")
@Tag(name = "Estudante", description = "Controle de Criar")
@SecurityRequirement(name = "BearerAuth")
public class StudentController {

    @Autowired
    private StudentRepository studentRepository;

    @PostMapping(path = "/register", consumes = MediaType.APPLICATION_JSON_VALUE)
    @Operation(summary = "Realizar o cadastro", description = "Realizar a verificação se tem usuário com os mesmo dados cadastrado no sistema...")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<Student> registerStudents(Authentication authentication, @RequestBody @Valid StudentDTO data) {

        // pega Auth do Authentication (se presente)
        Auth user = null;
        if (authentication != null && authentication.getPrincipal() instanceof Auth) {
            user = (Auth) authentication.getPrincipal();
        }

        if (this.studentRepository.findByEmail(data.email()) != null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Student student = new Student(data.firstName(), data.email(), data.lastName(), data.birthDate(), data.nameDaddy(), data.nameMom(), data.contact()); // parametros para salvar os dados

        if (user != null) {
            student.setCreatedBy(user); // Adiciona o id do usuário.
        }

        studentRepository.save(student);
        return ResponseEntity.ok(student);
    }

    @GetMapping(path = "/listar")
    public ResponseEntity<List<Student>> listStudents(Authentication authentication) {
        List<Student> students = this.studentRepository.findAllByActiveFalse();
        return ResponseEntity.ok(students);
    }
}
