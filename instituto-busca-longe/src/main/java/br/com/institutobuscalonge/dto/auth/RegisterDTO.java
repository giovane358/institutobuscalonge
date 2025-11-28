package br.com.institutobuscalonge.dto.auth;

import br.com.institutobuscalonge.enums.AuthRole;

public record RegisterDTO(
        String firstName,
        String lastName,
        String email,
        String password,
        AuthRole role) {
}
