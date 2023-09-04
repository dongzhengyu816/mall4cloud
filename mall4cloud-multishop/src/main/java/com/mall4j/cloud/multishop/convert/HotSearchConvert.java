package com.mall4j.cloud.multishop.convert;

import com.mall4j.cloud.multishop.dto.HotSearchDTO;
import com.mall4j.cloud.multishop.model.HotSearch;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @description:
 * @author: Zhengyu Dong
 * @date: 2023-08-09 11:02
 **/
@Mapper
public interface HotSearchConvert {
    HotSearchConvert INSTANCE = Mappers.getMapper(HotSearchConvert.class);

    HotSearch toHotSearch(HotSearchDTO hotSearchDTO);
}
