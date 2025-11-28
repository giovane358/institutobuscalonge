package br.com.institutobuscalonge.repositories;

import br.com.institutobuscalonge.domain.Instructor;
import br.com.institutobuscalonge.dto.instructor.InstructorDTO;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface InstructorRepository extends JpaRepository<Instructor, Integer> {
    Instructor findByEmail(String email);

    List<Instructor> findAllByCreatedBy_IdAndActiveTrue(UUID createdById);
    List<Instructor> findAllByCreatedBy_IdAndActiveFalse(UUID createdById);
}
