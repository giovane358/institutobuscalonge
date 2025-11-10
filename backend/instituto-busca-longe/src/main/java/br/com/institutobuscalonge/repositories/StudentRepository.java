package br.com.institutobuscalonge.repositories;

import br.com.institutobuscalonge.domain.Student;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface StudentRepository extends JpaRepository<Student, Integer> { // PK é int

    Student findByEmail(String email);

    List<Student> findAllByCreatedBy_IdAndActiveTrue(UUID createdById);
    List<Student> findAllByCreatedBy_IdAndActiveFalse(UUID createdById);

}
