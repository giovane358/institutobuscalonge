package br.com.institutobuscalonge.repositories;

import br.com.institutobuscalonge.domain.Auth;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthRepository extends JpaRepository<Auth, String> {
    Auth findByEmail(String email);
}
