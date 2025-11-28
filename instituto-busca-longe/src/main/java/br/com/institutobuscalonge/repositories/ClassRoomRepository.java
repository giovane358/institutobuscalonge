package br.com.institutobuscalonge.repositories;

import br.com.institutobuscalonge.domain.ClassRoom;
import br.com.institutobuscalonge.domain.Events;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.support.JpaEntityInformation;

import java.util.List;
import java.util.UUID;

public interface ClassRoomRepository extends JpaRepository<ClassRoom, Integer> {

    ClassRoom findByTitle(String title);
    ClassRoom findById(int id);
    List<ClassRoom> findAllByCreatedBy_IdAndActiveTrue(UUID createdById);
    List<ClassRoom> findAllByCreatedBy_IdAndActiveFalse(UUID createdById);


}
