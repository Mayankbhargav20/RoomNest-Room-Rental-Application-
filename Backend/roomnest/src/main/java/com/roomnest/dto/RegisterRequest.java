package com.roomnest.dto;

import com.roomnest.enums.Role;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RegisterRequest {

    private String name;
    private String email;
    private String phone;
    private String password;
    private Role role;

}