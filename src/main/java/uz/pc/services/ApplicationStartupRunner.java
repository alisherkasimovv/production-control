package uz.pc.services;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class ApplicationStartupRunner implements CommandLineRunner {

    private final SerialHandler serialHandler;

    public ApplicationStartupRunner(SerialHandler serialHandler) {
        this.serialHandler = serialHandler;
    }

    @Override
    public void run(String... args) throws Exception {
        serialHandler.start();
    }
}
