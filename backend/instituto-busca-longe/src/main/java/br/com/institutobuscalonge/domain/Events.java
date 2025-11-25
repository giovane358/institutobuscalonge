package br.com.institutobuscalonge.domain;


import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity(name = "events")
@Table(name = "events")
@EqualsAndHashCode( of = "id")
public class Events {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "title")
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "date")
    private Date date;

    @Column(name = "houres")
    private String houres;

    @Column(name = "address")
    private String address;

    @ManyToOne
    @JoinColumn(name = "auth_id")
    private Auth createdBy;

    @Column(name = "active", nullable = false)
    private Boolean active = true;

    @UpdateTimestamp
    @Column(name = "created_at")
    private LocalDateTime created_at;

    public Events(String title, String description, Date date, String houres, String address) {
        this.title = title;
        this.description = description;
        this.date = date;
        this.houres = houres;
        this.address = address;
    }

}
