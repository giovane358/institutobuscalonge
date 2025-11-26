package br.com.institutobuscalonge.dto.classRoom;

public record ClassRoomUpdateDTO(Integer id, String title, String description, int capacity, int duration, String address, String level) {
}
