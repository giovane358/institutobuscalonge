package br.com.institutobuscalonge.controller;


import br.com.institutobuscalonge.domain.Auth;
import br.com.institutobuscalonge.domain.ClassRoom;
import br.com.institutobuscalonge.domain.Events;
import br.com.institutobuscalonge.domain.Instructor;
import br.com.institutobuscalonge.dto.classRoom.ClassRoomDTO;
import br.com.institutobuscalonge.dto.classRoom.ClassRoomDeleteDTO;
import br.com.institutobuscalonge.dto.classRoom.ClassRoomUpdateDTO;
import br.com.institutobuscalonge.dto.events.EventsDTO;
import br.com.institutobuscalonge.dto.events.EventsDeleteDTO;
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
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/classRoom")
@Tag(name = "ClassRoom", description = "Observação: esses endpoints exigem autenticação. Algumas operações (ex.: delete, update) podem exigir a role ADMIN ou INSTRUCTOR_MANAGER")
@SecurityRequirement(name = "BearerAuth")
public class ClassRoomController {
    @Autowired
    ClassRoomRepository classRoomRepository;

    @Autowired
    InstructorRepository instructorRepository;

    @PostMapping(path = "/register", consumes = MediaType.APPLICATION_JSON_VALUE)
    @Operation(summary = "Realizar o cadastro", description = "Cadastra uma nova sala no sistema.")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<ClassRoom> registerClassRoom(Authentication authentication, @RequestBody @Valid ClassRoomDTO data) {

        // pegar auth
        Auth user = null;

        // Pegar o UUID do Auth
        if (authentication != null  && authentication.getPrincipal() instanceof Auth) {
            user = (Auth) authentication.getPrincipal();
        }

        // Verifica se não tem sala com o mesmo titulo
        if (this.classRoomRepository.findByTitle(data.title()) != null){
            return  ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        // Passo os json do ClassRoom
        ClassRoom classRoom = new ClassRoom(data.title(), data.description(), data.capacity(), data.duration(), data.address(), data.level());

        // Defino o UUID do Auth no createdBy, indentificando que a sala e do Auth locado
        if (user != null){
            classRoom.setCreatedBy(user);
        }

        // verifiqca se o Instrutor e igual ou diferente de null
        if (data.setInstructorBy() != null) {

            // busca instructor pelo ri passado no JSON
            Instructor instructor = instructorRepository.findById(data.setInstructorBy()).orElse(null);

            // verifca se o ri e nulo
            if (instructor == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // instructor não encontrado
            }

            // Verifica se instrutor pertence ao mesmo usuário criador
            if (user != null && (instructor.getCreatedBy() == null || !instructor.getCreatedBy().getId().equals(user.getId()))) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build(); // não pode usar instructor de outro usuário
            }

            // Salvo o ri no instructorBy
            classRoom.setInstructorBy(instructor);
        }

        classRoomRepository.save(classRoom);

        return ResponseEntity.ok(classRoom);
    }

    @GetMapping(path = "/list/enable")
    @Operation(summary = "Listar salas habilitadas", description = "Retorna todas as salas com enabled = true.")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<List<ClassRoom>> ReadEnable (Authentication authentication){

        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Auth auth  = (Auth) authentication.getPrincipal();
        UUID userId = auth.getId();

        List<ClassRoom> classRoomsList = this.classRoomRepository.findAllByCreatedBy_IdAndActiveTrue(userId);

        return ResponseEntity.ok(classRoomsList);
    }

    @GetMapping(path = "/List/disnable")
    @Operation(summary = "Listar salas desabilitadas", description = "Retorna salas desabilitadas.")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<List<ClassRoom>> readDisnable (Authentication authentication){

        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Auth auth  = (Auth) authentication.getPrincipal();
        UUID userId = auth.getId();

        List<ClassRoom> classRoomsList = this.classRoomRepository.findAllByCreatedBy_IdAndActiveFalse(userId);

        return ResponseEntity.ok(classRoomsList);
    }

    @PutMapping(path = "/update")
    @Operation(summary = "Atualizar sala", description = "Atualiza os dados de uma sala (nome, capacidade, recursos...).")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<ClassRoom> updateClassRoom (Authentication authentication, @RequestBody @Valid ClassRoomUpdateDTO data){

        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Auth auth  = (Auth) authentication.getPrincipal();
        UUID userId = auth.getId();

        ClassRoom classRoom = classRoomRepository.findById(data.id()).orElse(null);

        if (classRoom == null){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        if (classRoom.getCreatedBy() == null || !classRoom.getCreatedBy().getId().equals(userId)){
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        classRoom.setId(data.id());
        classRoom.setTitle(data.title());
        classRoom.setDescription(data.description());
        classRoom.setCapacity(data.capacity());
        classRoom.setDuration(data.duration());
        classRoom.setAddress(data.address());
        classRoom.setLevel(data.level());
        classRoomRepository.save(classRoom);

        return ResponseEntity.ok(classRoom);
    }

    @DeleteMapping(path = "/delet")
    @Operation(summary = "Deletar sala", description = "Remove ou desabilita uma sala por id.", method = "Delet")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<ClassRoom> deletClassRoom(Authentication authentication, @RequestBody @Valid ClassRoomDeleteDTO data){
        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        Auth authUser = (Auth) authentication.getPrincipal();
        UUID userId = authUser.getId();

        ClassRoom classRoom = classRoomRepository.findById(data.id()).orElse( null);

        if (classRoom == null){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        if (classRoom.getCreatedBy() == null || !classRoom.getCreatedBy().getId().equals(userId)){
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        classRoom.setActive(false);
        classRoomRepository.save(classRoom);
        return ResponseEntity.ok(classRoom);

    }
}
