package ua.training.admission.exception;

public class NotUniqueLoginException extends RuntimeException {

    public NotUniqueLoginException(String message) {
        super(message);
    }
}
