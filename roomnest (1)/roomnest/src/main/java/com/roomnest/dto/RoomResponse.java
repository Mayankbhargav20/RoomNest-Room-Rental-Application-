package com.roomnest.dto;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomResponse {

    private Long id;
    private String title;
    private Double rent;
    private Double deposit;
    private String city;
    private String area;
    private String address;
    private String roomType;
    private String gender;
    private String description;
    private Boolean available;

}