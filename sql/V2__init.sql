CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client` int DEFAULT NULL,
  `field` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client` (`client`),
  KEY `field` (`field`),
  CONSTRAINT `settings_ibfk_1` FOREIGN KEY (`client`) REFERENCES `clients` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4

INSERT INTO `settings` (`id`, `client`, `field`, `value`) VALUES (NULL, NULL, 'os.indextemplate', '{\"index_patterns\":[\"users-logs-*\"],\"template\":{\"settings\":{\"index.number_of_shards\":\"1\",\"index.number_of_replicas\":\"1\",\"index.plugins.index_state_management.policy_id\":\"user-logs-rollover-policy\"},\"mappings\":{\"dynamic\":true,\"properties\":{\"date\":{\"type\":\"date\"},\"googleTopics\":{\"type\":\"nested\",\"properties\":{\"name\":{\"type\":\"keyword\"},\"id\":{\"type\":\"integer\"}}},\"product\":{\"dynamic\":true,\"type\":\"nested\",\"properties\":{\"quantity\":{\"type\":\"integer\"},\"price\":{\"type\":\"object\",\"properties\":{\"amount\":{\"type\":\"float\"},\"currency\":{\"type\":\"keyword\"}}},\"id\":{\"type\":\"keyword\"},\"category\":{\"type\":\"keyword\"},\"brand\":{\"type\":\"keyword\"}}},\"instance\":{\"type\":\"integer\"},\"session\":{\"type\":\"keyword\"},\"target\":{\"type\":\"keyword\"},\"geo\":{\"dynamic\":true,\"type\":\"object\",\"properties\":{\"country\":{\"type\":\"keyword\"},\"zipCode\":{\"type\":\"keyword\"},\"city\":{\"type\":\"keyword\"},\"timeZone\":{\"type\":\"keyword\"},\"region\":{\"type\":\"keyword\"},\"point\":{\"type\":\"geo_point\"}}},\"referrer\":{\"type\":\"keyword\"},\"client\":{\"type\":\"integer\"},\"page\":{\"dynamic\":true,\"type\":\"object\",\"properties\":{\"image\":{\"type\":\"keyword\"},\"description\":{\"type\":\"text\"},\"href\":{\"type\":\"keyword\"},\"title\":{\"type\":\"text\"},\"type\":{\"type\":\"keyword\"}}},\"event\":{\"type\":\"keyword\"},\"device\":{\"dynamic\":true,\"type\":\"object\",\"properties\":{\"os\":{\"type\":\"keyword\"},\"browser\":{\"type\":\"keyword\"},\"ip\":{\"type\":\"ip\"},\"userAgent\":{\"fields\":{\"raw\":{\"type\":\"keyword\"}},\"type\":\"text\",\"store\": false},\"id\":{\"type\":\"keyword\"},\"type\":{\"type\":\"keyword\"}}},\"order\":{\"type\":\"keyword\"}}},\"aliases\":{\"users-logs\":{}}},\"composed_of\":[],\"priority\":\"0\",\"_meta\":{\"flow\":\"simple\"}}');
INSERT INTO `settings` (`id`, `client`, `field`, `value`) VALUES (NULL, NULL, 'os.indexstatemanagement', '{\"policy\":{\"description\":\"rollover users-logs indexes\",\"default_state\":\"hot\",\"states\":[{\"name\":\"hot\",\"actions\":[{\"retry\":{\"count\":3,\"backoff\":\"exponential\",\"delay\":\"1m\"},\"rollover\":{\"min_size\":\"20gb\",\"min_index_age\":\"30d\",\"copy_alias\":true}}],\"transitions\":[{\"state_name\":\"delete\",\"conditions\":{\"min_index_age\":\"1096d\"}}]},{\"name\":\"delete\",\"actions\":[{\"retry\":{\"count\":3,\"backoff\":\"exponential\",\"delay\":\"1m\"},\"delete\":{}}],\"transitions\":[]}],\"ism_template\":[{\"index_patterns\":[\"users-logs-*\"],\"priority\":1}]}}');
INSERT INTO `settings` (`id`, `client`, `field`, `value`) VALUES (NULL, NULL, 'os.indexsetting', '{\"aliases\":{\"users-logs-${client_id}\":{\"is_write_index\": true}},\"settings\": {\"plugins.index_state_management.rollover_alias\": \"users-logs-${client_id}\"}}');

TRUNCATE `Users`

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_super_admin` tinyint(1) DEFAULT '0',
  `status` varchar(20) DEFAULT 'active',
  `last_login_at` timestamp NULL DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `users_chk_1` CHECK ((`status` in (_utf8mb4'active',_utf8mb4'inactive',_utf8mb4'blocked')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
