package br.com.institutobuscalonge.dto;

import java.util.UUID;

public record StudentDTO(String firstName,
                         String lastName,
                         String birthDate,
                         String email,
                         String nameDaddy,
                         String nameMom,
                         String contact) {
}
