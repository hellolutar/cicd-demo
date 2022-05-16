package com.demo.exposedapi.controller;

import com.demo.exposedapi.feign.DemoFeignClient;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Description:
 *
 * @version v1.0
 * @date:2022/5/16
 * @author:qinqy
 */
@RequestMapping("/demo")
@RestController
@Slf4j
public class DemoController {

    @Autowired
    private DemoFeignClient demoFeignClient;

    private ObjectMapper objectMapper =new ObjectMapper();


    @GetMapping("/user/{id}")
    public Object getUserInfo(@PathVariable("id") String id) {
        log.info("/user接口接收请求：id={}", id);

        final Object response = demoFeignClient.getUser(id);

        try {
            log.info("/user接口返回响应：response={}", objectMapper.writeValueAsString(response));
        } catch (JsonProcessingException e) {
            log.error("/user接口返回响应出错:{}", e.toString());
        }

        return response;
    }


}
