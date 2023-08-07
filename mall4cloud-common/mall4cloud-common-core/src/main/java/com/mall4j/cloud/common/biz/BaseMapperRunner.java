package com.mall4j.cloud.common.biz;

import cn.dhbin.mapstruct.helper.core.BeanConvertMapper;
import cn.dhbin.mapstruct.helper.core.BeanConvertMappers;
import cn.dhbin.mapstruct.helper.core.MapperConfig;
import cn.dhbin.mapstruct.helper.core.scaner.DefaultMapperDefinitionScanner;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

/**
 * @program: merge.py
 * @description:
 * @author: Zhengyu Dong
 * @create: 2023-07-05 14:59
 **/
@Component
public class BaseMapperRunner implements ApplicationRunner {
    private static final Logger log = LoggerFactory.getLogger(BaseMapperRunner.class);
    @Override
    public void run(ApplicationArguments args) throws Exception {
        log.debug("BaseMapperRunner start");
        try {
            BeanConvertMappers.config(MapperConfig.builder()
                            // 是否支持待复制Bean的子类
                            .supportSubclass(true)
                            // mapper扫描器
                            .mapperDefinitionScanner(new DefaultMapperDefinitionScanner("scanPackage"))
                            // 转换方法
                            .convertFunction((mapper, source) -> {
                                return ((BeanConvertMapper) mapper).to(source);
                            })
                            .build());
            log.debug("BaseMapper build successfully");
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }
}
