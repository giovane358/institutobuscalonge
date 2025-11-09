package br.com.institutobuscalonge;

import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class InstitutoBuscaLongeApplication {

    public static void main(String[] args) {
       // Dotenv dotenv = Dotenv.load(); // Biblioteca do Dorenv,
        // dotenv.entries().forEach(enty -> System.setProperty(enty.getKey(), enty.getValue()));

        SpringApplication.run(InstitutoBuscaLongeApplication.class, args);
    }

}
