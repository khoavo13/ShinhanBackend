package com.likelion.threetier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.likelion.threetier.service.DemoService;

@RestController
public class DemoController {
    @Autowired
    private DemoService demoService;

    @GetMapping(value = "/")
    public String getDemo() {
        return demoService.printHelloWorld();
    }
}
