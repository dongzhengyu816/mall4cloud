package com.mall4j.cloud.multishop.convert;

import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @description: 基础转换类
 * @author: Zhengyu Dong
 * @date: 2023-08-08 16:25
 **/
@Mapper
public interface BaseConvert <Source,Target>{
    BaseConvert INSTANCE = Mappers.getMapper(BaseConvert.class);

//    Target toTarget(Source source);
}
