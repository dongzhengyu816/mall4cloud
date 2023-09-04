package com.mall4j.cloud.biz.convert;

import com.mall4j.cloud.biz.dto.AttachFileGroupDTO;
import com.mall4j.cloud.biz.model.AttachFileGroup;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @description:
 * @author: Zhengyu Dong
 * @date: 2023-08-08 14:13
 **/
@Mapper
public interface AttachFileGroupConvert {
    AttachFileGroupConvert INSTANCE = Mappers.getMapper(AttachFileGroupConvert.class);

    AttachFileGroupDTO toAttachFileGroupDTO(AttachFileGroup attachFileGroup);

    AttachFileGroup toAttachFileGroup(AttachFileGroupDTO attachFileGroup);
}
