package ua.training.admission.exception;

import lombok.Getter;
import ua.training.admission.dto.UserLoginDTO;

public class EmailNotExistsException extends RuntimeException {

    @Getter
    private UserLoginDTO userLoginDTO;

    public EmailNotExistsException(String message, UserLoginDTO userLoginDTO) {
        super(message);
        this.userLoginDTO = userLoginDTO;
    }
}
