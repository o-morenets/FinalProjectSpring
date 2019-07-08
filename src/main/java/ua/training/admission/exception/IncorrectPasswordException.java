package ua.training.admission.exception;

import lombok.Getter;
import ua.training.admission.dto.UserLoginDTO;

public class IncorrectPasswordException extends RuntimeException {

    @Getter
    private UserLoginDTO userLoginDTO;

    public IncorrectPasswordException(String message, UserLoginDTO userLoginDTO) {
        super(message);
        this.userLoginDTO = userLoginDTO;
    }
}
