package br.com.institutobuscalonge.controller;


import br.com.institutobuscalonge.domain.Auth;
import br.com.institutobuscalonge.domain.Events;
import br.com.institutobuscalonge.domain.Instructor;
import br.com.institutobuscalonge.dto.events.EventesUpdateDTO;
import br.com.institutobuscalonge.dto.events.EventsDTO;
import br.com.institutobuscalonge.dto.events.EventsDeleteDTO;
import br.com.institutobuscalonge.dto.instructor.InstructorDeleteDTO;
import br.com.institutobuscalonge.dto.instructor.InstructorUpdateDTO;
import br.com.institutobuscalonge.repositories.EventsRepository;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;


@RestController
@RequestMapping("/events")
@Tag(name = "Eventos", description = "Controller de Eventos")
@SecurityRequirement(name = "BearerAuth")
public class EventsController {

    @Autowired
    private EventsRepository eventsRepository;

    @PostMapping(path = "/register", consumes = MediaType.APPLICATION_JSON_VALUE)
    @Operation(summary = "Realizar o cadastro", description = "Realizar a verificação se tem usuário com os mesmo dados cadastrado no sistema...")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<?> registerEvent(Authentication authentication, @RequestBody @Valid EventsDTO data) {

        // pegar auth do Authentication
        Auth user = null;

        if (authentication != null  && authentication.getPrincipal() instanceof Auth) {
            user = (Auth) authentication.getPrincipal();
        }

        if (this.eventsRepository.findByTitle(data.title()) != null){
            return  ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        Events events = new Events(data.title(), data.description(), data.date(), data.houres(), data.address());

        if (user != null){
            events.setCreatedBy(user);
        }

        eventsRepository.save(events);

        return ResponseEntity.ok(events);
    }

    @GetMapping(path = "/listar/enable")
    @Operation(summary = "Listar Instrutores", description = "Realiza a listagem dos instrutores registrado do usuário logado", method = "POST")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<List<Events>> getEventsEnable(Authentication authentication){

        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Auth auth = (Auth) authentication.getPrincipal();
        UUID userId = auth.getId();

        List<Events> events = this.eventsRepository.findAllByCreatedBy_IdAndActiveTrue(userId);

        return ResponseEntity.ok(events);
    }

    @GetMapping(path = "/listar/disabled")
    @Operation(summary = "Listar Instrutores", description = "Realiza a listagem dos instrutores registrado do usuário logado", method = "POST")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<List<Events>> getInscrutorDisabled(Authentication authentication){

        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Auth auth = (Auth) authentication.getPrincipal();
        UUID userId = auth.getId();

        List<Events> events = this.eventsRepository.findAllByCreatedBy_IdAndActiveFalse(userId);

        return ResponseEntity.ok(events);
    }

    @DeleteMapping(path = "/delete")
    @Operation(summary = "Deletar", description = "Realiza a listagem dos instrutores registrado do usuário logado", method = "POST")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<Events> deleteInstructor(Authentication authentication, @RequestBody @Valid EventsDeleteDTO data){
        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        Auth authUser = (Auth) authentication.getPrincipal();
        UUID userId = authUser.getId();

        Events events = eventsRepository.findById(data.id()).orElse( null);

        if (events == null){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        if (events.getCreatedBy() == null || !events.getCreatedBy().getId().equals(userId)){
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        events.setActive(false);
        eventsRepository.save(events);
        return ResponseEntity.ok(events);

    }

    @PutMapping("/update")
    @Operation(summary = "Atualizar dados do instructor", description = "Esse metodo realizar atualização no cadstro no instrutor", method = "PUT")
    @ApiResponse(responseCode = "200", description = "Login realizado com sucesso")
    @ApiResponse(responseCode = "400", description = "Não foi possível processar a sua solicitação")
    @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    @ApiResponse(responseCode = "403", description = "Acesso negado")
    @ApiResponse(responseCode = "401", description = "Dados incorretos")
    public ResponseEntity<Events> updateInstructor(Authentication authentication, @RequestBody @Valid EventesUpdateDTO data){

        // pega Auth do Authentication (se presente)
        if (authentication == null || !(authentication.getPrincipal() instanceof Auth)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        Auth authUser = (Auth) authentication.getPrincipal();
        UUID userId = authUser.getId();

        Events events = eventsRepository.findById(data.id()).orElse(null);

        if (events == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        // Verifica se o estudante pertence ao usuário logado
        if (events.getCreatedBy() == null || !events.getCreatedBy().getId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        events.setId(data.id());
        events.setTitle(data.title());
        events.setDescription(data.description());
        eventsRepository.save(events);
        return ResponseEntity.ok(events);
    }

}
