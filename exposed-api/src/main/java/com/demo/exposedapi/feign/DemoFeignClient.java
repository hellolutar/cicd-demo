package com.demo.exposedapi.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * Description:
 *
 * @version v1.0
 * @date:2022/5/16
 * @author:qinqy
 */
@FeignClient(value = "data-center",path = "demo")
public interface DemoFeignClient {


    @GetMapping("/user/{id}")
    Object getUser(@PathVariable("id") String id);


}
