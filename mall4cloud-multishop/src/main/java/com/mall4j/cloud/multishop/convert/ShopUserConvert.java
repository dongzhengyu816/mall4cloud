package com.mall4j.cloud.multishop.convert;

import com.mall4j.cloud.multishop.dto.ShopUserDTO;
import com.mall4j.cloud.multishop.model.ShopUser;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @description:
 * @author: Zhengyu Dong
 * @date: 2023-08-09 14:23
 **/
@Mapper
public interface ShopUserConvert {
    ShopUserConvert INSTANCE = Mappers.getMapper(ShopUserConvert.class);

    ShopUser toShopUser(ShopUserDTO shopUserDTO);
}
