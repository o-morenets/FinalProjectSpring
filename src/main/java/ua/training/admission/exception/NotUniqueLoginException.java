package ua.training.admission.exception;

import lombok.Getter;
import ua.training.admission.dto.UserSignupDTO;

public class NotUniqueLoginException extends RuntimeException {

    @Getter
    private UserSignupDTO userSignupDTO;

    public NotUniqueLoginException(String message, UserSignupDTO userSignupDTO) {
        super(message);
        this.userSignupDTO = userSignupDTO;
    }
}
