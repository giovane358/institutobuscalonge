package br.com.institutobuscalonge.repositories;

import br.com.institutobuscalonge.domain.Student;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StudentRepository extends JpaRepository<Student, String>{
    List<Student> findAllByActiveTrue();
    List<Student> findAllByActiveFalse();
    Student findByEmail(String email);
}
