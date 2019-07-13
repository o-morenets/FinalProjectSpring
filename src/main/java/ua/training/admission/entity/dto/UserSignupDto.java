package ua.training.admission.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserSignupDto {

    private String username;
    private String password;
    private String password2;
    private String email;
    private String firstName;
    private String lastName;
}