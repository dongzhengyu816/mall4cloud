package com.mall4j.cloud.rbac.convert;

import com.mall4j.cloud.rbac.dto.RoleDTO;
import com.mall4j.cloud.rbac.model.Role;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @description:
 * @author: Zhengyu Dong
 * @date: 2023-08-09 21:59
 **/
@Mapper
public interface RoleConvert {
    RoleConvert INSTANCE = Mappers.getMapper(RoleConvert.class);

    Role toRole(RoleDTO roleDTO);
}
