package br.com.institutobuscalonge.repositories;

import br.com.institutobuscalonge.domain.Events;
import br.com.institutobuscalonge.domain.Instructor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface EventsRepository extends JpaRepository<Events, Integer> {

    Events findByTitle(String title);

    List<Events> findAllByCreatedBy_IdAndActiveTrue(UUID createdById);
    List<Events> findAllByCreatedBy_IdAndActiveFalse(UUID createdById);
}