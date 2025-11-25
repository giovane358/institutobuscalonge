package br.com.institutobuscalonge.domain;


import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import javax.sound.midi.Sequence;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity(name = "class_room")
@Table(name = "class_room")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@EqualsAndHashCode (of = "id")
public class ClassRoom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "title")
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "capacity")
    private int capacity;

    @Column(name = "duration")
    private int duration;

    @Column(name = "address")
    private String address;

    @Column(name = "level")
    private String level;

    @JoinColumn(name = "id_user")
    @ManyToOne
    private Auth createdBy;

    @JoinColumn(name = "instructor_ri")
    @ManyToOne
    private Instructor instructorBy;

    @Column(name = "active", nullable = false)
    private Boolean active = true;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    public ClassRoom(String title, String description, int capacity, int duration, String address, String level) {
        this.title = title;
        this.description = description;
        this.capacity = capacity;
        this.duration = duration;
        this.address = address;
        this.level = level;
    }
}
