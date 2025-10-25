package br.com.institutobuscalonge.domain.user;

public record RegisterDTO(
        String firstName,
        String lastName,
        String email,
        String password,
        String statusUser,
        AuthRole role) {
}
