package br.com.institutobuscalonge.controller;


import br.com.institutobuscalonge.domain.Auth;
import br.com.institutobuscalonge.domain.ClassRoom;
import br.com.institutobuscalonge.domain.Events;
import br.com.institutobuscalonge.domain.Instructor;
import br.com.institutobuscalonge.dto.classRoom.ClassRoomDTO;
import br.com.institutobuscalonge.dto.events.EventsDTO;
import br.com.institutobuscalonge.repositories.ClassRoomRepository;
import br.com.institutobuscalonge.repositories.InstructorRepository;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/classRoom")
@Tag(name = "ClassRoom", description = "Controller de ClassRoom")
@SecurityRequirement(name = "BearerAuth")
public class ClassRoomController {
    @Autowired
    ClassRoomRepository classRoomRepository;

    @Autowired
    InstructorRepository instructorRepository;

    @PostMapping(path = "/register", consumes = MediaType.APPLICATION_JSON_VALUE)
    @Operation(summary = "Realizar o cadastro", description = "Realizar a verificação se tem usuário com os mesmo dados cadastrado no sistema...")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<ClassRoom> registerEvent(Authentication authentication, @RequestBody @Valid ClassRoomDTO data) {

        // pegar auth do Authentication
        Auth user = null;

        if (authentication != null  && authentication.getPrincipal() instanceof Auth) {
            user = (Auth) authentication.getPrincipal();
        }

        if (this.classRoomRepository.findByTitle(data.title()) != null){
            return  ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        ClassRoom classRoom = new ClassRoom(data.title(), data.description(), data.capacity(), data.duration(), data.address(), data.level());

        if (user != null){
            classRoom.setCreatedBy(user);
        }

        if (data.setInstructorBy() != null) {
            // busca instructor por id (UUID)
            Instructor instructor = instructorRepository.findById(data.setInstructorBy()).orElse(null);
            if (instructor == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // instructor não encontrado
            }

            // opcional: garantir que o instrutor pertence ao mesmo usuário criador
            if (user != null && (instructor.getCreatedBy() == null || !instructor.getCreatedBy().getId().equals(user.getId()))) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build(); // não pode usar instructor de outro usuário
            }

            classRoom.setInstructorBy(instructor);
        }

        classRoomRepository.save(classRoom);

        return ResponseEntity.ok(classRoom);
    }

}
