package com.mall4j.cloud.multishop.convert;

import com.mall4j.cloud.multishop.dto.ShopDetailDTO;
import com.mall4j.cloud.multishop.model.ShopDetail;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @description: ShopDetail
 * @author: Zhengyu Dong
 * @date: 2023-08-09 10:57
 **/
@Mapper
public interface ShopDetailConvert {
    ShopDetailConvert INSTANCE = Mappers.getMapper(ShopDetailConvert.class);

    ShopDetail toShopDetail(ShopDetailDTO shopDetailDTO);
}
