package com.roomnest.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "rooms")
public class Room {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private Double rent;

    private Double deposit;

    private String city;

    private String area;

    private String address;

    private String roomType;

    private String gender;

    @Column(length = 1000)
    private String description;

    private boolean available = true;

    @ManyToOne
    @JoinColumn(name = "owner_id")
    private User owner;
}
