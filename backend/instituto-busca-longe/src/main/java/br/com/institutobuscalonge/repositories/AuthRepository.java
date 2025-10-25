package br.com.institutobuscalonge.repositories;

import br.com.institutobuscalonge.domain.user.Auth;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.core.userdetails.UserDetails;

public interface AuthRepositories extends JpaRepository<Auth, String> {
    UserDetails findByLogin(String email);
}
