package com.likelion.threetier.repository;

import org.springframework.stereotype.Repository;
@Repository
public class DemoRepository {
    private String text;

    DemoRepository() {
        this.text = "Hello World!";
    }

    public String printHelloWorld() {
        return this.text;
    }
}
