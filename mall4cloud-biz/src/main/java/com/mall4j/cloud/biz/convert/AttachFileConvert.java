package com.mall4j.cloud.biz.convert;


import com.mall4j.cloud.biz.dto.AttachFileDTO;
import com.mall4j.cloud.biz.model.AttachFile;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * @author DZY
 * @date 2020-12-04 16:15:02
 **/

@Mapper
public interface AttachFileConvert {
    AttachFileConvert INSTANCE = Mappers.getMapper(AttachFileConvert.class);

    AttachFileDTO toAttachFileDTO(AttachFile attachFile);

    AttachFile toAttachFile(AttachFileDTO attachFile);

    List<AttachFileDTO> toAttachFileDTOs(List<AttachFile> attachFiles);

    List<AttachFile> toAttachFiles(List<AttachFileDTO> attachFiles);
}
