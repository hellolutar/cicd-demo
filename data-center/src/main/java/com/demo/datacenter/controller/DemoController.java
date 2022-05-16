package com.demo.datacenter.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

/**
 * Description:
 *
 * @version v1.0
 * @date:2022/5/16
 * @author:qinqy
 */
@RestController
@RequestMapping("demo")
@Slf4j
public class DemoController {

    private ObjectMapper objectMapper = new ObjectMapper();

    @GetMapping("/user/{id}")
    public Object getUserInfo(@PathVariable("id") String id) {
        log.info("/user接口接收请求：id={}", id);

        final HashMap<String, Object> map = new HashMap<>(5);
        map.put("code", 200);
        map.put("data", "{'id':" + id + "'大明'}");
        map.put("trace", "success");

        try {
            log.info("/user接口返回响应：response={}", objectMapper.writeValueAsString(map));
        } catch (JsonProcessingException e) {
            log.error("/user接口返回响应出错:{}", e.toString());
        }

        return map;
    }
}
