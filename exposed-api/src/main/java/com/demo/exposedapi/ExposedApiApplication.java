package com.demo.exposedapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * ["com.demo.exposedapi.controller", "com.demo.exposedapi.feign"]
 */
@SpringBootApplication(scanBasePackages = {"com.demo.exposedapi.controller","com.demo.exposedapi.feign"})
@EnableDiscoveryClient
@EnableFeignClients
public class ExposedApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(ExposedApiApplication.class, args);
    }

}
