package com.demo.datacenter.controller;

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
public class DemoController {

    @GetMapping("/user/{id}")
    public Object getUserInfo(@PathVariable("id") String id) {
        final HashMap<String, Object> map = new HashMap<>(5);
        map.put("code", 200);
        map.put("data", "{\"id\":" + id + "+,\"大明\"}");
        map.put("trace", "success");
        return map;
    }
}
