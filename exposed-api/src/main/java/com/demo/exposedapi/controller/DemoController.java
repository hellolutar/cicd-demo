package com.demo.exposedapi.controller;

import com.demo.exposedapi.feign.DemoFeignClient;
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
public class DemoController {

    @Autowired
    private DemoFeignClient demoFeignClient;


    @GetMapping("/user/{id}")
    public Object getUserInfo(@PathVariable("id") String id) {
        return demoFeignClient.getUser(id);
    }


}
