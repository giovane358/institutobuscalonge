package br.com.institutobuscalonge.dto.events;

import java.util.Date;

public record EventesUpdateDTO(Integer id, String title, String description, Date date, String houres, String address) {
}
