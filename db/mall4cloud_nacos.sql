/*
 Navicat Premium Data Transfer

 Source Server         : 111.229.36.14
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 111.229.36.14:3306
 Source Schema         : mall4cloud_nacos

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 08/08/2023 10:09:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `shop_id` bigint UNSIGNED NOT NULL COMMENT '店铺id',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类描述',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类地址{parent_id}-{child_id},...',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态 1:enable, 0:disable, -1:deleted',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类图标',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类的显示图片',
  `level` int NOT NULL COMMENT '分类层级 从0开始',
  `seq` int NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `idx_shop_id`(`shop_id`) USING BTREE,
  INDEX `idx_pid`(`parent_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for category_brand
-- ----------------------------
DROP TABLE IF EXISTS `category_brand`;
CREATE TABLE `category_brand`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `brand_id` bigint UNSIGNED NOT NULL COMMENT '品牌id',
  `category_id` bigint UNSIGNED NOT NULL COMMENT '分类id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_brand_category_id`(`brand_id`, `category_id`) USING BTREE,
  INDEX `idx_category_id`(`category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '品牌分类关联信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category_brand
-- ----------------------------

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4126 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (2, 'application-dev.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  #避免nacos取网卡出错\n  cloud:\n    inetutils:\n      preferred-networks: 192.168.1\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    type: com.zaxxer.hikari.HikariDataSource\n    hikari:\n      minimum-idle: 0\n      maximum-pool-size: 20\n      idle-timeout: 25000\n      auto-commit: true\n      connection-test-query: SELECT 1\n  redis:\n    host: 111.229.36.14\n    password: stip@2022\n  jackson:\n    date-format: yyyy-MM-dd HH:mm:ss\n    time-zone: GMT+8\n      \n#mybatis的相关配置\nmybatis:\n  #mapper配置文件\n  mapper-locations: classpath:mapper/*Mapper.xml\n  type-aliases-package: com.mall4j.cloud.**.model\n  #开启驼峰命名\n  configuration:\n    map-underscore-to-camel-case: true\n\nseata:\n  enableAutoDataSourceProxy: false\n  config:\n    type: nacos\n    nacos:\n      namespace: 4b70485d-72dd-44df-a76a-7a3f578a3001\n      dataId: \"seataServer.properties\"\n      server-addr: ${spring.cloud.nacos.discovery.server-addr}\n      password: ${spring.cloud.nacos.discovery.password}\n      username: ${spring.cloud.nacos.discovery.username}\n  registry:\n    type: nacos\n    nacos:\n      server-addr: ${spring.cloud.nacos.discovery.server-addr}\n      password: ${spring.cloud.nacos.discovery.password}\n      username: ${spring.cloud.nacos.discovery.username}\n      namespace: ${seata.config.nacos.namespace}\n\nlogging:\n  level:\n    root: info\n    com:\n      mall4cloud:\n        shop: debug\n# 分页合理化，当查询到页码大于最后一页的时候，返回最后一页的数据，防止vue在最后一页删除时，数据不对的问题\npagehelper:\n  reasonable: true\n\nbiz:\n  oss:\n    # resources-url是带有bucket的\n    resources-url: http://111.229.36.14:9000/mall4cloud\n    type: 1\n    endpoint: http://111.229.36.14:9000\n    bucket: mall4cloud\n    access-key-id: admin\n    access-key-secret: admin123456\n\nfeign:\n  client:\n    config:\n      default:\n        connectTimeout: 5000\n        readTimeout: 5000\n        loggerLevel: basic\n  inside:\n    key: mall4cloud-feign-inside-key\n    secret: mall4cloud-feign-inside-secret\n    # ip白名单，如果有需要的话，用小写逗号分割\n    ips: \n\nmall4cloud:\n  job:\n    accessToken:\n    admin:\n      addresses: http://111.229.36.14:8999\n\nrocketmq:\n  name-server: 111.229.36.14:9876', '1bcc577f061637da6feb89a991d7d3b0', '2020-09-07 05:54:23', '2023-08-08 10:03:33', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (8, 'mall4cloud-auth.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_auth}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}\n\n# 用于token aes签名的key，16位\nauth:\n  token:\n    signKey: -mall4cloud-mall ', 'f619b10fe179c82db393e05c4e267978', '2020-09-07 06:05:57', '2023-08-08 10:06:51', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (13, 'mall4cloud-multishop.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_multishop}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}', 'e5850de41772ac74d5fd17c0228c5388', '2020-09-07 06:38:01', '2023-08-08 10:07:05', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (16, 'mall4cloud-leaf.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_leaf}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}', '4415b706e4e2e61737996c55700da755', '2020-09-07 06:44:22', '2023-08-08 09:58:35', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (18, 'mall4cloud-rbac.yml', 'DEFAULT_GROUP', 'spring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_rbac}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}\n', 'bcc8df4645ead67d1b324285649a258c', '2020-09-07 06:47:49', '2023-08-08 10:07:19', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (31, 'mall4cloud-biz.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_biz}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}\n\nbiz:\n  oss:\n    # resources-url是带有bucket的\n    resources-url: http://111.229.36.14:9000/mall4cloud\n    # 文件上传类型 0.阿里云 1.minio\n    type: 1\n    endpoint: http://111.229.36.14:9000\n    bucket: mall4cloud\n    access-key-id: admin\n    access-key-secret: admin123456', 'fb591a3717a453528911f3624c88378b', '2020-09-10 07:26:09', '2023-08-08 10:07:32', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (72, 'mall4cloud-product.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_product}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}', 'add6317521f9bf7e8b0f448c5deaa868', '2020-11-11 09:35:20', '2023-08-08 10:07:46', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (73, 'mall4cloud-search.yml', 'DEFAULT_GROUP', 'elastic:\n  # elastic的地址\n  address: http://111.229.36.14:9200', '0e8ea5c03a559a26407a21e0efcc6a97', '2020-11-12 06:57:25', '2021-04-02 15:13:25', NULL, '', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (84, 'mall4cloud-gateway.yml', 'DEFAULT_GROUP', 'spring:\n  cloud:\n    gateway:\n      globalcors:\n        cors-configurations:\n          \'[/**]\':\n            allow-credentials: true\n            allowed-headers: \"*\"\n            # 半个月内都允许\n            max-age: 1296000\n            # 测试环境，全部允许\n            allowedOriginPatterns: \"*\"\n            # allowedOrigins:\n              # - \"http://localhost:9527\"\n              # - \"http://localhost:9527\"\n              # - \"http://localhost:9528\"\n              # - \"http://localhost:9529\"\n              # - \"http://:9527\"\n            allowedMethods:\n              - GET\n              - POST\n              - PUT\n              - OPTIONS\n              - DELETE\n      discovery:\n        locator:\n          # 开启服务注册和发现\n          enabled: true\n          # 不手动写路由的话，swagger整合不了...\n      routes:\n        - id: mall4cloud-rbac\n          uri: lb://mall4cloud-rbac\n          predicates:\n            - Path=/mall4cloud_rbac/**\n          filters:\n            - RewritePath=/mall4cloud_rbac(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-auth\n          uri: lb://mall4cloud-auth\n          predicates:\n            - Path=/mall4cloud_auth/**\n          filters:\n            - RewritePath=/mall4cloud_auth(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-multishop\n          uri: lb://mall4cloud-multishop\n          predicates:\n            - Path=/mall4cloud_multishop/**\n          filters:\n            - RewritePath=/mall4cloud_multishop(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-biz\n          uri: lb://mall4cloud-biz\n          predicates:\n            - Path=/mall4cloud_biz/**\n          filters:\n            - RewritePath=/mall4cloud_biz(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-product\n          uri: lb://mall4cloud-product\n          predicates:\n            - Path=/mall4cloud_product/**\n          filters:\n            - RewritePath=/mall4cloud_product(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-user\n          uri: lb://mall4cloud-user\n          predicates:\n            - Path=/mall4cloud_user/**\n          filters:\n            - RewritePath=/mall4cloud_user(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-order\n          uri: lb://mall4cloud-order\n          predicates:\n            - Path=/mall4cloud_order/**\n          filters:\n            - RewritePath=/mall4cloud_order(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-delivery\n          uri: lb://mall4cloud-delivery\n          predicates:\n            - Path=/mall4cloud_delivery/**\n          filters:\n            - RewritePath=/mall4cloud_delivery(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-discount\n          uri: lb://mall4cloud-discount\n          predicates:\n            - Path=/mall4cloud_discount/**\n          filters:\n            - RewritePath=/mall4cloud_discount(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-platform\n          uri: lb://mall4cloud-platform\n          predicates:\n            - Path=/mall4cloud_platform/**\n          filters:\n            - RewritePath=/mall4cloud_platform(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-search\n          uri: lb://mall4cloud-search\n          predicates:\n            - Path=/mall4cloud_search/**\n          filters:\n            - RewritePath=/mall4cloud_search(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-coupon\n          uri: lb://mall4cloud-coupon\n          predicates:\n            - Path=/mall4cloud_coupon/**\n          filters:\n            - RewritePath=/mall4cloud_coupon(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-payment\n          uri: lb://mall4cloud-payment\n          predicates:\n            - Path=/mall4cloud_payment/**\n          filters:\n            - RewritePath=/mall4cloud_payment(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-group\n          uri: lb://mall4cloud-group\n          predicates:\n            - Path=/mall4cloud_group/**\n          filters:\n            - RewritePath=/mall4cloud_group(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-seckill\n          uri: lb://mall4cloud-seckill\n          predicates:\n            - Path=/mall4cloud_seckill/**\n          filters:\n            - RewritePath=/mall4cloud_seckill(?<segment>/?.*), $\\{segment}\n        - id: mall4cloud-flow\n          uri: lb://mall4cloud-flow\n          predicates:\n            - Path=/mall4cloud_flow/**\n          filters:\n            - RewritePath=/mall4cloud_flow(?<segment>/?.*), $\\{segment}', '256d52ff10bd08ebf1cb45b6c9a2c8e2', '2020-11-19 06:49:26', '2021-05-21 07:27:40', NULL, '', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (3727, 'mall4cloud-order.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_order}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}', '8dfc51f5b1f55998d0fe8935c7cdb34e', '2020-12-04 05:45:13', '2023-08-08 10:08:06', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (3736, 'mall4cloud-user.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_user}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}', '3f596b87707230d9f3f7eedfe6e1e150', '2020-12-04 05:51:25', '2023-08-08 10:08:20', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (3759, 'mall4cloud-platform.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_platform}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}', 'eceec361ccc003a15ab50eca015c88da', '2020-12-21 07:38:16', '2023-08-08 10:08:34', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (3812, 'mall4cloud-payment.yml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_payment}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:stip@2022}\napplication:\n  domainUrl: http://47.112.182.96:8126/mall4cloud_payment', '6877b1df76fd259fb6c24ba6bf54a155', '2021-02-03 03:19:16', '2023-08-08 10:08:48', 'nacos', '39.144.218.198', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (4125, 'seataServer.properties', 'SEATA_GROUP', '#For details about configuration items, see https://seata.io/zh-cn/docs/user/configurations.html\r\n#Transport configuration, for client and server\r\ntransport.type=TCP\r\ntransport.server=NIO\r\ntransport.heartbeat=true\r\ntransport.enableTmClientBatchSendRequest=false\r\ntransport.enableRmClientBatchSendRequest=true\r\ntransport.enableTcServerBatchSendResponse=false\r\ntransport.rpcRmRequestTimeout=30000\r\ntransport.rpcTmRequestTimeout=30000\r\ntransport.rpcTcRequestTimeout=30000\r\ntransport.threadFactory.bossThreadPrefix=NettyBoss\r\ntransport.threadFactory.workerThreadPrefix=NettyServerNIOWorker\r\ntransport.threadFactory.serverExecutorThreadPrefix=NettyServerBizHandler\r\ntransport.threadFactory.shareBossWorker=false\r\ntransport.threadFactory.clientSelectorThreadPrefix=NettyClientSelector\r\ntransport.threadFactory.clientSelectorThreadSize=1\r\ntransport.threadFactory.clientWorkerThreadPrefix=NettyClientWorkerThread\r\ntransport.threadFactory.bossThreadSize=1\r\ntransport.threadFactory.workerThreadSize=default\r\ntransport.shutdown.wait=3\r\ntransport.serialization=seata\r\ntransport.compressor=none\r\n\r\n#Transaction routing rules configuration, only for the client\r\nservice.vgroupMapping.default_tx_group=default\r\n#If you use a registry, you can ignore it\r\nservice.default.grouplist=10.1.76.38:8091\r\nservice.enableDegrade=false\r\nservice.disableGlobalTransaction=false\r\n\r\n#Transaction rule configuration, only for the client\r\nclient.rm.asyncCommitBufferLimit=10000\r\nclient.rm.lock.retryInterval=10\r\nclient.rm.lock.retryTimes=30\r\nclient.rm.lock.retryPolicyBranchRollbackOnConflict=true\r\nclient.rm.reportRetryCount=5\r\nclient.rm.tableMetaCheckEnable=true\r\nclient.rm.tableMetaCheckerInterval=60000\r\nclient.rm.sqlParserType=druid\r\nclient.rm.reportSuccessEnable=false\r\nclient.rm.sagaBranchRegisterEnable=false\r\nclient.rm.sagaJsonParser=fastjson\r\nclient.rm.tccActionInterceptorOrder=-2147482648\r\nclient.tm.commitRetryCount=5\r\nclient.tm.rollbackRetryCount=5\r\nclient.tm.defaultGlobalTransactionTimeout=60000\r\nclient.tm.degradeCheck=false\r\nclient.tm.degradeCheckAllowTimes=10\r\nclient.tm.degradeCheckPeriod=2000\r\nclient.tm.interceptorOrder=-2147482648\r\nclient.undo.dataValidation=true\r\nclient.undo.logSerialization=jackson\r\nclient.undo.onlyCareUpdateColumns=true\r\nserver.undo.logSaveDays=7\r\nserver.undo.logDeletePeriod=86400000\r\nclient.undo.logTable=undo_log\r\nclient.undo.compress.enable=true\r\nclient.undo.compress.type=zip\r\nclient.undo.compress.threshold=64k\r\n#For TCC transaction mode\r\ntcc.fence.logTableName=tcc_fence_log\r\ntcc.fence.cleanPeriod=1h\r\n\r\n#Log rule configuration, for client and server\r\nlog.exceptionRate=100\r\n\r\n#Transaction storage configuration, only for the server. The file, DB, and redis configuration values are optional.\r\nstore.mode=DB\r\nstore.lock.mode=DB\r\nstore.session.mode=DB\r\n#Used for password encryption\r\nstore.publicKey=\r\n\r\n#If `store.mode,store.lock.mode,store.session.mode` are not equal to `file`, you can remove the configuration block.\r\nstore.file.dir=file_store/data\r\nstore.file.maxBranchSessionSize=16384\r\nstore.file.maxGlobalSessionSize=512\r\nstore.file.fileWriteBufferCacheSize=16384\r\nstore.file.flushDiskMode=async\r\nstore.file.sessionReloadReadSize=100\r\n\r\n#These configurations are required if the `store mode` is `db`. If `store.mode,store.lock.mode,store.session.mode` are not equal to `db`, you can remove the configuration block.\r\nstore.db.datasource=druid\r\nstore.db.dbType=mysql\r\nstore.db.driverClassName=com.mysql.jdbc.Driver\r\nstore.db.url=jdbc:mysql://111.229.36.14:3306/mall4cloud_seata?useUnicode=true&rewriteBatchedStatements=true\r\nstore.db.user=root\r\nstore.db.password=root\r\nstore.db.minConn=5\r\nstore.db.maxConn=30\r\nstore.db.globalTable=global_table\r\nstore.db.branchTable=branch_table\r\nstore.db.distributedLockTable=distributed_lock\r\nstore.db.queryLimit=100\r\nstore.db.lockTable=lock_table\r\nstore.db.maxWait=5000\r\n\r\n#These configurations are required if the `store mode` is `redis`. If `store.mode,store.lock.mode,store.session.mode` are not equal to `redis`, you can remove the configuration block.\r\nstore.redis.mode=single\r\nstore.redis.single.host=192.168.1.10\r\nstore.redis.single.port=6379\r\nstore.redis.sentinel.masterName=\r\nstore.redis.sentinel.sentinelHosts=\r\nstore.redis.maxConn=10\r\nstore.redis.minConn=1\r\nstore.redis.maxTotal=100\r\nstore.redis.database=0\r\nstore.redis.password=\r\nstore.redis.queryLimit=100\r\n\r\n#Transaction rule configuration, only for the server\r\nserver.recovery.committingRetryPeriod=1000\r\nserver.recovery.asynCommittingRetryPeriod=1000\r\nserver.recovery.rollbackingRetryPeriod=1000\r\nserver.recovery.timeoutRetryPeriod=1000\r\nserver.maxCommitRetryTimeout=-1\r\nserver.maxRollbackRetryTimeout=-1\r\nserver.rollbackRetryTimeoutUnlockEnable=false\r\nserver.distributedLockExpireTime=10000\r\nserver.xaerNotaRetryTimeout=60000\r\nserver.session.branchAsyncQueueSize=5000\r\nserver.session.enableBranchAsyncRemove=false\r\nserver.enableParallelRequestHandle=false\r\n\r\n#Metrics configuration, only for the server\r\nmetrics.enabled=false\r\nmetrics.registryType=compact\r\nmetrics.exporterList=prometheus\r\nmetrics.exporterPrometheusPort=9898', 'ffa95f9696dfba7a122b043dc2ae65bd', '2023-03-15 11:53:03', '2023-03-15 11:53:03', NULL, '192.168.1.16', '', '4b70485d-72dd-44df-a76a-7a3f578a3001', NULL, NULL, NULL, 'text', NULL, '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint UNSIGNED NOT NULL,
  `nid` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4379 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (16, 4379, 'mall4cloud-leaf.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_leaf}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}', '7270d1e291e451da9ceaa88cf70aaf85', '2023-08-08 01:58:35', '2023-08-08 09:58:35', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (2, 4380, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  #避免nacos取网卡出错\n  cloud:\n    inetutils:\n      preferred-networks: 192.168.1\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    type: com.zaxxer.hikari.HikariDataSource\n    hikari:\n      minimum-idle: 0\n      maximum-pool-size: 20\n      idle-timeout: 25000\n      auto-commit: true\n      connection-test-query: SELECT 1\n  redis:\n    host: 111.229.36.14\n    # password: null\n  jackson:\n    date-format: yyyy-MM-dd HH:mm:ss\n    time-zone: GMT+8\n      \n#mybatis的相关配置\nmybatis:\n  #mapper配置文件\n  mapper-locations: classpath:mapper/*Mapper.xml\n  type-aliases-package: com.mall4j.cloud.**.model\n  #开启驼峰命名\n  configuration:\n    map-underscore-to-camel-case: true\n\nseata:\n  enableAutoDataSourceProxy: false\n  config:\n    type: nacos\n    nacos:\n      namespace: 4b70485d-72dd-44df-a76a-7a3f578a3001\n      dataId: \"seataServer.properties\"\n      server-addr: ${spring.cloud.nacos.discovery.server-addr}\n      password: ${spring.cloud.nacos.discovery.password}\n      username: ${spring.cloud.nacos.discovery.username}\n  registry:\n    type: nacos\n    nacos:\n      server-addr: ${spring.cloud.nacos.discovery.server-addr}\n      password: ${spring.cloud.nacos.discovery.password}\n      username: ${spring.cloud.nacos.discovery.username}\n      namespace: ${seata.config.nacos.namespace}\n\nlogging:\n  level:\n    root: info\n    com:\n      mall4cloud:\n        shop: debug\n# 分页合理化，当查询到页码大于最后一页的时候，返回最后一页的数据，防止vue在最后一页删除时，数据不对的问题\npagehelper:\n  reasonable: true\n\nbiz:\n  oss:\n    # resources-url是带有bucket的\n    resources-url: http://111.229.36.14:9000/mall4cloud\n    type: 1\n    endpoint: http://111.229.36.14:9000\n    bucket: mall4cloud\n    access-key-id: admin\n    access-key-secret: admin123456\n\nfeign:\n  client:\n    config:\n      default:\n        connectTimeout: 5000\n        readTimeout: 5000\n        loggerLevel: basic\n  inside:\n    key: mall4cloud-feign-inside-key\n    secret: mall4cloud-feign-inside-secret\n    # ip白名单，如果有需要的话，用小写逗号分割\n    ips: \n\nmall4cloud:\n  job:\n    accessToken:\n    admin:\n      addresses: http://111.229.36.14:8999\n\nrocketmq:\n  name-server: 111.229.36.14:9876', '5652ab11b51671c751e6dd91d4b6d02d', '2023-08-08 02:03:07', '2023-08-08 10:03:08', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (2, 4381, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  #避免nacos取网卡出错\n  cloud:\n    inetutils:\n      preferred-networks: 192.168.1\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    type: com.zaxxer.hikari.HikariDataSource\n    hikari:\n      minimum-idle: 0\n      maximum-pool-size: 20\n      idle-timeout: 25000\n      auto-commit: true\n      connection-test-query: SELECT 1\n  redis:\n    host: 111.229.36.14\n    password: stip@2022\n  jackson:\n    date-format: yyyy-MM-dd HH:mm:ss\n    time-zone: GMT+8\n      \n#mybatis的相关配置\nmybatis:\n  #mapper配置文件\n  mapper-locations: classpath:mapper/*Mapper.xml\n  type-aliases-package: com.mall4j.cloud.**.model\n  #开启驼峰命名\n  configuration:\n    map-underscore-to-camel-case: true\n\nseata:\n  enableAutoDataSourceProxy: false\n  config:\n    type: nacos\n    nacos:\n      namespace: 4b70485d-72dd-44df-a76a-7a3f578a3001\n      dataId: \"seataServer.properties\"\n      server-addr: ${spring.cloud.nacos.discovery.server-addr}\n      password: ${spring.cloud.nacos.discovery.password}\n      username: ${spring.cloud.nacos.discovery.username}\n  registry:\n    type: nacos\n    nacos:\n      server-addr: ${spring.cloud.nacos.discovery.server-addr}\n      password: ${spring.cloud.nacos.discovery.password}\n      username: ${spring.cloud.nacos.discovery.username}\n      namespace: ${seata.config.nacos.namespace}\n\nlogging:\n  level:\n    root: info\n    com:\n      mall4cloud:\n        shop: debug\n# 分页合理化，当查询到页码大于最后一页的时候，返回最后一页的数据，防止vue在最后一页删除时，数据不对的问题\npagehelper:\n  reasonable: true\n\nbiz:\n  oss:\n    # resources-url是带有bucket的\n    resources-url: http://111.229.36.14:9000/mall4cloud\n    type: 1\n    endpoint: http://111.229.36.14:9000\n    bucket: mall4cloud\n    access-key-id: admin\n    access-key-secret: admin123456\n\nfeign:\n  client:\n    config:\n      default:\n        connectTimeout: 5000\n        readTimeout: 5000\n        loggerLevel: basic\n  inside:\n    key: mall4cloud-feign-inside-key\n    secret: mall4cloud-feign-inside-secret\n    # ip白名单，如果有需要的话，用小写逗号分割\n    ips: \n\nmall4cloud:\n  job:\n    accessToken:\n    admin:\n      addresses: http://111.229.36.14:8999\n\nrocketmq:\n  name-server: 111.229.36.14:9876', '1bcc577f061637da6feb89a991d7d3b0', '2023-08-08 02:03:33', '2023-08-08 10:03:33', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (8, 4382, 'mall4cloud-auth.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_auth}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}\n\n# 用于token aes签名的key，16位\nauth:\n  token:\n    signKey: -mall4cloud-mall ', '481bfd1540807d1a30bd4f7a6db98b9b', '2023-08-08 02:06:51', '2023-08-08 10:06:51', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (13, 4383, 'mall4cloud-multishop.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_multishop}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}', 'd7824018f4e65654ffdd47b8c1f7f4fd', '2023-08-08 02:07:04', '2023-08-08 10:07:05', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (18, 4384, 'mall4cloud-rbac.yml', 'DEFAULT_GROUP', '', 'spring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_rbac}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}\n', 'bfeec2aa5a07c9160845e5f829bf0504', '2023-08-08 02:07:19', '2023-08-08 10:07:19', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (31, 4385, 'mall4cloud-biz.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_biz}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}\n\nbiz:\n  oss:\n    # resources-url是带有bucket的\n    resources-url: http://111.229.36.14:9000/mall4cloud\n    # 文件上传类型 0.阿里云 1.minio\n    type: 1\n    endpoint: http://111.229.36.14:9000\n    bucket: mall4cloud\n    access-key-id: admin\n    access-key-secret: admin123456', 'c8f87af41cee97de803070356d2b7329', '2023-08-08 02:07:31', '2023-08-08 10:07:32', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (72, 4386, 'mall4cloud-product.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_product}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}', 'e945256b7ca72876c977f4ca3104757b', '2023-08-08 02:07:45', '2023-08-08 10:07:46', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (3727, 4387, 'mall4cloud-order.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_order}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}', 'd3b260ac353bbe791d5224e56c375d32', '2023-08-08 02:08:05', '2023-08-08 10:08:06', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (3736, 4388, 'mall4cloud-user.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_user}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}', 'b2c4453768c063be1a1eae040f2cd0db', '2023-08-08 02:08:20', '2023-08-08 10:08:20', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (3759, 4389, 'mall4cloud-platform.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_platform}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}', 'cb974abfd495723b0f00eb1e3562ac3c', '2023-08-08 02:08:33', '2023-08-08 10:08:34', 'nacos', '39.144.218.198', 'U', '', '');
INSERT INTO `his_config_info` VALUES (3812, 4390, 'mall4cloud-payment.yml', 'DEFAULT_GROUP', '', '# 数据源\nspring:\n  datasource:\n    url: jdbc:mysql://${MYSQL_HOST:111.229.36.14}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:mall4cloud_payment}?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true&useAffectedRows=true\n    username: ${MYSQL_USERNAME:root}\n    password: ${MYSQL_PASSWORD:root}\napplication:\n  domainUrl: http://47.112.182.96:8126/mall4cloud_payment', 'a314ed00c051cc7055db56b7c5ab97a2', '2023-08-08 02:08:47', '2023-08-08 10:08:48', 'nacos', '39.144.218.198', 'U', '', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------

-- ----------------------------
-- Table structure for shop_cart_item
-- ----------------------------
DROP TABLE IF EXISTS `shop_cart_item`;
CREATE TABLE `shop_cart_item`  (
  `cart_item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `shop_id` bigint NOT NULL COMMENT '店铺ID',
  `spu_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品ID',
  `sku_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'SkuID',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户ID',
  `count` int NOT NULL DEFAULT 0 COMMENT '购物车产品个数',
  `price_fee` bigint UNSIGNED NOT NULL COMMENT '售价，加入购物车时的商品价格',
  `is_checked` tinyint NULL DEFAULT NULL COMMENT '是否已勾选',
  PRIMARY KEY (`cart_item_id`) USING BTREE,
  UNIQUE INDEX `uk_user_shop_sku`(`sku_id`, `user_id`, `shop_id`) USING BTREE,
  INDEX `idx_shop_id`(`shop_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '购物车' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_cart_item
-- ----------------------------

-- ----------------------------
-- Table structure for sku
-- ----------------------------
DROP TABLE IF EXISTS `sku`;
CREATE TABLE `sku`  (
  `sku_id` bigint NOT NULL AUTO_INCREMENT COMMENT '属性id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `spu_id` bigint NOT NULL COMMENT 'SPU id',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku名称',
  `attrs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '多个销售属性值id逗号分隔',
  `img_url` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku图片',
  `price_fee` bigint NOT NULL DEFAULT 0 COMMENT '售价，整数方式保存',
  `market_price_fee` bigint NOT NULL DEFAULT 0 COMMENT '市场价，整数方式保存',
  `party_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `model_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品条形码',
  `weight` decimal(15, 3) NULL DEFAULT NULL COMMENT '商品重量',
  `volume` decimal(15, 3) NULL DEFAULT NULL COMMENT '商品体积',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态 1:enable, 0:disable, -1:deleted',
  PRIMARY KEY (`sku_id`) USING BTREE,
  INDEX `idx_spuid`(`spu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'sku信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku
-- ----------------------------

-- ----------------------------
-- Table structure for sku_stock
-- ----------------------------
DROP TABLE IF EXISTS `sku_stock`;
CREATE TABLE `sku_stock`  (
  `stock_id` bigint NOT NULL AUTO_INCREMENT COMMENT '库存id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sku_id` bigint UNSIGNED NOT NULL COMMENT 'SKU ID',
  `actual_stock` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际库存',
  `lock_stock` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '锁定库存',
  `stock` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '可售卖库存',
  PRIMARY KEY (`stock_id`) USING BTREE,
  INDEX `idx_skuid`(`sku_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '库存信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku_stock
-- ----------------------------

-- ----------------------------
-- Table structure for sku_stock_lock
-- ----------------------------
DROP TABLE IF EXISTS `sku_stock_lock`;
CREATE TABLE `sku_stock_lock`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `spu_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `sku_id` bigint NULL DEFAULT NULL COMMENT 'sku id',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单id',
  `status` tinyint NULL DEFAULT NULL COMMENT '状态-1已解锁 0待确定 1已锁定',
  `count` int NULL DEFAULT NULL COMMENT '锁定库存数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_spu_sku_order`(`spu_id`, `sku_id`, `order_id`) USING BTREE,
  INDEX `idx_sku_id`(`sku_id`) USING BTREE,
  INDEX `idx_order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '库存锁定信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku_stock_lock
-- ----------------------------

-- ----------------------------
-- Table structure for spu
-- ----------------------------
DROP TABLE IF EXISTS `spu`;
CREATE TABLE `spu`  (
  `spu_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'spu id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `brand_id` bigint NULL DEFAULT NULL COMMENT '品牌ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `shop_category_id` bigint NOT NULL DEFAULT 0 COMMENT '店铺分类ID',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `selling_point` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖点',
  `main_img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品介绍主图',
  `img_urls` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片 多个图片逗号分隔',
  `video` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品视频',
  `price_fee` bigint NOT NULL DEFAULT 0 COMMENT '售价，整数方式保存',
  `market_price_fee` bigint NOT NULL DEFAULT 0 COMMENT '市场价，整数方式保存',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态 -1:删除, 0:下架, 1:上架',
  `has_sku_img` tinyint NOT NULL DEFAULT 0 COMMENT 'sku是否含有图片 0无 1有',
  `seq` smallint NOT NULL DEFAULT 3 COMMENT '序号',
  PRIMARY KEY (`spu_id`) USING BTREE,
  INDEX `idx_brandid`(`brand_id`) USING BTREE,
  INDEX `idx_catid`(`category_id`) USING BTREE,
  INDEX `idx_shopid`(`shop_id`) USING BTREE,
  INDEX `idx_shop_catid`(`shop_category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'spu信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spu
-- ----------------------------

-- ----------------------------
-- Table structure for spu_attr_value
-- ----------------------------
DROP TABLE IF EXISTS `spu_attr_value`;
CREATE TABLE `spu_attr_value`  (
  `spu_attr_value_id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品属性值关联信息id',
  `spu_id` bigint UNSIGNED NOT NULL COMMENT '商品id',
  `attr_id` bigint UNSIGNED NOT NULL COMMENT '规格属性id',
  `attr_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格属性名称',
  `attr_value_id` bigint NULL DEFAULT NULL COMMENT '规格属性值id',
  `attr_value_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格属性值名称',
  `attr_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格属性描述',
  PRIMARY KEY (`spu_attr_value_id`) USING BTREE,
  UNIQUE INDEX `uni_spuid`(`spu_id`, `attr_id`) USING BTREE,
  INDEX `idx_attrid`(`attr_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品规格属性关联信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spu_attr_value
-- ----------------------------

-- ----------------------------
-- Table structure for spu_detail
-- ----------------------------
DROP TABLE IF EXISTS `spu_detail`;
CREATE TABLE `spu_detail`  (
  `spu_id` bigint NOT NULL COMMENT '商品id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `detail` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品详情',
  PRIMARY KEY (`spu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品详情信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spu_detail
-- ----------------------------

-- ----------------------------
-- Table structure for spu_extension
-- ----------------------------
DROP TABLE IF EXISTS `spu_extension`;
CREATE TABLE `spu_extension`  (
  `spu_extend_id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品扩展信息表id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `spu_id` bigint UNSIGNED NOT NULL COMMENT '商品id',
  `sale_num` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '销量',
  `actual_stock` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际库存',
  `lock_stock` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '锁定库存',
  `stock` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '可售卖库存',
  PRIMARY KEY (`spu_extend_id`) USING BTREE,
  INDEX `idx_spu`(`spu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spu_extension
-- ----------------------------

-- ----------------------------
-- Table structure for spu_sku_attr_value
-- ----------------------------
DROP TABLE IF EXISTS `spu_sku_attr_value`;
CREATE TABLE `spu_sku_attr_value`  (
  `spu_sku_attr_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品sku销售属性关联信息id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `spu_id` bigint NOT NULL DEFAULT 0 COMMENT 'SPU ID',
  `sku_id` bigint NOT NULL DEFAULT 0 COMMENT 'SKU ID',
  `attr_id` int NULL DEFAULT 0 COMMENT '销售属性ID',
  `attr_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '销售属性名称',
  `attr_value_id` int NULL DEFAULT 0 COMMENT '销售属性值ID',
  `attr_value_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '销售属性值',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态 1:enable, 0:disable, -1:deleted',
  PRIMARY KEY (`spu_sku_attr_id`) USING BTREE,
  INDEX `idx_spuid`(`spu_id`) USING BTREE,
  INDEX `idx_skuid`(`sku_id`) USING BTREE,
  INDEX `idx_attrid`(`attr_id`) USING BTREE,
  INDEX `idx_attrvalueid`(`attr_value_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品sku销售属性关联信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spu_sku_attr_value
-- ----------------------------

-- ----------------------------
-- Table structure for spu_tag
-- ----------------------------
DROP TABLE IF EXISTS `spu_tag`;
CREATE TABLE `spu_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分组标签id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `title` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分组标题',
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺Id',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态(1为正常,-1为删除)',
  `is_default` tinyint(1) NULL DEFAULT NULL COMMENT '默认类型(0:商家自定义,1:系统默认)',
  `prod_count` bigint NULL DEFAULT NULL COMMENT '商品数量',
  `style` int NULL DEFAULT NULL COMMENT '列表样式(0:一列一个,1:一列两个,2:一列三个)',
  `seq` int NULL DEFAULT NULL COMMENT '排序',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品分组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spu_tag
-- ----------------------------

-- ----------------------------
-- Table structure for spu_tag_reference
-- ----------------------------
DROP TABLE IF EXISTS `spu_tag_reference`;
CREATE TABLE `spu_tag_reference`  (
  `reference_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分组引用id',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `tag_id` bigint NULL DEFAULT NULL COMMENT '标签id',
  `spu_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态(1:正常,-1:删除)',
  `seq` int NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`reference_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品分组标签关联信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spu_tag_reference
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------
INSERT INTO `tenant_info` VALUES (2, '1', '4b70485d-72dd-44df-a76a-7a3f578a3001', 'seata', 'seata', 'nacos', 1653615223670, 1653615223670);

-- ----------------------------
-- Table structure for undo_log
-- ----------------------------
DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `branch_id` bigint NOT NULL,
  `xid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `context` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ux_undo_log`(`xid`, `branch_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of undo_log
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
