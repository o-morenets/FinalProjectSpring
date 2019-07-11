package ua.training.admission.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserSignupDto {
    private String firstName;
    private String lastName;
    private String username;
    private String password;
    private String password2;
}
