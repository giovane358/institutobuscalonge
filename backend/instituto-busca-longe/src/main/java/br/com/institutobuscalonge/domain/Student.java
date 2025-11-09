package br.com.institutobuscalonge.domain;


import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.Date;

@Entity(name = "student")
@Table(name = "student")
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "ra")
@Getter
@Setter
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ra")
    private int ra;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private  String lastName;

    @Column(name = "birthdate")
    private String birthDate;

    @Column(name = "name_daddy")
    private String nameDaddy;

    @Column(name = "name_mom")
    private String nameMom;

    @Column(name = "contact")
    private String contact;

    @ManyToOne
    @JoinColumn(name = "auth_id")
    private Auth createdBy;

    @Column(name = "active")
    private String active;

    @Column(name = "email")
    private String email;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    public Student(String firstName, String email, String lastName, String birthDate, String nameDaddy, String nameMom, String contact) {
        this.firstName = firstName;
        this.email = email;
        this.lastName = lastName;
        this.birthDate = birthDate;
        this.nameDaddy = nameDaddy;
        this.nameMom = nameMom;
        this.contact = contact;
    }

}
