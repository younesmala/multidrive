BEGIN TRANSACTION;
CREATE TABLE "accounts_accountdeletionrequest" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "reason" text NOT NULL, "created_at" datetime NOT NULL, "processed" bool NOT NULL, "processed_at" datetime NULL, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "accounts_accountstatus" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "is_deleted" bool NOT NULL, "deleted_at" datetime NULL, "deletion_label" varchar(80) NOT NULL, "user_id" integer NOT NULL UNIQUE REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "admin_note" text NOT NULL, "deletion_reason_type" varchar(20) NOT NULL, "phone" varchar(20) NOT NULL, "no_show_count" smallint unsigned NOT NULL CHECK ("no_show_count" >= 0), "banned_until" datetime NULL, "bank_iban" varchar(34) NOT NULL, "bank_holder" varchar(100) NOT NULL, "accepted_cgv" bool NOT NULL);
INSERT INTO "accounts_accountstatus" VALUES(2,0,NULL,'',2,'','user_request','+32 489 43 69 24',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(5,0,NULL,'',1372,'','user_request','+32 497 26 24 74',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(6,0,NULL,'',1374,'','user_request','0484489864',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(7,0,NULL,'',1375,'','user_request','+32 480 49 57 94',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(8,0,NULL,'',1373,'','user_request','+32 479 38 28 23',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(9,1,'2026-02-13 18:26:59.997816','Compte supprime le 13/02/2026',1376,'','user_request','+32 482 99 18 15',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(10,1,'2026-05-21 18:26:59.997816','Compte supprime le 21/05/2026',1377,'','user_request','+32 499 47 75 61',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(11,1,'2026-06-06 18:26:59.997816','Compte supprime le 06/06/2026',1378,'','user_request','+32 476 13 16 68',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(12,1,'2026-05-04 18:26:59.997816','Compte supprime le 04/05/2026',1379,'','admin_block','+32 484 49 28 74',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(13,1,'2026-04-18 18:26:59.997816','Compte supprime le 18/04/2026',1380,'','user_request','+32 480 36 73 31',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(14,1,'2026-07-31 18:26:59.997816','Compte supprime le 31/07/2026',1381,'','user_request','+32 475 62 25 64',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(15,1,'2026-04-03 18:26:59.997816','Compte supprime le 03/04/2026',1382,'','admin_block','+32 489 38 91 43',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(16,1,'2026-07-08 18:26:59.997816','Compte supprime le 08/07/2026',1383,'','user_request','+32 486 76 37 42',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(17,1,'2026-07-23 18:26:59.997816','Compte supprime le 23/07/2026',1384,'','user_request','+32 487 54 69 93',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(18,1,'2026-06-28 18:26:59.997816','Compte supprime le 28/06/2026',1385,'','admin_block','+32 471 87 84 66',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(19,1,'2026-04-06 18:26:59.997816','Compte supprime le 06/04/2026',1386,'','user_request','+32 482 70 64 61',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(20,1,'2026-05-26 18:26:59.997816','Compte supprime le 26/05/2026',1387,'','user_request','+32 477 78 31 51',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(21,0,NULL,'',1252,'','user_request','+32 471 22 50 53',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(22,0,NULL,'',1253,'','user_request','+32 478 99 67 68',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(23,0,NULL,'',1254,'','user_request','+32 496 84 50 67',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(24,0,NULL,'',1255,'','user_request','+32 483 15 31 93',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(25,0,NULL,'',1256,'','user_request','+32 496 43 28 75',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(26,0,NULL,'',1257,'','user_request','+32 497 34 58 20',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(27,0,NULL,'',1258,'','user_request','+32 474 79 51 61',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(28,0,NULL,'',1259,'','user_request','+32 472 72 83 49',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(29,0,NULL,'',1260,'','user_request','+32 472 37 52 54',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(30,0,NULL,'',1261,'','user_request','+32 484 26 19 99',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(31,0,NULL,'',1262,'','user_request','+32 483 31 27 23',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(32,0,NULL,'',1263,'','user_request','+32 492 21 57 21',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(33,0,NULL,'',1264,'','user_request','+32 476 63 46 59',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(34,0,NULL,'',1265,'','user_request','+32 483 18 66 96',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(35,0,NULL,'',1266,'','user_request','+32 473 62 21 46',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(36,0,NULL,'',1267,'','user_request','+32 479 74 38 76',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(37,0,NULL,'',1268,'','user_request','+32 471 27 58 25',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(38,0,NULL,'',1269,'','user_request','+32 474 26 79 73',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(39,0,NULL,'',1270,'','user_request','+32 482 44 51 40',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(40,0,NULL,'',1271,'','user_request','+32 471 41 12 94',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(41,0,NULL,'',1272,'','user_request','+32 487 99 22 34',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(42,0,NULL,'',1273,'','user_request','+32 479 65 62 71',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(43,0,NULL,'',1274,'','user_request','+32 485 19 68 19',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(44,0,NULL,'',1275,'','user_request','+32 482 11 56 44',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(45,0,NULL,'',1276,'','user_request','+32 496 12 95 12',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(46,0,NULL,'',1277,'','user_request','+32 474 18 75 61',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(47,0,NULL,'',1278,'','user_request','+32 487 21 49 37',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(48,0,NULL,'',1279,'','user_request','+32 472 92 55 30',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(49,0,NULL,'',1280,'','user_request','+32 489 33 97 75',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(50,0,NULL,'',1281,'','user_request','+32 485 80 60 70',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(51,0,NULL,'',1282,'','user_request','+32 479 46 29 44',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(52,0,NULL,'',1283,'','user_request','+32 498 44 15 87',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(53,0,NULL,'',1284,'','user_request','+32 487 87 40 41',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(54,0,NULL,'',1285,'','user_request','+32 475 33 56 88',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(55,0,NULL,'',1286,'','user_request','+32 472 34 67 58',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(56,0,NULL,'',1287,'','user_request','+32 470 64 40 64',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(57,0,NULL,'',1288,'','user_request','+32 478 60 97 85',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(58,0,NULL,'',1289,'','user_request','+32 486 32 62 30',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(59,0,NULL,'',1290,'','user_request','+32 481 70 67 41',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(60,0,NULL,'',1291,'','user_request','+32 479 49 40 70',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(61,0,NULL,'',1292,'','user_request','+32 471 80 11 91',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(62,0,NULL,'',1293,'','user_request','+32 492 26 71 49',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(63,0,NULL,'',1294,'','user_request','+32 492 54 79 99',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(64,0,NULL,'',1295,'','user_request','+32 497 98 21 65',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(65,0,NULL,'',1296,'','user_request','+32 471 50 73 78',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(66,0,NULL,'',1297,'','user_request','+32 476 11 12 84',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(67,0,NULL,'',1298,'','user_request','+32 472 83 63 65',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(68,0,NULL,'',1299,'','user_request','+32 479 94 65 88',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(69,0,NULL,'',1300,'','user_request','+32 476 97 66 81',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(70,0,NULL,'',1301,'','user_request','+32 496 59 53 31',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(71,0,NULL,'',1302,'','user_request','+32 499 22 27 21',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(72,0,NULL,'',1303,'','user_request','+32 492 74 56 34',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(73,0,NULL,'',1304,'','user_request','+32 493 20 83 70',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(74,0,NULL,'',1305,'','user_request','+32 476 77 33 67',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(75,0,NULL,'',1306,'','user_request','+32 489 38 23 10',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(76,0,NULL,'',1307,'','user_request','+32 470 16 69 39',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(77,0,NULL,'',1308,'','user_request','+32 488 50 27 12',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(78,0,NULL,'',1309,'','user_request','+32 484 17 90 37',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(79,0,NULL,'',1310,'','user_request','+32 491 71 36 66',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(80,0,NULL,'',1311,'','user_request','+32 492 91 50 78',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(81,0,NULL,'',1312,'','user_request','+32 478 98 64 42',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(82,0,NULL,'',1313,'','user_request','+32 483 70 26 64',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(83,0,NULL,'',1314,'','user_request','+32 495 99 50 15',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(84,0,NULL,'',1315,'','user_request','+32 485 43 42 32',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(85,0,NULL,'',1316,'','user_request','+32 490 95 59 33',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(86,0,NULL,'',1317,'','user_request','+32 471 81 40 43',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(87,0,NULL,'',1318,'','user_request','+32 497 36 22 38',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(88,0,NULL,'',1319,'','user_request','+32 493 29 99 24',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(89,0,NULL,'',1320,'','user_request','+32 487 30 23 98',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(90,0,NULL,'',1321,'','user_request','+32 498 49 64 96',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(91,0,NULL,'',1322,'','user_request','+32 484 50 20 42',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(92,0,NULL,'',1323,'','user_request','+32 474 36 32 86',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(93,0,NULL,'',1324,'','user_request','+32 492 43 22 48',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(94,0,NULL,'',1325,'','user_request','+32 482 60 95 68',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(95,0,NULL,'',1326,'','user_request','+32 489 50 55 97',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(96,0,NULL,'',1327,'','user_request','+32 471 67 22 54',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(97,0,NULL,'',1328,'','user_request','+32 482 51 70 63',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(98,0,NULL,'',1329,'','user_request','+32 478 19 78 62',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(99,0,NULL,'',1330,'','user_request','+32 476 53 87 11',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(100,0,NULL,'',1331,'','user_request','+32 475 72 89 73',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(101,0,NULL,'',1332,'','user_request','+32 493 79 66 11',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(102,0,NULL,'',1333,'','user_request','+32 496 85 87 42',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(103,0,NULL,'',1334,'','user_request','+32 485 21 50 13',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(104,0,NULL,'',1335,'','user_request','+32 478 44 75 77',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(105,0,NULL,'',1336,'','user_request','+32 488 53 24 91',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(106,0,NULL,'',1337,'','user_request','+32 471 50 68 41',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(107,0,NULL,'',1338,'','user_request','+32 485 40 51 63',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(108,0,NULL,'',1339,'','user_request','+32 483 60 36 71',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(109,0,NULL,'',1340,'','user_request','+32 490 88 64 73',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(110,0,NULL,'',1341,'','user_request','+32 473 50 42 10',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(111,0,NULL,'',1342,'','user_request','+32 491 82 48 81',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(112,0,NULL,'',1343,'','user_request','+32 480 88 69 44',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(113,0,NULL,'',1344,'','user_request','+32 475 73 16 36',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(114,0,NULL,'',1345,'','user_request','+32 480 83 14 48',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(115,0,NULL,'',1346,'','user_request','+32 498 18 68 86',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(116,0,NULL,'',1347,'','user_request','+32 494 12 17 32',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(117,0,NULL,'',1348,'','user_request','+32 475 40 15 24',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(118,0,NULL,'',1349,'','user_request','+32 497 30 94 12',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(119,0,NULL,'',1350,'','user_request','+32 497 40 53 34',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(120,0,NULL,'',1351,'','user_request','+32 485 42 22 19',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(121,0,NULL,'',1352,'','user_request','+32 479 69 39 59',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(122,0,NULL,'',1353,'','user_request','+32 485 43 13 63',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(123,0,NULL,'',1354,'','user_request','+32 472 55 35 94',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(124,0,NULL,'',1355,'','user_request','+32 485 33 49 21',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(125,0,NULL,'',1356,'','user_request','+32 482 46 75 77',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(126,0,NULL,'',1357,'','user_request','+32 477 81 10 21',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(127,0,NULL,'',1358,'','user_request','+32 486 73 70 92',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(128,0,NULL,'',1359,'','user_request','+32 490 30 10 21',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(129,0,NULL,'',1360,'','user_request','+32 488 51 40 48',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(130,0,NULL,'',1361,'','user_request','+32 494 25 86 62',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(131,0,NULL,'',1362,'','user_request','+32 483 29 76 75',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(132,0,NULL,'',1363,'','user_request','+32 484 28 47 18',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(133,0,NULL,'',1364,'','user_request','+32 489 53 75 10',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(134,0,NULL,'',1365,'','user_request','+32 497 76 34 55',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(135,0,NULL,'',1366,'','user_request','+32 485 10 95 32',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(136,0,NULL,'',1367,'','user_request','+32 474 24 48 64',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(137,0,NULL,'',1368,'','user_request','+32 493 66 49 22',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(138,0,NULL,'',1369,'','user_request','+32 491 68 12 73',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(139,0,NULL,'',1370,'','user_request','+32 470 66 60 61',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(140,0,NULL,'',1371,'','user_request','+32 481 99 31 40',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(141,0,NULL,'',1388,'','user_request','+32 485 70 61 51',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(142,0,NULL,'',1389,'','user_request','+32 479 32 92 23',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(143,0,NULL,'',1390,'','user_request','+32 474 35 42 30',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(144,0,NULL,'',1391,'','user_request','+32 489 63 43 15',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(145,0,NULL,'',1392,'','user_request','+32 499 58 78 27',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(146,0,NULL,'',1393,'','user_request','+32 485 59 84 60',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(147,0,NULL,'',1394,'','user_request','+32 472 70 65 38',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(148,0,NULL,'',1395,'','user_request','+32 481 47 99 94',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(149,0,NULL,'',1396,'','user_request','+32 479 63 98 91',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(150,0,NULL,'',1397,'','user_request','+32 480 15 16 53',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(151,0,NULL,'',1398,'','user_request','+32 490 56 99 23',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(152,0,NULL,'',1399,'','user_request','+32 499 53 72 44',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(153,0,NULL,'',1400,'','user_request','+32 470 23 92 36',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(154,0,NULL,'',1401,'','user_request','+32 489 74 57 87',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(155,0,NULL,'',1402,'','user_request','+32 478 59 18 82',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(156,0,NULL,'',1403,'','user_request','+32 486 58 49 95',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(157,0,NULL,'',1404,'','user_request','+32 470 71 29 51',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(158,0,NULL,'',1405,'','user_request','+32 495 69 11 34',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(159,0,NULL,'',1406,'','user_request','+32 499 55 11 81',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(160,0,NULL,'',1407,'','user_request','+32 492 33 55 82',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(161,0,NULL,'',1408,'','user_request','+32 496 54 60 79',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(162,0,NULL,'',1409,'','user_request','+32 472 17 46 77',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(163,0,NULL,'',1410,'','user_request','+32 496 41 39 28',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(164,0,NULL,'',1411,'','user_request','+32 493 38 70 40',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(165,0,NULL,'',1412,'','user_request','+32 489 66 79 34',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(166,0,NULL,'',1413,'','user_request','+32 481 39 61 22',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(167,0,NULL,'',1414,'','user_request','+32 492 57 16 24',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(168,0,NULL,'',1415,'','user_request','+32 477 35 81 47',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(169,0,NULL,'',1416,'','user_request','+32 492 63 35 67',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(170,0,NULL,'',1417,'','user_request','+32 471 91 83 63',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(171,0,NULL,'',1418,'','user_request','+32 481 95 77 76',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(172,0,NULL,'',1419,'','user_request','+32 477 89 42 11',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(173,0,NULL,'',1420,'','user_request','+32 480 17 85 22',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(174,0,NULL,'',1421,'','user_request','+32 489 20 37 86',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(175,0,NULL,'',1422,'','user_request','+32 495 76 89 71',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(176,0,NULL,'',1423,'','user_request','+32 489 67 19 84',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(177,0,NULL,'',1424,'','user_request','+32 496 68 50 86',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(178,0,NULL,'',1425,'','user_request','+32 489 59 20 58',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(179,0,NULL,'',1426,'','user_request','+32 478 34 51 70',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(180,0,NULL,'',1427,'','user_request','+32 490 27 15 68',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(181,0,NULL,'',1428,'','user_request','+32 484 84 23 75',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(182,0,NULL,'',1429,'','user_request','+32 494 87 51 15',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(183,0,NULL,'',1430,'','user_request','+32 476 36 49 83',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(184,0,NULL,'',1431,'','user_request','+32 479 29 65 24',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(185,0,NULL,'',1432,'','user_request','+32 474 38 32 45',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(186,0,NULL,'',1433,'','user_request','+32 474 45 19 21',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(187,0,NULL,'',1434,'','user_request','+32 477 21 63 65',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(188,0,NULL,'',1435,'','user_request','+32 499 37 90 35',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(189,0,NULL,'',1436,'','user_request','+32 473 46 23 69',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(190,0,NULL,'',1437,'','user_request','+32 498 46 33 65',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(191,0,NULL,'',1438,'','user_request','+32 492 94 75 55',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(192,0,NULL,'',1439,'','user_request','+32 473 81 71 23',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(193,0,NULL,'',1440,'','user_request','+32 493 78 93 44',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(194,0,NULL,'',1441,'','user_request','+32 491 69 18 16',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(195,0,NULL,'',1442,'','user_request','+32 491 17 78 57',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(196,0,NULL,'',1443,'','user_request','+32 480 13 41 27',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(197,0,NULL,'',1444,'','user_request','+32 496 97 81 50',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(198,0,NULL,'',1445,'','user_request','+32 470 14 30 66',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(199,0,NULL,'',1446,'','user_request','+32 499 17 86 81',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(200,0,NULL,'',1447,'','user_request','+32 477 31 86 30',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(201,0,NULL,'',1448,'','user_request','+32 485 11 19 10',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(202,0,NULL,'',1449,'','user_request','+32 498 24 27 60',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(203,0,NULL,'',1450,'','user_request','+32 475 72 58 42',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(204,0,NULL,'',1451,'','user_request','+32 488 45 82 88',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(205,0,NULL,'',1452,'','user_request','+32 484 13 98 25',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(206,0,NULL,'',1453,'','user_request','+32 484 17 34 26',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(207,0,NULL,'',1454,'','user_request','+32 471 55 73 64',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(208,0,NULL,'',1455,'','user_request','+32 487 82 94 30',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(209,0,NULL,'',1456,'','user_request','+32 492 50 40 93',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(210,0,NULL,'',1457,'','user_request','+32 477 90 60 46',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(211,0,NULL,'',1458,'','user_request','+32 475 45 30 81',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(212,0,NULL,'',1459,'','user_request','+32 471 17 79 18',0,NULL,'','',0);
INSERT INTO "accounts_accountstatus" VALUES(213,0,NULL,'',1461,'','user_request','0484489865',0,NULL,'','',1);
CREATE TABLE "accounts_adminnote" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "content" text NOT NULL, "created_at" datetime NOT NULL, "author_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "auth_group" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(150) NOT NULL UNIQUE);
CREATE TABLE "auth_group_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "auth_permission" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "codename" varchar(100) NOT NULL, "name" varchar(255) NOT NULL);
INSERT INTO "auth_permission" VALUES(1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES(2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES(3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES(4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES(5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES(6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES(7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES(8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES(9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES(10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES(11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES(12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES(13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES(14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES(15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES(16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES(17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES(18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES(19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES(20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES(21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES(22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES(23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES(24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES(25,7,'add_vehicle','Can add vehicle');
INSERT INTO "auth_permission" VALUES(26,7,'change_vehicle','Can change vehicle');
INSERT INTO "auth_permission" VALUES(27,7,'delete_vehicle','Can delete vehicle');
INSERT INTO "auth_permission" VALUES(28,7,'view_vehicle','Can view vehicle');
INSERT INTO "auth_permission" VALUES(29,8,'add_vehiclecategory','Can add vehicle category');
INSERT INTO "auth_permission" VALUES(30,8,'change_vehiclecategory','Can change vehicle category');
INSERT INTO "auth_permission" VALUES(31,8,'delete_vehiclecategory','Can delete vehicle category');
INSERT INTO "auth_permission" VALUES(32,8,'view_vehiclecategory','Can view vehicle category');
INSERT INTO "auth_permission" VALUES(33,9,'add_vehicleimage','Can add vehicle image');
INSERT INTO "auth_permission" VALUES(34,9,'change_vehicleimage','Can change vehicle image');
INSERT INTO "auth_permission" VALUES(35,9,'delete_vehicleimage','Can delete vehicle image');
INSERT INTO "auth_permission" VALUES(36,9,'view_vehicleimage','Can view vehicle image');
INSERT INTO "auth_permission" VALUES(37,10,'add_reservation','Can add reservation');
INSERT INTO "auth_permission" VALUES(38,10,'change_reservation','Can change reservation');
INSERT INTO "auth_permission" VALUES(39,10,'delete_reservation','Can delete reservation');
INSERT INTO "auth_permission" VALUES(40,10,'view_reservation','Can view reservation');
INSERT INTO "auth_permission" VALUES(41,11,'add_payment','Can add payment');
INSERT INTO "auth_permission" VALUES(42,11,'change_payment','Can change payment');
INSERT INTO "auth_permission" VALUES(43,11,'delete_payment','Can delete payment');
INSERT INTO "auth_permission" VALUES(44,11,'view_payment','Can view payment');
INSERT INTO "auth_permission" VALUES(45,12,'add_invoice','Can add invoice');
INSERT INTO "auth_permission" VALUES(46,12,'change_invoice','Can change invoice');
INSERT INTO "auth_permission" VALUES(47,12,'delete_invoice','Can delete invoice');
INSERT INTO "auth_permission" VALUES(48,12,'view_invoice','Can view invoice');
INSERT INTO "auth_permission" VALUES(49,13,'add_contactmessage','Can add contact message');
INSERT INTO "auth_permission" VALUES(50,13,'change_contactmessage','Can change contact message');
INSERT INTO "auth_permission" VALUES(51,13,'delete_contactmessage','Can delete contact message');
INSERT INTO "auth_permission" VALUES(52,13,'view_contactmessage','Can view contact message');
INSERT INTO "auth_permission" VALUES(53,14,'add_review','Can add review');
INSERT INTO "auth_permission" VALUES(54,14,'change_review','Can change review');
INSERT INTO "auth_permission" VALUES(55,14,'delete_review','Can delete review');
INSERT INTO "auth_permission" VALUES(56,14,'view_review','Can view review');
INSERT INTO "auth_permission" VALUES(57,16,'add_accountstatus','Can add Account status');
INSERT INTO "auth_permission" VALUES(58,16,'change_accountstatus','Can change Account status');
INSERT INTO "auth_permission" VALUES(59,16,'delete_accountstatus','Can delete Account status');
INSERT INTO "auth_permission" VALUES(60,16,'view_accountstatus','Can view Account status');
INSERT INTO "auth_permission" VALUES(61,15,'add_accountdeletionrequest','Can add Account deletion request');
INSERT INTO "auth_permission" VALUES(62,15,'change_accountdeletionrequest','Can change Account deletion request');
INSERT INTO "auth_permission" VALUES(63,15,'delete_accountdeletionrequest','Can delete Account deletion request');
INSERT INTO "auth_permission" VALUES(64,15,'view_accountdeletionrequest','Can view Account deletion request');
INSERT INTO "auth_permission" VALUES(65,17,'add_favorite','Can add favorite');
INSERT INTO "auth_permission" VALUES(66,17,'change_favorite','Can change favorite');
INSERT INTO "auth_permission" VALUES(67,17,'delete_favorite','Can delete favorite');
INSERT INTO "auth_permission" VALUES(68,17,'view_favorite','Can view favorite');
INSERT INTO "auth_permission" VALUES(69,18,'add_testimonial','Can add Temoignage');
INSERT INTO "auth_permission" VALUES(70,18,'change_testimonial','Can change Temoignage');
INSERT INTO "auth_permission" VALUES(71,18,'delete_testimonial','Can delete Temoignage');
INSERT INTO "auth_permission" VALUES(72,18,'view_testimonial','Can view Temoignage');
INSERT INTO "auth_permission" VALUES(73,19,'add_adminnote','Can add Note admin');
INSERT INTO "auth_permission" VALUES(74,19,'change_adminnote','Can change Note admin');
INSERT INTO "auth_permission" VALUES(75,19,'delete_adminnote','Can delete Note admin');
INSERT INTO "auth_permission" VALUES(76,19,'view_adminnote','Can view Note admin');
CREATE TABLE "auth_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NULL, "is_superuser" bool NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "last_name" varchar(150) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL, "first_name" varchar(150) NOT NULL);
INSERT INTO "auth_user" VALUES(2,'pbkdf2_sha256$1200000$c9oYymWYUCkcSOqM3t3CWG$W8y6HTBvqdBZqfKCaCb3LKU3HVKhUMz2NdZq/1XTIK4=','2026-08-23 12:34:42.297790',1,'admin','','admin@multidrive.local',1,1,'2026-04-19 15:05:02.387437','');
INSERT INTO "auth_user" VALUES(1252,'pbkdf2_sha256$1200000$EMWXhu9nwiNact0dTFS84m$Ethx2o+KZn0NE26gRLTmB3xMFjuccqzcebDgwCalQYg=','2026-08-10 18:01:49.388446',0,'client_adam_001','Client1','client_adam_001@example.com',0,1,'2026-05-23 12:31:23.355831','Adam');
INSERT INTO "auth_user" VALUES(1253,'pbkdf2_sha256$1200000$UvisgBIiSRJsaFxE4Yc0RL$wDa/0gtgSTruTJKdMuiaKaQOBEbjVOxuQ1B14bKaHes=',NULL,0,'client_sarah_002','Client2','client_sarah_002@example.com',0,1,'2026-05-23 12:31:24.192434','Sarah');
INSERT INTO "auth_user" VALUES(1254,'pbkdf2_sha256$1200000$AxQHoHT0No9I4x8VuQiYoZ$7ItHEqetql274eRpz5aQHSBtLM+CIegqux1Gs/wjPDc=',NULL,0,'client_mehdi_003','Client3','client_mehdi_003@example.com',0,1,'2026-05-23 12:31:25.069361','Mehdi');
INSERT INTO "auth_user" VALUES(1255,'pbkdf2_sha256$1200000$tXscmLUYYq3fk0iETRYdrY$FHDkKCs9Hx97Dsnv7jDFYh8UFtIhAWo1bQkmIPpJ4tM=',NULL,0,'client_lina_004','Client4','client_lina_004@example.com',0,1,'2026-05-23 12:31:25.883450','Lina');
INSERT INTO "auth_user" VALUES(1256,'pbkdf2_sha256$1200000$Nd0VlO1xRglVlubhwNvIxh$Gki01pQAIqPfir2VrOPTilYvGUxvjQZ0WjOo+f2qs+A=',NULL,0,'client_nicolas_005','Client5','client_nicolas_005@example.com',0,1,'2026-05-23 12:31:26.697606','Nicolas');
INSERT INTO "auth_user" VALUES(1257,'pbkdf2_sha256$1200000$xw2HmFFkCmQOyDgI4ztpNg$VLE6/vw8WZYtCQVVLkq6p3XdSk9EscvEPcdLXFdtPTw=',NULL,0,'client_emma_006','Client6','client_emma_006@example.com',0,1,'2026-05-23 12:31:27.531679','Emma');
INSERT INTO "auth_user" VALUES(1258,'pbkdf2_sha256$1200000$s23GMpBNAXkfU6KbE0vxxI$gSoNGBSNMDFcPx52DQm3lIBduVIOhqJPMP8FEDGDslc=',NULL,0,'client_yanis_007','Client7','client_yanis_007@example.com',0,1,'2026-05-23 12:31:28.353646','Yanis');
INSERT INTO "auth_user" VALUES(1259,'pbkdf2_sha256$1200000$cl2rCEhx6EYpZNumFl1hoa$MCEAf0WPKm/40LLbE1xFazII6mOpH/swxWz2STXM3q4=',NULL,0,'client_julie_008','Client8','client_julie_008@example.com',0,1,'2026-05-23 12:31:29.163187','Julie');
INSERT INTO "auth_user" VALUES(1260,'pbkdf2_sha256$1200000$tq7IXrBsWhH7MS891Fubl3$a1u/ccVsHuoM3z3me0//q3dgafuiqF+Wj7TmhhIVvbI=',NULL,0,'client_thomas_009','Client9','client_thomas_009@example.com',0,1,'2026-05-23 12:31:29.975221','Thomas');
INSERT INTO "auth_user" VALUES(1261,'pbkdf2_sha256$1200000$2KFFDJmQ5YfqPGcDEPZz3O$L+0GtIgrp3JJ4AUhpI181piPDUUP2FgcjY6cMJnwk1c=',NULL,0,'client_ines_010','Client10','client_ines_010@example.com',0,1,'2026-05-23 12:31:30.813676','Ines');
INSERT INTO "auth_user" VALUES(1262,'pbkdf2_sha256$1200000$pX8ZyXt1ZYJmzfpTb3bKSS$XVP8+qwwJZqo23X0XLOGDNo7vhXiAKWSBJcI0WNqh/A=',NULL,0,'client_samir_011','Client11','client_samir_011@example.com',0,1,'2026-05-23 12:31:31.622101','Samir');
INSERT INTO "auth_user" VALUES(1263,'pbkdf2_sha256$1200000$q269absOudMgeSQu4nGkJk$XmtX+TkcUEd7vYguzNDo/QldW2Ma961Yv9PuPf9G/z4=',NULL,0,'client_lucie_012','Client12','client_lucie_012@example.com',0,1,'2026-05-23 12:31:32.455576','Lucie');
INSERT INTO "auth_user" VALUES(1264,'pbkdf2_sha256$1200000$dZC25vnEg2Hc1KEw2R6zdR$M+2oCq+eyGnyr/pyYIgwsk5iQMi5G3hCGWKZzEqoqwA=',NULL,0,'client_maxime_013','Client13','client_maxime_013@example.com',0,1,'2026-05-23 12:31:33.274406','Maxime');
INSERT INTO "auth_user" VALUES(1265,'pbkdf2_sha256$1200000$pwAxZdF4SleTn5ot0ncMMz$lZ0ghIEO6wGgjy3Bwy9F4tgmIRhgrKZxFmhryM0OsOk=',NULL,0,'client_nora_014','Client14','client_nora_014@example.com',0,1,'2026-05-23 12:31:34.083793','Nora');
INSERT INTO "auth_user" VALUES(1266,'pbkdf2_sha256$1200000$EQVTOdD8owipUFmNrj2rax$83iPjaMA60X95if6ZoyS4yFzwgaq9VBk0vnMBlmjqjI=',NULL,0,'client_quentin_015','Client15','client_quentin_015@example.com',0,1,'2026-05-23 12:31:34.891685','Quentin');
INSERT INTO "auth_user" VALUES(1267,'pbkdf2_sha256$1200000$I5l9DRCgLZzpeVcH7xa5MD$hLksVEOhBryBp+4ugscENB1pTRa4I7a+okPQzACzOoI=',NULL,0,'client_amina_016','Client16','client_amina_016@example.com',0,1,'2026-05-23 12:31:35.701761','Amina');
INSERT INTO "auth_user" VALUES(1268,'pbkdf2_sha256$1200000$0fZ6PB7RMKhgQKQfbwURtT$rrarEnxJuX2/pOqNOtbicEtIvcxVgqA3UPll7P5t7ZY=',NULL,0,'client_hugo_017','Client17','client_hugo_017@example.com',0,1,'2026-05-23 12:31:36.516807','Hugo');
INSERT INTO "auth_user" VALUES(1269,'pbkdf2_sha256$1200000$VW3b0w1ouJ9t38fCKcaULv$4gGp34EAkDLvM/hQgsnOkP4FL4Z34ItluMrnVYQnoKs=',NULL,0,'client_lea_018','Client18','client_lea_018@example.com',0,1,'2026-05-23 12:31:37.345845','Lea');
INSERT INTO "auth_user" VALUES(1270,'pbkdf2_sha256$1200000$H0UsRcIMGhzsqLKcal0bN2$8uT5mDVaajpGMdihf6b9MqrzrrSD6KxIWyPs8CmX6ko=',NULL,0,'client_karim_019','Client19','client_karim_019@example.com',0,1,'2026-05-23 12:31:38.171357','Karim');
INSERT INTO "auth_user" VALUES(1271,'pbkdf2_sha256$1200000$wYE9d37mpeTB0YnyEVxmYL$n7TEvQvWbVb72B4iCpn1YQT1Vl8m3RJ5xsRPU4C46Tg=',NULL,0,'client_clara_020','Client20','client_clara_020@example.com',0,1,'2026-05-23 12:31:38.984912','Clara');
INSERT INTO "auth_user" VALUES(1272,'pbkdf2_sha256$1200000$j1XV3G14rFZeJhOwl7qTMq$8LVUCNQytzKCRBh1aDj6npxnQTPeeg2r8wgFwqLTdTA=',NULL,0,'client_sofiane_021','Client21','client_sofiane_021@example.com',0,1,'2026-05-23 12:31:39.792768','Sofiane');
INSERT INTO "auth_user" VALUES(1273,'pbkdf2_sha256$1200000$k0jV6qhgTg6ZwWAetT0SIL$bxCuG7HgMPA7Mj848CU98LuP2IuVP1CQ7Fs6hTz2/0c=',NULL,0,'client_camille_022','Client22','client_camille_022@example.com',0,1,'2026-05-23 12:31:40.608648','Camille');
INSERT INTO "auth_user" VALUES(1274,'pbkdf2_sha256$1200000$zmRC6GkPa72UZrjht1BZNA$PovH7Iz6qNhFRyA8m9irdnoZbBpP8hD9KgP5SKxHf84=',NULL,0,'client_ilias_023','Client23','client_ilias_023@example.com',0,1,'2026-05-23 12:31:41.413675','Ilias');
INSERT INTO "auth_user" VALUES(1275,'pbkdf2_sha256$1200000$Mla97GdS6ey1OsyMb3FBgT$p8X5biDh2E25ZWNFrDJdUCCvKPNL+ISlpukbk910B+A=',NULL,0,'client_zoe_024','Client24','client_zoe_024@example.com',0,1,'2026-05-23 12:31:42.239694','Zoe');
INSERT INTO "auth_user" VALUES(1276,'pbkdf2_sha256$1200000$dqLkw1buhTqQWIXhmVSLt1$j5CMWGLIBdI3yZY6lPPIwZGvT7blitpqZyTyBS00lcE=',NULL,0,'client_mathis_025','Client25','client_mathis_025@example.com',0,1,'2026-05-23 12:31:43.068065','Mathis');
INSERT INTO "auth_user" VALUES(1277,'pbkdf2_sha256$1200000$FKUAM8Q7oatpQoL0PflZVX$miHNEJhkTsr4pSDqXGYO25Y6GbWInMZbECr4/s6YFhQ=',NULL,0,'client_mila_026','Client26','client_mila_026@example.com',0,1,'2026-05-23 12:31:43.878504','Mila');
INSERT INTO "auth_user" VALUES(1278,'pbkdf2_sha256$1200000$8wF5oMGCjzGBkoL8mbedYZ$xsVMiBLylWmpTT9vFy0X5Mg2nfXj/aXjyVYOkJi3zQo=',NULL,0,'client_ilyes_027','Client27','client_ilyes_027@example.com',0,1,'2026-05-23 12:31:44.692214','Ilyes');
INSERT INTO "auth_user" VALUES(1279,'pbkdf2_sha256$1200000$2FEtdly6Q16nou9AsKCJ07$M6xMi7Ow2UX5qH0YB21uScgbpivdJITBbgj4lrqJPPg=',NULL,0,'client_eva_028','Client28','client_eva_028@example.com',0,1,'2026-05-23 12:31:45.504161','Eva');
INSERT INTO "auth_user" VALUES(1280,'pbkdf2_sha256$1200000$bk07rmUF8ZgPj1SnqOmGS2$sSctLDvQD3kUUzGVGFyLnjJchKWAA9sflpaCBbi2Bto=',NULL,0,'client_arthur_029','Client29','client_arthur_029@example.com',0,1,'2026-05-23 12:31:46.308996','Arthur');
INSERT INTO "auth_user" VALUES(1281,'pbkdf2_sha256$1200000$VMvqaM7Llrt88TfGkjp3Ai$vbPnMe9L0NlB7r0ACOVDS6dQyx3WIoNw6Hfr9INAXII=',NULL,0,'client_sana_030','Client30','client_sana_030@example.com',0,1,'2026-05-23 12:31:47.133713','Sana');
INSERT INTO "auth_user" VALUES(1282,'pbkdf2_sha256$1200000$wGcNW50COK5Y5tc541MLzI$G+BzSDSNMp4/2KqpE996ua/cH4tdJhjjtuedDEKZl2U=',NULL,0,'client_noah_031','Client31','client_noah_031@example.com',0,1,'2026-05-23 12:31:47.961535','Noah');
INSERT INTO "auth_user" VALUES(1283,'pbkdf2_sha256$1200000$uSpRbkjPpS7coUypq2Jeim$qIr3Q++iMfkM8TsFcSe/7zOGbf5sPvxOSy/P5ThkcrY=',NULL,0,'client_jade_032','Client32','client_jade_032@example.com',0,1,'2026-05-23 12:31:48.775783','Jade');
INSERT INTO "auth_user" VALUES(1284,'pbkdf2_sha256$1200000$QBU3XpeassulbcrKrTK2Y9$FVc3NEmnhZdddyrVxfcJDxuUYVBV3jbfhGDS6yGhlS0=',NULL,0,'client_enzo_033','Client33','client_enzo_033@example.com',0,1,'2026-05-23 12:31:49.588366','Enzo');
INSERT INTO "auth_user" VALUES(1285,'pbkdf2_sha256$1200000$ABppfSq9EKYc6uOhctorzt$uTPYDLQnRVtdIsMZsPuSA04XniBnVOi++I4mJz62K9I=',NULL,0,'client_mariam_034','Client34','client_mariam_034@example.com',0,1,'2026-05-23 12:31:50.396864','Mariam');
INSERT INTO "auth_user" VALUES(1286,'pbkdf2_sha256$1200000$yEcbAV07NI6P0WauE9n79P$Rg8zGF4coE2jmjL1N5Ay3tWGHswfmaKuO37oWhRzD1A=',NULL,0,'client_liam_035','Client35','client_liam_035@example.com',0,1,'2026-05-23 12:31:51.241848','Liam');
INSERT INTO "auth_user" VALUES(1287,'pbkdf2_sha256$1200000$GxhCykMkqzzo2tvbjCjjBd$dycmOH+glrhHPJ5vQaaA2YNsCdQTjPY1D97So56Czjw=',NULL,0,'client_inesa_036','Client36','client_inesa_036@example.com',0,1,'2026-05-23 12:31:52.063205','Inesa');
INSERT INTO "auth_user" VALUES(1288,'pbkdf2_sha256$1200000$w9qDprqmGNmio6jEEVWUHq$nksqI4MKPD1++FM/pFxn1r1ZCcyJvay5pLpZNL6hYrs=',NULL,0,'client_louis_037','Client37','client_louis_037@example.com',0,1,'2026-05-23 12:31:52.897031','Louis');
INSERT INTO "auth_user" VALUES(1289,'pbkdf2_sha256$1200000$YNGUk6umY5XBozjG70APqk$wgB2i5O5sHR9p/zvjEW5G7aXaFUNSqnF764fjb+V9qY=',NULL,0,'client_maya_038','Client38','client_maya_038@example.com',0,1,'2026-05-23 12:31:53.709531','Maya');
INSERT INTO "auth_user" VALUES(1290,'pbkdf2_sha256$1200000$S1LlbFr79TXDdGrQCjVRbv$WcQzLZJUfaSNG0i8Su1PY5y9IiTxronRiltbzsY3M9g=',NULL,0,'client_ayoub_039','Client39','client_ayoub_039@example.com',0,1,'2026-05-23 12:31:54.525115','Ayoub');
INSERT INTO "auth_user" VALUES(1291,'pbkdf2_sha256$1200000$tnTsD0JJCe8HVWAZv9HCA5$B4C0DHSXppROsRAWcWWPv951gcAB8EnoZbCIaGO7CB0=',NULL,0,'client_anna_040','Client40','client_anna_040@example.com',0,1,'2026-05-23 12:31:55.331069','Anna');
INSERT INTO "auth_user" VALUES(1292,'pbkdf2_sha256$1200000$O6ImKyc67Zkt72hIi0pg55$1ZRqYC2H4po85HdG2j1i2hKcbdEBIuc/DOIV2G/6Mm0=',NULL,0,'client_adam_041','Client41','client_adam_041@example.com',0,1,'2026-05-23 12:31:56.143012','Adam');
INSERT INTO "auth_user" VALUES(1293,'pbkdf2_sha256$1200000$Gc601sJgVS8yPC10A3eNFI$dORMwRVfaYznF6t3TfczYqqwCdm9IH14Sgmfq+zaRfI=',NULL,0,'client_sarah_042','Client42','client_sarah_042@example.com',0,1,'2026-05-23 12:31:56.961562','Sarah');
INSERT INTO "auth_user" VALUES(1294,'pbkdf2_sha256$1200000$uqhoHs9NkU02hWys5sDK4K$02Dy2fl4YJ+9EMzLunIIBCpzvG2br6tSQsaMLoNuWmE=',NULL,0,'client_mehdi_043','Client43','client_mehdi_043@example.com',0,1,'2026-05-23 12:31:57.787366','Mehdi');
INSERT INTO "auth_user" VALUES(1295,'pbkdf2_sha256$1200000$7w05mfKRx9N2qC32c2TIVL$QP68mDKpXn84MLVUimN1f0CWPsOgWJHmdtkRyKtHrYg=',NULL,0,'client_lina_044','Client44','client_lina_044@example.com',0,1,'2026-05-23 12:31:58.618765','Lina');
INSERT INTO "auth_user" VALUES(1296,'pbkdf2_sha256$1200000$kO4LSaPT5QUGAYRltvgmR0$5ywJhpZV7eY6G2UsnyW0kp9HUA/LN/61ZOVYgxFnKVk=',NULL,0,'client_nicolas_045','Client45','client_nicolas_045@example.com',0,1,'2026-05-23 12:31:59.427852','Nicolas');
INSERT INTO "auth_user" VALUES(1297,'pbkdf2_sha256$1200000$G39UNfcPx7Cpfz7Ddt8TBJ$Hq2Cevfmx31TVs28YUWeplikR2T9/vnsLBct4FyPjwI=',NULL,0,'client_emma_046','Client46','client_emma_046@example.com',0,1,'2026-05-23 12:32:00.238641','Emma');
INSERT INTO "auth_user" VALUES(1298,'pbkdf2_sha256$1200000$JT4aDDU6rM1fkMJt7sMUM3$8gmeNIAGJfiOtg09HRKgNnOl3/xqebtWEFDd4UUo/OM=',NULL,0,'client_yanis_047','Client47','client_yanis_047@example.com',0,1,'2026-05-23 12:32:01.053473','Yanis');
INSERT INTO "auth_user" VALUES(1299,'pbkdf2_sha256$1200000$Q2SGpz4qKaig08IYHyXGSl$CY5MmXgNHZDyWh6QJDHbxKmLfqozc0prGnYaarLgSPQ=',NULL,0,'client_julie_048','Client48','client_julie_048@example.com',0,1,'2026-05-23 12:32:01.870617','Julie');
INSERT INTO "auth_user" VALUES(1300,'pbkdf2_sha256$1200000$vigMsWiriQ6X1kj2iQEPY5$GhL6E92PIUDlRFLBw/Xxd++WWssMdN0bnXpQBsSpRKI=',NULL,0,'client_thomas_049','Client49','client_thomas_049@example.com',0,1,'2026-05-23 12:32:02.700749','Thomas');
INSERT INTO "auth_user" VALUES(1301,'pbkdf2_sha256$1200000$ERzwsMmjNyuf2z99Sd98CU$KcD1howls6vmQ8Xw55/JGHNh1uI8pyDX7emzDGWgeg8=',NULL,0,'client_ines_050','Client50','client_ines_050@example.com',0,1,'2026-05-23 12:32:03.522755','Ines');
INSERT INTO "auth_user" VALUES(1302,'pbkdf2_sha256$1200000$aD4TpNX3UMtktVVST1gG6w$pzGxjOakXb4gjKKHshA8H+WMnj6Nhk3FfLkkWlfAZZ4=',NULL,0,'client_samir_051','Client51','client_samir_051@example.com',0,1,'2026-05-23 12:32:04.333064','Samir');
INSERT INTO "auth_user" VALUES(1303,'pbkdf2_sha256$1200000$fvDTaBoa9HHc89cDVtfIoA$kDxc/e69HYt9b8kR9dNLvELLwQmMo8aD3/P0VCmVrcI=',NULL,0,'client_lucie_052','Client52','client_lucie_052@example.com',0,1,'2026-05-23 12:32:05.148858','Lucie');
INSERT INTO "auth_user" VALUES(1304,'pbkdf2_sha256$1200000$F1U48mbQBuVyUJSKN10hvz$tlk4CgNiYPiNmnipHRj+wdp42pIQ8izNyjEz8J+ExPs=',NULL,0,'client_maxime_053','Client53','client_maxime_053@example.com',0,1,'2026-05-23 12:32:05.960599','Maxime');
INSERT INTO "auth_user" VALUES(1305,'pbkdf2_sha256$1200000$QNoIROshGEngSGVTXap05I$HNPX/qP0bxIarBV7XbdujYkkVp1wqgPrxMWOYZfElBw=',NULL,0,'client_nora_054','Client54','client_nora_054@example.com',0,1,'2026-05-23 12:32:06.772289','Nora');
INSERT INTO "auth_user" VALUES(1306,'pbkdf2_sha256$1200000$E5XCg3GzZ8JU7U98bkW6kB$/6XVXx2oVynVJeWlaC88AQOp5McJjChsLVuvJIYO/c8=',NULL,0,'client_quentin_055','Client55','client_quentin_055@example.com',0,1,'2026-05-23 12:32:07.601869','Quentin');
INSERT INTO "auth_user" VALUES(1307,'pbkdf2_sha256$1200000$zBIVxDoBRHvD3cc8cOL9Iq$5SFrS6oWAr92118do/bNrb58DaU3qV26xAle2ni4mi4=',NULL,0,'client_amina_056','Client56','client_amina_056@example.com',0,1,'2026-05-23 12:32:08.414533','Amina');
INSERT INTO "auth_user" VALUES(1308,'pbkdf2_sha256$1200000$N0RkY8zLwpOo7mHD4wgG23$gYFwCD+PMe/ik/AW937RIZd0aoPRBa3L4FNEbgdSy04=',NULL,0,'client_hugo_057','Client57','client_hugo_057@example.com',0,1,'2026-05-23 12:32:09.227259','Hugo');
INSERT INTO "auth_user" VALUES(1309,'pbkdf2_sha256$1200000$2FkNSPYaUgYe1Xh7w3ubDP$Z14k9mi5qFH0V7VCOa3dDpfJKQKF6wY+i4wpWXRaPT8=',NULL,0,'client_lea_058','Client58','client_lea_058@example.com',0,1,'2026-05-23 12:32:10.036192','Lea');
INSERT INTO "auth_user" VALUES(1310,'pbkdf2_sha256$1200000$qqpeiVUphpYeKP1v4ojZbo$oOVIMQkoU/Z35jFWaVqzZAgrdT4m1P73HxStYcVzSxU=',NULL,0,'client_karim_059','Client59','client_karim_059@example.com',0,1,'2026-05-23 12:32:10.851702','Karim');
INSERT INTO "auth_user" VALUES(1311,'pbkdf2_sha256$1200000$5ePMY5Mfn7lazLqxe4EPON$rnxvz/zPYYQuvd7vB2VJZHwlS9aexL2/GPgyDRXoMpI=',NULL,0,'client_clara_060','Client60','client_clara_060@example.com',0,1,'2026-05-23 12:32:11.659383','Clara');
INSERT INTO "auth_user" VALUES(1312,'pbkdf2_sha256$1200000$6MCn70OwAkxgnhQZ6p3ETN$0JUyw14S8frJrPaNfiCZAkGNqsB0zHjHVlNNzxyTcrE=',NULL,0,'client_sofiane_061','Client61','client_sofiane_061@example.com',0,1,'2026-05-23 12:32:12.488310','Sofiane');
INSERT INTO "auth_user" VALUES(1313,'pbkdf2_sha256$1200000$RUtFJs2CxwjlP6NzoovmMe$6MLSmaUxZOwcTRTOx0vZ8Z4NxBgklyx9YZzAcZvdBiw=',NULL,0,'client_camille_062','Client62','client_camille_062@example.com',0,1,'2026-05-23 12:32:13.303943','Camille');
INSERT INTO "auth_user" VALUES(1314,'pbkdf2_sha256$1200000$wo7D27wWP18D2lq0YhxDF4$UZ/UQLiYGvWXLk86N3aA3pvmuFt8rY25xQRdpMwbxu8=',NULL,0,'client_ilias_063','Client63','client_ilias_063@example.com',0,1,'2026-05-23 12:32:14.150007','Ilias');
INSERT INTO "auth_user" VALUES(1315,'pbkdf2_sha256$1200000$kZmScmscim0lZot5CGImV0$qFAofrDKxGyGH8ZuVrUjpOQ6sViNcU3VyIiyrNZLTDM=',NULL,0,'client_zoe_064','Client64','client_zoe_064@example.com',0,1,'2026-05-23 12:32:15.000923','Zoe');
INSERT INTO "auth_user" VALUES(1316,'pbkdf2_sha256$1200000$AvmUmaT3NapWgfDwDVx9l0$HJnKhD3cIDgTGpY5RJpRzEjBBSH3g8c1UImCRgKUr2E=',NULL,0,'client_mathis_065','Client65','client_mathis_065@example.com',0,1,'2026-05-23 12:32:15.831740','Mathis');
INSERT INTO "auth_user" VALUES(1317,'pbkdf2_sha256$1200000$hQzP242PmoWyxegGTuJOwo$oANMpjWFRn0TXeLCCl0pDBE7zPmyR+1i7F3SnjrbF5w=',NULL,0,'client_mila_066','Client66','client_mila_066@example.com',0,1,'2026-05-23 12:32:16.650554','Mila');
INSERT INTO "auth_user" VALUES(1318,'pbkdf2_sha256$1200000$ChFYm1nMQ2oKN81OFmMfEy$c3Jo1+oVrWUrHAZHWOlq6So9Na8Sg3/eGGIbFUGG6s0=',NULL,0,'client_ilyes_067','Client67','client_ilyes_067@example.com',0,1,'2026-05-23 12:32:17.474553','Ilyes');
INSERT INTO "auth_user" VALUES(1319,'pbkdf2_sha256$1200000$AJoFx29qe5b09e8gw4vA9u$IqHyW8ki7tOcxhAZLQvxFL0W1wub906nn+mB3mvd49c=',NULL,0,'client_eva_068','Client68','client_eva_068@example.com',0,1,'2026-05-23 12:32:18.295327','Eva');
INSERT INTO "auth_user" VALUES(1320,'pbkdf2_sha256$1200000$9SRjJO9H8oWuDfPlZHyxVL$7hh+d4ezZgoAzrXZScZG+ZQZIM7pRmIbQZHRKXC7ql0=',NULL,0,'client_arthur_069','Client69','client_arthur_069@example.com',0,1,'2026-05-23 12:32:19.110120','Arthur');
INSERT INTO "auth_user" VALUES(1321,'pbkdf2_sha256$1200000$kwqqifVupG1okdUnnwwJl9$nPQDTBOQNfTSlxl0ShxpJ1K5kS3mDX6Wa32SgXHgYvU=',NULL,0,'client_sana_070','Client70','client_sana_070@example.com',0,1,'2026-05-23 12:32:19.926426','Sana');
INSERT INTO "auth_user" VALUES(1322,'pbkdf2_sha256$1200000$4LFb8eGYoVwIFuXY3xr9YU$06dkE+zF0S90eiEbadwLwxi/M84FIo862je37QPjo4c=',NULL,0,'client_noah_071','Client71','client_noah_071@example.com',0,1,'2026-05-23 12:32:20.739651','Noah');
INSERT INTO "auth_user" VALUES(1323,'pbkdf2_sha256$1200000$JQO2eskWJlVeyVl7QMHy5v$xmjMMcgjVtbtIvJxfuHWm29/ZrT2UQIIJsjJfJX7QdI=',NULL,0,'client_jade_072','Client72','client_jade_072@example.com',0,1,'2026-05-23 12:32:21.548382','Jade');
INSERT INTO "auth_user" VALUES(1324,'pbkdf2_sha256$1200000$jcaz3WYRNC5aLdgHl271bX$uLx6a+6lFoSvaPdRSkgazcBxtOiskobYnrVO19idDnk=',NULL,0,'client_enzo_073','Client73','client_enzo_073@example.com',0,1,'2026-05-23 12:32:22.371737','Enzo');
INSERT INTO "auth_user" VALUES(1325,'pbkdf2_sha256$1200000$YlH2HnDeQCVnZReMavhdmH$7VxjZaTiEACc2bIou36GtChwDfXGb/DSF1Xo1UFzXp4=',NULL,0,'client_mariam_074','Client74','client_mariam_074@example.com',0,1,'2026-05-23 12:32:23.189562','Mariam');
INSERT INTO "auth_user" VALUES(1326,'pbkdf2_sha256$1200000$sOZ0dw5FNypJTXEfv2emad$jhyChunW8SB4oXizgsJBVi5B8NSaOeDQpGlmdXq9XXc=',NULL,0,'client_liam_075','Client75','client_liam_075@example.com',0,1,'2026-05-23 12:32:24.029969','Liam');
INSERT INTO "auth_user" VALUES(1327,'pbkdf2_sha256$1200000$rfV6HFr7GYAAJk3Z1Z7oXm$hKtwYEZvdfaVuE7fdCCK61902IphQuqTI8u+2afOn34=',NULL,0,'client_inesa_076','Client76','client_inesa_076@example.com',0,1,'2026-05-23 12:32:24.843358','Inesa');
INSERT INTO "auth_user" VALUES(1328,'pbkdf2_sha256$1200000$UWbkOxut25UpH6cFO5AoYH$TcpM/luE6/scN+p/nIpTGAoXRSRuL9Hi4YD0+VPbWTo=',NULL,0,'client_louis_077','Client77','client_louis_077@example.com',0,1,'2026-05-23 12:32:25.651977','Louis');
INSERT INTO "auth_user" VALUES(1329,'pbkdf2_sha256$1200000$iVojWjM419b48fkogSCb36$C8P5CBkSEyiXyCyijc+FerCpUJ8/QS1QqSZYBJJEIoE=',NULL,0,'client_maya_078','Client78','client_maya_078@example.com',0,1,'2026-05-23 12:32:26.462352','Maya');
INSERT INTO "auth_user" VALUES(1330,'pbkdf2_sha256$1200000$epaAYAuNk5PJhnfdRGHF4C$bFeaegkZZIxb26Zyzt4cSI38dnQTbPW83l6iYRk1TBA=',NULL,0,'client_ayoub_079','Client79','client_ayoub_079@example.com',0,1,'2026-05-23 12:32:27.286162','Ayoub');
INSERT INTO "auth_user" VALUES(1331,'pbkdf2_sha256$1200000$273Ul0hhw4zmjkVOVVtcnF$WC0Dmg6+sCz2Uqppag/9aZFACD9nfnP0Lq0PlVy6T4w=',NULL,0,'client_anna_080','Client80','client_anna_080@example.com',0,1,'2026-05-23 12:32:28.110835','Anna');
INSERT INTO "auth_user" VALUES(1332,'pbkdf2_sha256$1200000$1AuUjg1b6OZkwbd1VVO1W6$WC//s0dsp5ZK14y98qO5rzQ6/K3piMknet3ZIghP9PI=',NULL,0,'client_adam_081','Client81','client_adam_081@example.com',0,1,'2026-05-23 12:32:28.924150','Adam');
INSERT INTO "auth_user" VALUES(1333,'pbkdf2_sha256$1200000$U5ZtHPZN6Ljh6miX5JCmgQ$ejjbuy6OklHHhUpGU1z/gg9IfCy6H2YSmxzHYlWhBZ0=',NULL,0,'client_sarah_082','Client82','client_sarah_082@example.com',0,1,'2026-05-23 12:32:29.729568','Sarah');
INSERT INTO "auth_user" VALUES(1334,'pbkdf2_sha256$1200000$sNas8pzsfp5kIIWgppkwYc$dJxAFkizgJ5wxPBinEoUy9Y4azfcKe/YEHhzbIcIiNo=',NULL,0,'client_mehdi_083','Client83','client_mehdi_083@example.com',0,1,'2026-05-23 12:32:30.542214','Mehdi');
INSERT INTO "auth_user" VALUES(1335,'pbkdf2_sha256$1200000$rPgX2IP3vI2GxxX917YOCx$bOPuPElRlE9RnA44VVwHRUS/hUE/WKjKU3cBVsVAgsM=',NULL,0,'client_lina_084','Client84','client_lina_084@example.com',0,1,'2026-05-23 12:32:31.353387','Lina');
INSERT INTO "auth_user" VALUES(1336,'pbkdf2_sha256$1200000$GQm9dwrgUhdEChrrApdBpt$vYnkJ1w+kj+BuiXr2KatcH3ikTa9EsYBwxOuWZ2HunQ=',NULL,0,'client_nicolas_085','Client85','client_nicolas_085@example.com',0,1,'2026-05-23 12:32:32.175474','Nicolas');
INSERT INTO "auth_user" VALUES(1337,'pbkdf2_sha256$1200000$N6CDx3Ai05fNHcfjfcjrC7$dtlJ5cRVXAMfNH07KlQ1LXr9Mnn47I9IbnP1p7c4gd4=',NULL,0,'client_emma_086','Client86','client_emma_086@example.com',0,1,'2026-05-23 12:32:33.002686','Emma');
INSERT INTO "auth_user" VALUES(1338,'pbkdf2_sha256$1200000$VJ3GMEdnMlk0zUB2ve7XMO$T/IYaghCnYibwrE/CGGzIUR3zXh9yMxSQ5MuidjWsYk=',NULL,0,'client_yanis_087','Client87','client_yanis_087@example.com',0,1,'2026-05-23 12:32:33.812825','Yanis');
INSERT INTO "auth_user" VALUES(1339,'pbkdf2_sha256$1200000$5kxVzFsLSu32zod8ukN9bh$MhQMZGQXJhT7fKW0B8lZ0aw1M4BbJdgaqthsWidRljw=',NULL,0,'client_julie_088','Client88','client_julie_088@example.com',0,1,'2026-05-23 12:32:34.628570','Julie');
INSERT INTO "auth_user" VALUES(1340,'pbkdf2_sha256$1200000$ZElIKavBF9LdEBr46tvODc$o1cR3ylgjTCUZjocq+a5wemkpXGGVJt6GgXp5DuczAM=',NULL,0,'client_thomas_089','Client89','client_thomas_089@example.com',0,1,'2026-05-23 12:32:35.442809','Thomas');
INSERT INTO "auth_user" VALUES(1341,'pbkdf2_sha256$1200000$FEStkD50gz6egRaGumTJ2H$yPhCrnBe8zBefQmlbYPCHREFlQRIyS1+j/JYW/ZmPyU=',NULL,0,'client_ines_090','Client90','client_ines_090@example.com',0,1,'2026-05-23 12:32:36.259492','Ines');
INSERT INTO "auth_user" VALUES(1342,'pbkdf2_sha256$1200000$FBWyLov4zHbezrLMl00HW7$9RjbWQBVVnpXgu54qfaQSgMANnOuAfRFbNcsNLeaSx4=',NULL,0,'client_samir_091','Client91','client_samir_091@example.com',0,1,'2026-05-23 12:32:37.080387','Samir');
INSERT INTO "auth_user" VALUES(1343,'pbkdf2_sha256$1200000$jWzNhawUDUIKQhqHgU6N3W$IEwp8NjYpJPVrVuoUfZpTst4d8AGt7Y+VuINLNEA0jo=',NULL,0,'client_lucie_092','Client92','client_lucie_092@example.com',0,1,'2026-05-23 12:32:37.902079','Lucie');
INSERT INTO "auth_user" VALUES(1344,'pbkdf2_sha256$1200000$xu3JgrlHhqk4p3aug4yiH5$Y68zdahqPAMmJcXymt8RsYYI8yYeEsE3oyVR88vMv2Q=',NULL,0,'client_maxime_093','Client93','client_maxime_093@example.com',0,1,'2026-05-23 12:32:38.720082','Maxime');
INSERT INTO "auth_user" VALUES(1345,'pbkdf2_sha256$1200000$qLLv2gJEJ2uf2sfp0MWI9B$H53Hi9VJK7Kxt7YBF8ifNbxyGRJL45cOlch6KnyJ39Y=',NULL,0,'client_nora_094','Client94','client_nora_094@example.com',0,1,'2026-05-23 12:32:39.528354','Nora');
INSERT INTO "auth_user" VALUES(1346,'pbkdf2_sha256$1200000$UOXUmH1jko8Ar4IqthQS0k$7mlT/JU3vzU22hAuoWZsA4Kf1RWNssydeXyiZJ+hHFA=',NULL,0,'client_quentin_095','Client95','client_quentin_095@example.com',0,1,'2026-05-23 12:32:40.340168','Quentin');
INSERT INTO "auth_user" VALUES(1347,'pbkdf2_sha256$1200000$w7eVFOoijfXEtWwWHwPsR6$3LuQxyw9WHoRhMny6aukRZah/C04hppPFO4f//gzPws=',NULL,0,'client_amina_096','Client96','client_amina_096@example.com',0,1,'2026-05-23 12:32:41.151987','Amina');
INSERT INTO "auth_user" VALUES(1348,'pbkdf2_sha256$1200000$oRgk0j0R4YsvqDXviCKzsc$JR5XIMkA2DJt19jb4zT1B4B2ApH4lwUF1H77p4VwnUI=',NULL,0,'client_hugo_097','Client97','client_hugo_097@example.com',0,1,'2026-05-23 12:32:41.965735','Hugo');
INSERT INTO "auth_user" VALUES(1349,'pbkdf2_sha256$1200000$bWVkd3PoCtcgvLZ4RNoerF$8AYPAMQL3zIEgsX19rVaI91sdGhfRjh2OlGCfg9PEG4=',NULL,0,'client_lea_098','Client98','client_lea_098@example.com',0,1,'2026-05-23 12:32:42.795515','Lea');
INSERT INTO "auth_user" VALUES(1350,'pbkdf2_sha256$1200000$tQZZI2wbyLXicyjbzt8Q1o$81yLGHYQl2Ehraf2854mzwxSvNwUPujUSGdkb7aIM9c=',NULL,0,'client_karim_099','Client99','client_karim_099@example.com',0,1,'2026-05-23 12:32:43.611035','Karim');
INSERT INTO "auth_user" VALUES(1351,'pbkdf2_sha256$1200000$c7nl3ia5byq6tpn0J7zc0S$rft3t+EVwA+hqvvFAZa7icllWkjGf8vU7IzSJGoKWxs=',NULL,0,'client_clara_100','Client100','client_clara_100@example.com',0,1,'2026-05-23 12:32:44.416867','Clara');
INSERT INTO "auth_user" VALUES(1352,'pbkdf2_sha256$1200000$e0HLWSrJ84lwyR6elQC70R$ooo+l2gbS0z/Wi6D5CvKGfwKSabsMzdWEvZ0Nfqwujk=',NULL,0,'client_sofiane_101','Client101','client_sofiane_101@example.com',0,1,'2026-05-23 12:32:45.235485','Sofiane');
INSERT INTO "auth_user" VALUES(1353,'pbkdf2_sha256$1200000$MnDsWb0kutUt9mr4Le7j8V$GGXw/ASPTnlwipDGNY4wX7ASZzsLxdDiKAQtPp7X4Zo=',NULL,0,'client_camille_102','Client102','client_camille_102@example.com',0,1,'2026-05-23 12:32:46.050319','Camille');
INSERT INTO "auth_user" VALUES(1354,'pbkdf2_sha256$1200000$TVXpBR7psbGUF8XrAeQuVU$6PX5ofs9DMiZd0XwgjpSExk6X3uBrLJB+sn6xjvnOxQ=',NULL,0,'client_ilias_103','Client103','client_ilias_103@example.com',0,1,'2026-05-23 12:32:46.870737','Ilias');
INSERT INTO "auth_user" VALUES(1355,'pbkdf2_sha256$1200000$OVWWCVlUGiAvQbg4VfFL5B$jzEPoSRHnjbhdZW0xJt3gTNWPROTblBIULijrvO1gdU=',NULL,0,'client_zoe_104','Client104','client_zoe_104@example.com',0,1,'2026-05-23 12:32:47.698950','Zoe');
INSERT INTO "auth_user" VALUES(1356,'pbkdf2_sha256$1200000$rDGBNWx17NzxsCZs8qOFGu$2B6Wvoin75iieqsCmN9FpAVp/fAsP17qGDrsIegRq0c=',NULL,0,'client_mathis_105','Client105','client_mathis_105@example.com',0,1,'2026-05-23 12:32:48.514118','Mathis');
INSERT INTO "auth_user" VALUES(1357,'pbkdf2_sha256$1200000$KSWZJCjAoLqNy97XSiKOHA$QBDu+oIXUkpm1Uxcl/+q6I4g1BAjKb3ljyayJyzHgRc=',NULL,0,'client_mila_106','Client106','client_mila_106@example.com',0,1,'2026-05-23 12:32:49.324837','Mila');
INSERT INTO "auth_user" VALUES(1358,'pbkdf2_sha256$1200000$X2BsfFnr4al8UtObbKEoLt$R9woLX7hgLL4xX//u4MXYW6N/27rhb7qmA+j/6gveNg=',NULL,0,'client_ilyes_107','Client107','client_ilyes_107@example.com',0,1,'2026-05-23 12:32:50.139767','Ilyes');
INSERT INTO "auth_user" VALUES(1359,'pbkdf2_sha256$1200000$APcR9Rf7wNk4ksvhe8W7ty$3i+YBJyDfwBFdAclypMbYndgw0KlcGDvuseW2D4RgfI=',NULL,0,'client_eva_108','Client108','client_eva_108@example.com',0,1,'2026-05-23 12:32:50.964646','Eva');
INSERT INTO "auth_user" VALUES(1360,'pbkdf2_sha256$1200000$PVOWs6o7PylUnCAzNr7Mav$cCmT6rTe9jkIge1/9nHEcMkCc9FEwlLfqjIVUQK2rMo=',NULL,0,'client_arthur_109','Client109','client_arthur_109@example.com',0,1,'2026-05-23 12:32:51.785870','Arthur');
INSERT INTO "auth_user" VALUES(1361,'pbkdf2_sha256$1200000$TnsoZKWxrRItSMww5zY8E1$+KjlNvF5GueAdjKX6ChvcE/y3Bly5HNfdFNjZmMvPeo=',NULL,0,'client_sana_110','Client110','client_sana_110@example.com',0,1,'2026-05-23 12:32:52.617367','Sana');
INSERT INTO "auth_user" VALUES(1362,'pbkdf2_sha256$1200000$hRpGRMxhJLS1DX92ZMTGIZ$l8cg+7JnzIDrHTDbxbp5SJbhp/e8M2Hq/ZRFHW9MeUQ=',NULL,0,'client_noah_111','Client111','client_noah_111@example.com',0,1,'2026-05-23 12:32:53.429870','Noah');
INSERT INTO "auth_user" VALUES(1363,'pbkdf2_sha256$1200000$4HXsvaSCAKfHFYoPqboDNx$AxRCSuJ9Gx6fE1g1pD0UNBaktyJNnV98Qt6Pe15Ny24=',NULL,0,'client_jade_112','Client112','client_jade_112@example.com',0,1,'2026-05-23 12:32:54.239825','Jade');
INSERT INTO "auth_user" VALUES(1364,'pbkdf2_sha256$1200000$jCix2mY6zUZYJwUklsmYHG$G2PnoYDmD4LYKZp9cAleJ9naLghxDH10e99a+V4VANA=',NULL,0,'client_enzo_113','Client113','client_enzo_113@example.com',0,1,'2026-05-23 12:32:55.051661','Enzo');
INSERT INTO "auth_user" VALUES(1365,'pbkdf2_sha256$1200000$YcUbVfLn30kphGdHd7KHLH$rROCgxrfTUVYZKPRqgJAFN7OlI/zuUdP9btLeZ5keSQ=',NULL,0,'client_mariam_114','Client114','client_mariam_114@example.com',0,1,'2026-05-23 12:32:55.867985','Mariam');
INSERT INTO "auth_user" VALUES(1366,'pbkdf2_sha256$1200000$WhKymoGS6emCniaoqB6Aui$My/9pzHusFHHJl3TMkWG3rlLeb38y2NQo7jlNR+qF3Q=',NULL,0,'client_liam_115','Client115','client_liam_115@example.com',0,1,'2026-05-23 12:32:56.678119','Liam');
INSERT INTO "auth_user" VALUES(1367,'pbkdf2_sha256$1200000$4fbc7Qhbooviu7iNlBuXlL$5tL//kAHlxE+aTKsrYVYHPMVSTt3BN0eigguY0r0nYo=',NULL,0,'client_inesa_116','Client116','client_inesa_116@example.com',0,1,'2026-05-23 12:32:57.506546','Inesa');
INSERT INTO "auth_user" VALUES(1368,'pbkdf2_sha256$1200000$yNe0cZ77wsgsv2YbpEdvqP$b9Jo1uRADy3d32PtC4GBHuxs/hzS3f8EH1EDoXblsys=',NULL,0,'client_louis_117','Client117','client_louis_117@example.com',0,1,'2026-05-23 12:32:58.321553','Louis');
INSERT INTO "auth_user" VALUES(1369,'pbkdf2_sha256$1200000$2yKT9vBOQnaPMXvWeJDG8K$m7ekI8gjEv6avtPHAOdMumizmXPdxK/KXyHX76bQZeg=',NULL,0,'client_maya_118','Client118','client_maya_118@example.com',0,1,'2026-05-23 12:32:59.135202','Maya');
INSERT INTO "auth_user" VALUES(1370,'pbkdf2_sha256$1200000$DhqGIzUg841MDH7YFvOcok$tkm8N3t9fLLb9ALZxEYrXb/nRQ4CV4vGdZfMMKsygCg=',NULL,0,'client_ayoub_119','Client119','client_ayoub_119@example.com',0,1,'2026-05-23 12:32:59.946902','Ayoub');
INSERT INTO "auth_user" VALUES(1371,'pbkdf2_sha256$1200000$MmULjTUcPsflvfdhWZH7Ej$+3+O7pQbg5KkBuJHUbpDkf4mhGd9ID6JuSL9rDTYiB8=',NULL,0,'client_anna_120','Client120','client_anna_120@example.com',0,1,'2026-05-23 12:33:00.763037','Anna');
INSERT INTO "auth_user" VALUES(1372,'pbkdf2_sha256$1200000$NFAoT48cKLzg3jVpsQrEF9$jTvSTW6ywmtJCWklQ9aKVMyw/ftEdePh5Bgw6NpGMT4=','2026-08-23 15:13:46.556300',0,'Younes','','younes@multidrive.local',0,1,'2026-05-23 13:29:24.671052','');
INSERT INTO "auth_user" VALUES(1373,'pbkdf2_sha256$1200000$MlUBaxmV4JDo1XYqQcTe0X$a5sO+6jBSM56HwCnhHk4h44qGKmk0FhmJUtLmP+Npa0=','2026-08-14 10:30:01.433692',0,'Phillipe','','philippe@hotmail.com',0,1,'2026-06-12 10:55:02.243291','');
INSERT INTO "auth_user" VALUES(1374,'pbkdf2_sha256$1200000$iF0YnnSpIaUoD2nCR7rxcJ$eGqCpBmOaSGGtH76GHoinne7cQEOtdNLrd7BvbRdd4I=','2026-08-16 19:24:28.028181',0,'Jean_sebastien','','younesmala124@gmail.com',0,1,'2026-06-18 16:11:22.944170','');
INSERT INTO "auth_user" VALUES(1375,'pbkdf2_sha256$1200000$mBtYqB7Exvbo6yiNJS3eZ3$TDZZPdBdTBhJr6oYfDosTdFppWkB84qBUoUqzhhODo8=','2026-08-23 15:13:26.969739',0,'admin_Sohaib','','younesplay35@gmail.com',1,1,'2026-08-07 12:17:39.088904','');
INSERT INTO "auth_user" VALUES(1376,'pbkdf2_sha256$1200000$qksvfVFKW1ramMeTgs36Hm$24AjO0yXOKf8MfsgbcaEYobJmW+EbQz+yNHJ33a9jOU=',NULL,0,'hist_del_001','Martin','lucas.martin@tempmail.be',0,0,'2026-08-10 18:27:00.008514','Lucas');
INSERT INTO "auth_user" VALUES(1377,'pbkdf2_sha256$1200000$Tl3t6sSIU5GwqOznu4rs1M$Sk5oNdxOMlN4MI7r6Hkc9Lp9iXWVPfoGE1+JWxxlvtU=',NULL,0,'hist_del_002','Bouazza','amina.bouazza@tempmail.be',0,0,'2026-08-10 18:27:01.623666','Amina');
INSERT INTO "auth_user" VALUES(1378,'pbkdf2_sha256$1200000$Wii2fwbR9cdFYiPcigrMCO$GJsGdsJVg2mm6KPY8EGL/1MhjKXCtQ7QkjXdbp+fIs4=',NULL,0,'hist_del_003','Renard','thomas.renard@tempmail.be',0,0,'2026-08-10 18:27:02.977836','Thomas');
INSERT INTO "auth_user" VALUES(1379,'pbkdf2_sha256$1200000$lDjwVXParSV5E8WsavQXU3$KsgyTC4tZl3QPLeYN7jFXmfCZ7ZveRw6DOniej1TN7I=',NULL,0,'hist_del_004','Diallo','fatou.diallo@tempmail.be',0,0,'2026-08-10 18:27:04.345267','Fatou');
INSERT INTO "auth_user" VALUES(1380,'pbkdf2_sha256$1200000$3lF8AWuQwlOni3HwFnLMav$Xy7IqZM997rv0whqxmq6SfaEWMdM7VgmQ4rVKz80b8w=',NULL,0,'hist_del_005','Lefevre','romain.lefevre@tempmail.be',0,0,'2026-08-10 18:27:05.585823','Romain');
INSERT INTO "auth_user" VALUES(1381,'pbkdf2_sha256$1200000$W4qh6KCf7fBN6VxFlST4Za$3pQduKufH/s2TkYKbI1WgXfgyu0R8pWPevbToZCb8i8=',NULL,0,'hist_del_006','Okonkwo','sara.okonkwo@tempmail.be',0,0,'2026-08-10 18:27:06.952835','Sara');
INSERT INTO "auth_user" VALUES(1382,'pbkdf2_sha256$1200000$mmOHylRY7dDLswF2RcIFJa$kwHB0+u3cbGM9KbVpXpwuCRV/1mOBGxhbe8EGpwjvmc=',NULL,0,'hist_del_007','Ferrari','matteo.ferrari@tempmail.be',0,0,'2026-08-10 18:27:08.330983','Matteo');
INSERT INTO "auth_user" VALUES(1383,'pbkdf2_sha256$1200000$LbBopMZOf2bsFFq6XMnN1j$5m5riE0c4nLkKdW2t63lWRSpRbb11TzPcefl0lBRFec=',NULL,0,'hist_del_008','Dupont','chloe.dupont@tempmail.be',0,0,'2026-08-10 18:27:09.651064','Chloe');
INSERT INTO "auth_user" VALUES(1384,'pbkdf2_sha256$1200000$NpjFiIjpJSancZXTRuuzl1$aOg9BNY1PkSsMmwyxzyibqezeUtOZb0ZsfTgP/aVvpw=',NULL,0,'hist_del_009','Benali','karim.benali@tempmail.be',0,0,'2026-08-10 18:27:11.050800','Karim');
INSERT INTO "auth_user" VALUES(1385,'pbkdf2_sha256$1200000$dkTYnZNNWkfHUoVZMzlJgH$cKFmxJDw2S+RFcp9DbPaUcSQQC/k9+06x1DGMc8+XOY=',NULL,0,'hist_del_010','Schmitt','eva.schmitt@tempmail.be',0,0,'2026-08-10 18:27:12.385472','Eva');
INSERT INTO "auth_user" VALUES(1386,'pbkdf2_sha256$1200000$5eBlvYArQuwxbBduoQ09Y1$M/ASDeBrIn/nOALPSb0bXvH3YkPGbj3Ffrmxon9nJ38=',NULL,0,'hist_del_011','Jacobs','nathan.jacobs@tempmail.be',0,0,'2026-08-10 18:27:13.816661','Nathan');
INSERT INTO "auth_user" VALUES(1387,'pbkdf2_sha256$1200000$5SpuAnr27s0x2hTixLghGu$UWEIO5DqBVZ2UoX267MfrsQ4MFUh3lOvZ23YNaW5e0Y=',NULL,0,'hist_del_012','Nair','priya.nair@tempmail.be',0,0,'2026-08-10 18:27:15.193122','Priya');
INSERT INTO "auth_user" VALUES(1388,'pbkdf2_sha256$1200000$urOtB6QKyfHiLfq9EUfrVh$0ulAmoECO0K7WTUDAFPEqHDxhqfxTLtCrbtVlLIJwVc=',NULL,0,'hist_cancel_001','','hist_cancel_001@tempmail.be',0,1,'2026-08-10 18:27:16.491712','');
INSERT INTO "auth_user" VALUES(1389,'pbkdf2_sha256$1200000$yrVPDu9AsMDQa9pCVuFQSM$jcYtA2rJToT31Go9J1Rc0NV40dzDQN4Av93l3uJT7js=',NULL,0,'hist_cancel_002','','hist_cancel_002@tempmail.be',0,1,'2026-08-10 18:27:17.885316','');
INSERT INTO "auth_user" VALUES(1390,'pbkdf2_sha256$1200000$DqtwIbThABRBsupweyADL2$xs+ANBxHz7F6ypmVyY1oECM/16E3tOQExyGcEUMMqPU=',NULL,0,'hist_cancel_003','','hist_cancel_003@tempmail.be',0,1,'2026-08-10 18:27:19.215648','');
INSERT INTO "auth_user" VALUES(1391,'pbkdf2_sha256$1200000$fpiM4G59Px8qsUnrybUmF4$XTVtnyqYiz5mi7lAaPVqFRN3DI7GZvI+gWwg515eDLQ=',NULL,0,'hist_cancel_004','','hist_cancel_004@tempmail.be',0,1,'2026-08-10 18:27:20.603777','');
INSERT INTO "auth_user" VALUES(1392,'pbkdf2_sha256$1200000$I0SJXNUpdEpJSBaTleGYzS$SmTLaAdUKXaGAWyGsaZ0IoItKKJNd3f1np8kau7jaq4=',NULL,0,'hist_cancel_005','','hist_cancel_005@tempmail.be',0,1,'2026-08-10 18:27:22.023492','');
INSERT INTO "auth_user" VALUES(1393,'pbkdf2_sha256$1200000$8OvVI3ArdYLRvQi0KBCsq5$qAc+6CvvikpDu0h31YdtdfRaH4SN79VhSzWhogMuqrQ=',NULL,0,'hist_cancel_006','','hist_cancel_006@tempmail.be',0,1,'2026-08-10 18:27:23.440066','');
INSERT INTO "auth_user" VALUES(1394,'pbkdf2_sha256$1200000$WE2iQtIRkGdeRUhQMv4HZh$/gf2qva7a38u8iC4bhtTUs+FOZsO36pSLoDfWpRnd5o=',NULL,0,'hist_cancel_007','','hist_cancel_007@tempmail.be',0,1,'2026-08-10 18:27:24.724038','');
INSERT INTO "auth_user" VALUES(1395,'pbkdf2_sha256$1200000$wP6n9UcIgEm2S7tOeOhVZE$5AKfEm+LeiLEmBJzzgGl4Ino4YV2i786z92GZlybXXQ=',NULL,0,'hist_cancel_008','','hist_cancel_008@tempmail.be',0,1,'2026-08-10 18:27:26.059206','');
INSERT INTO "auth_user" VALUES(1396,'pbkdf2_sha256$1200000$FgiNaeRzOvnLzwGIxW02Oj$RBM+a7cBueAv3mIhRfSZnJaE1wm/EtS3H5kHqV0rmVE=',NULL,0,'hist_cancel_009','','hist_cancel_009@tempmail.be',0,1,'2026-08-10 18:27:27.409187','');
INSERT INTO "auth_user" VALUES(1397,'pbkdf2_sha256$1200000$F1zqulwZpttNvzMCJYwUcG$QQOmMjAWm8SbJje/7r1Y72WyOfcsyCtUIMssj3Q0laA=',NULL,0,'hist_cancel_010','','hist_cancel_010@tempmail.be',0,1,'2026-08-10 18:27:28.913634','');
INSERT INTO "auth_user" VALUES(1398,'pbkdf2_sha256$1200000$Z2ZJNo3Tcx0WppNnXVr0jd$i+GDIJxv3GrMkXha45nTkMy3uHmxKP+26nG1vPRIVh4=',NULL,0,'hist_cancel_011','','hist_cancel_011@tempmail.be',0,1,'2026-08-10 18:27:30.252286','');
INSERT INTO "auth_user" VALUES(1399,'pbkdf2_sha256$1200000$7WeUyt6h7mjatwIWjHVVRW$xsS62Fyb5Qy1eYzPArqCAVe/Fss38102vylfBnCxbOM=',NULL,0,'hist_cancel_012','','hist_cancel_012@tempmail.be',0,1,'2026-08-10 18:27:31.528021','');
INSERT INTO "auth_user" VALUES(1400,'pbkdf2_sha256$1200000$0rKxmEo0IiZxP19cEMlwDe$vPrToQTAAbdra5xlyei45eGD/RszSxjuC6IWWOyDxV0=',NULL,0,'hist_refund_001','','hist_refund_001@tempmail.be',0,1,'2026-08-10 18:27:32.841600','');
INSERT INTO "auth_user" VALUES(1401,'pbkdf2_sha256$1200000$JfZYQoNoOQxBVTYfQmUQ2a$ceS+o57fKJT9Ov8/WFDkL56YAe74S66bA/VpcEatqg0=',NULL,0,'hist_refund_002','','hist_refund_002@tempmail.be',0,1,'2026-08-10 18:27:34.147430','');
INSERT INTO "auth_user" VALUES(1402,'pbkdf2_sha256$1200000$4TEccIcU8lov2QrWVYNXEQ$PbmqiHFatDfIYtTZZ8SqRSIroq0DhDckpeqS44DAWpo=',NULL,0,'hist_refund_003','','hist_refund_003@tempmail.be',0,1,'2026-08-10 18:27:35.524078','');
INSERT INTO "auth_user" VALUES(1403,'pbkdf2_sha256$1200000$7AeXoBnkw70ZTPgD8jeNKy$nsDA/DdQnZDl1q55zkmSYr35QOKzmn81Rf0h2jmfhKQ=',NULL,0,'hist_refund_004','','hist_refund_004@tempmail.be',0,1,'2026-08-10 18:27:36.966932','');
INSERT INTO "auth_user" VALUES(1404,'pbkdf2_sha256$1200000$I1qvRBH7NncQ2ZkFGg71Zr$gPyaaVXTllm57ynbEONc50dE8n06VResRQBcGej78Yw=',NULL,0,'hist_refund_005','','hist_refund_005@tempmail.be',0,1,'2026-08-10 18:27:38.338549','');
INSERT INTO "auth_user" VALUES(1405,'pbkdf2_sha256$1200000$REn1DsY7xiHslA7ZDKQ2Kx$yU7xyX9x0NuRDWgHnSuSrMFNpTn2QDAttka4u5kilrM=',NULL,0,'hist_refund_006','','hist_refund_006@tempmail.be',0,1,'2026-08-10 18:27:39.742584','');
INSERT INTO "auth_user" VALUES(1406,'pbkdf2_sha256$1200000$IGrkfYIJX8EukBS433McxV$zpMdsZW5s41kltF8B4X0lISh1fw6xwEH+0c2Lk3TZpA=',NULL,0,'hist_refund_007','','hist_refund_007@tempmail.be',0,1,'2026-08-10 18:27:41.018719','');
INSERT INTO "auth_user" VALUES(1407,'pbkdf2_sha256$1200000$w8xWKbUoqqL3wQNbmETqZ3$Sa4HP5kCeRAEU7r9/3KZEsgHWcDJ8kg0IKYgaoEtuC4=',NULL,0,'hist_refund_008','','hist_refund_008@tempmail.be',0,1,'2026-08-10 18:27:42.350974','');
INSERT INTO "auth_user" VALUES(1408,'pbkdf2_sha256$1200000$W5QbzcDBz5DwEfM726gNwb$36B8JTnRoKJsiJm5vUAH72szHhL3574hZ3ar3d6jPi4=',NULL,0,'hist_refund_009','','hist_refund_009@tempmail.be',0,1,'2026-08-10 18:27:43.762932','');
INSERT INTO "auth_user" VALUES(1409,'pbkdf2_sha256$1200000$WGteY7hENvmhLdIBOtv3o5$AuWtaV2CwXzQNhKuOJrbpfrgN04Fjc3zgBRiMDBQ2es=',NULL,0,'hist_refund_010','','hist_refund_010@tempmail.be',0,1,'2026-08-10 18:27:45.022550','');
INSERT INTO "auth_user" VALUES(1410,'pbkdf2_sha256$1200000$zcxW1UIpLyCMez2AF7opYG$EU3+sRkwtSIZpLJREuy9Iv976QpXwNr0h7+hwjqJVRc=',NULL,0,'hist_hidden_001','','hist_hidden_001@tempmail.be',0,1,'2026-08-10 18:27:46.437346','');
INSERT INTO "auth_user" VALUES(1411,'pbkdf2_sha256$1200000$N1toghhThIyhWo62VKJ3JG$RkEZhPduJfEa6bnbIWHNc6ZRF7STdH7NdmOYRpNpE98=',NULL,0,'hist_hidden_002','','hist_hidden_002@tempmail.be',0,1,'2026-08-10 18:27:47.713620','');
INSERT INTO "auth_user" VALUES(1412,'pbkdf2_sha256$1200000$0czXPpz2aHwVr5hv4bOBJy$fA7VhZLgUk7l6lXfbvFO9lyC/9BGLEbBVX01MC0nHDc=',NULL,0,'hist_hidden_003','','hist_hidden_003@tempmail.be',0,1,'2026-08-10 18:27:49.034199','');
INSERT INTO "auth_user" VALUES(1413,'pbkdf2_sha256$1200000$dpHjgwGAoZh4SX1O3iWtgk$JRzRW6ZLNOlkYH6dA2znz208LMFWico+hj1Q+orO4MY=',NULL,0,'hist_hidden_004','','hist_hidden_004@tempmail.be',0,1,'2026-08-10 18:27:50.388576','');
INSERT INTO "auth_user" VALUES(1414,'pbkdf2_sha256$1200000$svZitsDpXmCEqOYUYLv5dr$KOnodsvCTUYW1DqkJ6W7AF6CIWBynvufoQIW9+sUphQ=',NULL,0,'hist_hidden_005','','hist_hidden_005@tempmail.be',0,1,'2026-08-10 18:27:51.664750','');
INSERT INTO "auth_user" VALUES(1415,'pbkdf2_sha256$1200000$hfI8F3RABYIcYOdI3snMYj$EuX2eFEzj8BXHW2vvw2htdhr3OVPwYWsnGP9D2XMH7M=',NULL,0,'hist_hidden_006','','hist_hidden_006@tempmail.be',0,1,'2026-08-10 18:27:52.947661','');
INSERT INTO "auth_user" VALUES(1416,'pbkdf2_sha256$1200000$4cOf2VGa9aghhx77lID1tl$kva3ty6cyhdAHtgIWjSB+Jnv5ago1cz992U4xdMkwXw=',NULL,0,'hist_hidden_007','','hist_hidden_007@tempmail.be',0,1,'2026-08-10 18:27:54.312267','');
INSERT INTO "auth_user" VALUES(1417,'pbkdf2_sha256$1200000$rd6FK35fkDGqqLrG9cdTH2$c3fKsqYzGo2fB1R2QpihVD5nT1HoLVqZf0T4R0zXQU8=',NULL,0,'hist_hidden_008','','hist_hidden_008@tempmail.be',0,1,'2026-08-10 18:27:55.733747','');
INSERT INTO "auth_user" VALUES(1418,'pbkdf2_sha256$1200000$5USAB2th1oYWqPPyNkBdmD$jR1o7i+pe1OgOcaSqSc6RB3dsZ6bYr2pQ7qYmk1+KV4=',NULL,0,'hist_hidden_009','','hist_hidden_009@tempmail.be',0,1,'2026-08-10 18:27:57.056029','');
INSERT INTO "auth_user" VALUES(1419,'pbkdf2_sha256$1200000$4Cv0KH432Jq2rkz1vclQNp$bXwLfWBeoONAhOhmXyIDV35CE87uB4OrcwR76KEHXA4=',NULL,0,'hist_hidden_010','','hist_hidden_010@tempmail.be',0,1,'2026-08-10 18:27:58.448864','');
INSERT INTO "auth_user" VALUES(1420,'pbkdf2_sha256$1200000$xqvGWvCtbiYxeX3mztmSKY$39B+fkIZLjjvtARL8kGfrVSzMzUsSNhbJQTe2XgQxi0=',NULL,0,'hist_hidden_011','','hist_hidden_011@tempmail.be',0,1,'2026-08-10 18:27:59.901791','');
INSERT INTO "auth_user" VALUES(1421,'pbkdf2_sha256$1200000$mvD3j4Stlgq87G0AzWyMY4$0MWmn7eSIfFiF+FyYegbgsoei7aknk0qGiVKPraAyfQ=',NULL,0,'hist_hidden_012','','hist_hidden_012@tempmail.be',0,1,'2026-08-10 18:28:01.285296','');
INSERT INTO "auth_user" VALUES(1422,'pbkdf2_sha256$1200000$1h8fpNu3q9VpIGwy20O3nE$iqKSrvKCb3imWLsxspAJIa3utp0O3kNf0zsJNLuxKUw=',NULL,0,'test_emma_dupont','Dupont','emma.dupont@testmail.be',0,1,'2026-08-13 09:29:09.866707','Emma');
INSERT INTO "auth_user" VALUES(1423,'pbkdf2_sha256$1200000$rtze2EBdQAnP7V020OFOrg$K815TJNebZKbo1bSH0Pq2lgCqc/9TyZQqUjcvrFdXUw=',NULL,0,'test_noah_martin','Martin','noah.martin@testmail.be',0,1,'2026-08-13 09:29:11.107197','Noah');
INSERT INTO "auth_user" VALUES(1424,'pbkdf2_sha256$1200000$oWhdzHAtXBW5JNiHTHIIew$f9G/Cue8ITPkW8LvnqB5q1BfhIUMk7A/eXfUKOIgOIo=',NULL,0,'test_lena_bernard','Bernard','lena.bernard@testmail.be',0,1,'2026-08-13 09:29:12.307522','Lena');
INSERT INTO "auth_user" VALUES(1425,'pbkdf2_sha256$1200000$OPwjZMEPdKPX3hYPpGOKlc$oEEg8l+ZUkk1KcbdPsqHUs73IEs3GBf+QweLHbC3VPA=',NULL,0,'test_hugo_leroy','Leroy','hugo.leroy@testmail.be',0,1,'2026-08-13 09:29:13.570785','Hugo');
INSERT INTO "auth_user" VALUES(1426,'pbkdf2_sha256$1200000$gRdxI7jfUluDuphjbQAgd7$5VFoioiV1QmxU3O0pW0IWhBftw70ooubDscLFVwMnx0=',NULL,0,'test_chloe_simon','Simon','chloe.simon@testmail.be',0,1,'2026-08-13 09:29:14.794805','Chloe');
INSERT INTO "auth_user" VALUES(1427,'pbkdf2_sha256$1200000$kMsyPIZAB7waL5xV9lZ1Ci$s5BjFjx9vLIvbtxrerh2C+plYUVsdV5xn2G7r8d/wA4=',NULL,0,'test_lucas_petit','Petit','lucas.petit@testmail.be',0,1,'2026-08-13 09:29:16.104575','Lucas');
INSERT INTO "auth_user" VALUES(1428,'pbkdf2_sha256$1200000$zZO8CGXp229SzkQuR6gPHm$i2c6ykGsutJ5W2T+Irb9TxqtCx0PgjiHNFqUscoNo7Y=',NULL,0,'test_manon_roux','Roux','manon.roux@testmail.be',0,1,'2026-08-13 09:29:17.348205','Manon');
INSERT INTO "auth_user" VALUES(1429,'pbkdf2_sha256$1200000$sSOpIlAV7IH8bRKiROzGo9$s9rR2tnAbaJjgNy4uPXW/aekfn/Lv1BMxD6gu8cUMe0=',NULL,0,'test_theo_moreau','Moreau','theo.moreau@testmail.be',0,1,'2026-08-13 09:29:18.648050','Theo');
INSERT INTO "auth_user" VALUES(1430,'pbkdf2_sha256$1200000$FniP2XRwRslWEOHjUjFZWQ$xwMVivq81mt3imnD6SCqOEYzMAyP0IrKvR80xpIRXIc=',NULL,0,'test_jade_thomas','Thomas','jade.thomas@testmail.be',0,1,'2026-08-13 09:29:19.857558','Jade');
INSERT INTO "auth_user" VALUES(1431,'pbkdf2_sha256$1200000$nEySiGn1dWi643FLPeQHwD$px4sSUlcJEVLkur1XCNrpXu6VTI3ADnfqDlpE7TMcAY=',NULL,0,'test_arthur_adam','Adam','arthur.adam@testmail.be',0,1,'2026-08-13 09:29:21.076995','Arthur');
INSERT INTO "auth_user" VALUES(1432,'pbkdf2_sha256$1200000$nos7fiUCMNmUYpib012yW0$1SHarXDBfzECDT8ml4oaWs4VRXIBQ+cbhARpakRnUSU=',NULL,0,'test_lea_richard','Richard','lea.richard@testmail.be',0,1,'2026-08-13 09:29:22.398219','Lea');
INSERT INTO "auth_user" VALUES(1433,'pbkdf2_sha256$1200000$YAUO6bFPjMqMMzi8UtFDMh$Yafz+9qV/pu9liAMUle/fHlgNUXc4GkZ6uhMssryYwA=',NULL,0,'test_ethan_david','David','ethan.david@testmail.be',0,1,'2026-08-13 09:29:23.744737','Ethan');
INSERT INTO "auth_user" VALUES(1434,'pbkdf2_sha256$1200000$f1oUiBFicUsPY5nTv6ZUgh$JkF4HT1p4ISlvSYc0sydbpaPARQw18qd725CnhSjbrc=',NULL,0,'test_ines_robert','Robert','ines.robert@testmail.be',0,1,'2026-08-13 09:29:24.967930','Ines');
INSERT INTO "auth_user" VALUES(1435,'pbkdf2_sha256$1200000$M03titdTcAgOe8Sxxi3G0N$nqTsC2a0k+Xtwzytwbt9Bby2+iK4FoA0gCoF+oBCSWY=',NULL,0,'test_axel_durand','Durand','axel.durand@testmail.be',0,1,'2026-08-13 09:29:26.365774','Axel');
INSERT INTO "auth_user" VALUES(1436,'pbkdf2_sha256$1200000$LxhSfVtyFi5sa9S15I9amp$FltKX1gQpI85Rtf5/kLgnzeQL6HBdozqmFxLNRt7DzM=',NULL,0,'test_alice_blanc','Blanc','alice.blanc@testmail.be',0,1,'2026-08-13 09:29:27.724914','Alice');
INSERT INTO "auth_user" VALUES(1437,'pbkdf2_sha256$1200000$MRnxUQvhnyXXLNaKVMRf8S$00yUE4Y5ny6xe0exbimKMFX7YVAXxKNn1e9ZC4pr3nQ=',NULL,0,'test_tom_garcia','Garcia','tom.garcia@testmail.be',0,1,'2026-08-13 09:29:28.959225','Tom');
INSERT INTO "auth_user" VALUES(1438,'pbkdf2_sha256$1200000$FwrKJJsazihvo4VZAr3T6W$/NHgzXTmUS+Lw3h9goPUdbNTGnCVOHlYwcwKxtjbW0E=',NULL,0,'test_zoe_pierre','Pierre','zoe.pierre@testmail.be',0,1,'2026-08-13 09:29:30.213336','Zoe');
INSERT INTO "auth_user" VALUES(1439,'pbkdf2_sha256$1200000$ZSQej2yUSCvC2w0nBJJwYo$Dtt0Aqk4MLjTUlU/TkVsm4C7X4OnN00esNHWJ2W3YTE=',NULL,0,'test_mathis_guerin','Guerin','mathis.guerin@testmail.be',0,1,'2026-08-13 09:29:31.464314','Mathis');
INSERT INTO "auth_user" VALUES(1440,'pbkdf2_sha256$1200000$f0Scy7R5vUb0e7E3oSM9dH$Lnb4Jwxw+iW96YqzPzzzTx+gPhF1q9dQvWTCSRHxkhM=',NULL,0,'test_camille_bonnet','Bonnet','camille.bonnet@testmail.be',0,1,'2026-08-13 09:29:32.859394','Camille');
INSERT INTO "auth_user" VALUES(1441,'pbkdf2_sha256$1200000$qZ8kpcq8wRHQODJWp1uGFw$ZNggXgoVynej5vuIUZ+LIE5oUsvS3iUw0tZenBwsfqE=',NULL,0,'test_remy_lambert','Lambert','remy.lambert@testmail.be',0,1,'2026-08-13 09:29:34.181509','Remy');
INSERT INTO "auth_user" VALUES(1442,'pbkdf2_sha256$1200000$JxctDSBJaXPzPwehzrqAoa$f5EGf5C9+Dcq4zTd1NmCSgPBjs0TijcAkHc20S7Mfn4=',NULL,0,'test_sara_henry','Henry','sara.henry@testmail.be',0,1,'2026-08-13 09:29:35.649518','Sara');
INSERT INTO "auth_user" VALUES(1443,'pbkdf2_sha256$1200000$nZB306njCiY6lNl3juUbE4$p+tuw4R0dJiURym/4HiG8N4C+HObVfeqkUiHaVQrX/k=',NULL,0,'test_nolan_colin','Colin','nolan.colin@testmail.be',0,1,'2026-08-13 09:29:37.130257','Nolan');
INSERT INTO "auth_user" VALUES(1444,'pbkdf2_sha256$1200000$IinXVH2GxxNFCy4ygGajkS$+AO9uu39jIZ/Ri0qLIFAScI0mLI7Q5aBnd0UbmNE3Yo=',NULL,0,'test_ambre_fontaine','Fontaine','ambre.fontaine@testmail.be',0,1,'2026-08-13 09:29:38.520641','Ambre');
INSERT INTO "auth_user" VALUES(1445,'pbkdf2_sha256$1200000$DQYFIaf9ioj6SUXAtiLcQ2$8BTHHPtYKrFD2aVwdoO/oVgYSDzIvGL09ibzSYxkRLU=',NULL,0,'test_raphael_girard','Girard','raphael.girard@testmail.be',0,1,'2026-08-13 09:29:39.932195','Raphael');
INSERT INTO "auth_user" VALUES(1446,'pbkdf2_sha256$1200000$8xcll9JABTWhx7kT0uYEDM$VfxEHKsLGb8wYkwTn4pjvzibG/XdGP5zo3XPqjUOogM=',NULL,0,'test_inaya_rousseau','Rousseau','inaya.rousseau@testmail.be',0,1,'2026-08-13 09:29:41.339140','Inaya');
INSERT INTO "auth_user" VALUES(1447,'pbkdf2_sha256$1200000$hI53hsd8UeK2TIGT3Gg5nF$h02oh+75XmAwZ3cMIMLZ2235pqbJDbGSceJ5OSaiu48=',NULL,0,'test_baptiste_rey','Rey','baptiste.rey@testmail.be',0,1,'2026-08-13 09:29:42.723231','Baptiste');
INSERT INTO "auth_user" VALUES(1448,'pbkdf2_sha256$1200000$NdchWzJHL7MnRnjYZhQq7l$uzIKRxwXi+giKskgp6NGbuuhSu/Aj0z8CqvnNqElY6U=',NULL,0,'test_maeva_faure','Faure','maeva.faure@testmail.be',0,1,'2026-08-13 09:29:44.137758','Maeva');
INSERT INTO "auth_user" VALUES(1449,'pbkdf2_sha256$1200000$2FDAq1iJCOmjiAHLy01vL9$o72fKON8K/xxKK91HJ2pU9fmLhE8byDsxaJ99HDNQJE=',NULL,0,'test_killian_andre','Andre','killian.andre@testmail.be',0,1,'2026-08-13 09:29:45.578844','Killian');
INSERT INTO "auth_user" VALUES(1450,'pbkdf2_sha256$1200000$zCaSINFVQAzl0Lw2ySHPfY$+OHD+mUIsRXp2ILYZRHA5QA7cePWHLRBstYVYxTnhVI=',NULL,0,'test_clara_bertrand','Bertrand','clara.bertrand@testmail.be',0,1,'2026-08-13 09:29:46.945690','Clara');
INSERT INTO "auth_user" VALUES(1451,'pbkdf2_sha256$1200000$bPhQBES7QmyLnRTmkRrHG2$C14CDLzJ1Wp4W9ARFTfB//bUfhlKXlHfeTrxuONQEY0=',NULL,0,'test_sacha_morin','Morin','sacha.morin@testmail.be',0,1,'2026-08-13 09:29:48.398739','Sacha');
INSERT INTO "auth_user" VALUES(1452,'pbkdf2_sha256$1200000$YIq2YH2hk11bTnZS8kPImm$nqUvJuHqdnsZ8y6MF4L6d0XWq8bC0lcfi750NrHZ0PE=',NULL,0,'test_elisa_perrin','Perrin','elisa.perrin@testmail.be',0,1,'2026-08-13 09:29:49.866709','Elisa');
INSERT INTO "auth_user" VALUES(1453,'pbkdf2_sha256$1200000$Mn82Xn6rxNnTUAwGA47eUU$bYyedlv7f0O0gtEAga7AOqIloT1IgWFNCB2WZT+mBl4=',NULL,0,'test_victor_poirier','Poirier','victor.poirier@testmail.be',0,1,'2026-08-13 09:29:51.257799','Victor');
INSERT INTO "auth_user" VALUES(1454,'pbkdf2_sha256$1200000$w1QP2zpwqbImGpHLzsbgzm$fngykHz0epa0EkuCR/uZ6nF+ha7so+g0BueL7hJwoJ4=',NULL,0,'test_lucie_renard','Renard','lucie.renard@testmail.be',0,1,'2026-08-13 09:29:52.671874','Lucie');
INSERT INTO "auth_user" VALUES(1455,'pbkdf2_sha256$1200000$GMVx1zCE7Y4MggRH8sEoSh$qToRfQWk2zKHVcdmHvOwRwQxf9BZ8VPyChw7gS0Zspk=',NULL,0,'test_maxime_chevalier','Chevalier','maxime.chevalier@testmail.be',0,1,'2026-08-13 09:29:54.029733','Maxime');
INSERT INTO "auth_user" VALUES(1456,'pbkdf2_sha256$1200000$VJGtXLlV8aBuuC6v682nSS$bkKsRIBvumoCX3IMrWxNprH4iB5/2n5ro5/lYorYoDk=',NULL,0,'test_oceane_leclerc','Leclerc','oceane.leclerc@testmail.be',0,1,'2026-08-13 09:29:55.279381','Oceane');
INSERT INTO "auth_user" VALUES(1457,'pbkdf2_sha256$1200000$1RK1WbvY1WILJD5oiAVwlx$/iSeZVH5sfS9SD5VtMX7Hzq6l1Eej4MaGlrKGyM/oOE=',NULL,0,'test_antoine_millet','Millet','antoine.millet@testmail.be',0,1,'2026-08-13 09:29:56.485141','Antoine');
INSERT INTO "auth_user" VALUES(1458,'pbkdf2_sha256$1200000$whA3feURXwKyHm69K75Ath$Bg7h7NofbqECWWyBx3ByqthG7hRPeOByHweFHTGGpeo=',NULL,0,'test_pauline_noel','Noel','pauline.noel@testmail.be',0,1,'2026-08-13 09:29:57.706786','Pauline');
INSERT INTO "auth_user" VALUES(1459,'pbkdf2_sha256$1200000$tyPhGIZESwh1IFo4foVsuf$8394o1vL8Iq45uu+J17GWJqbsWpWoq/C8UO2KPIaX00=',NULL,0,'test_florian_baron','Baron','florian.baron@testmail.be',0,1,'2026-08-13 09:29:58.951467','Florian');
INSERT INTO "auth_user" VALUES(1460,'pbkdf2_sha256$1200000$giDhdcK41nyLTgLpGl4c98$aBiOOr8Ehh+L4QyiBzdnK4bdA2WsnqOECnLQEb9HZio=','2026-08-23 15:22:59.251173',0,'Jury','','Jury@gmail.com',1,1,'2026-08-20 14:48:37.809837','');
INSERT INTO "auth_user" VALUES(1461,'pbkdf2_sha256$1200000$OCOTKxdNgP6paaog0Ua00N$JKb0tRHSclRZsSef2M3vI46lQigSAChNNiEXiS7Jk8U=','2026-08-23 15:28:21.972910',0,'Jury_user','','jury_user@gmail.com',0,1,'2026-08-20 14:50:22.362842','');
CREATE TABLE "auth_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "auth_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "auth_user_user_permissions" VALUES(1,1375,25);
INSERT INTO "auth_user_user_permissions" VALUES(2,1375,26);
INSERT INTO "auth_user_user_permissions" VALUES(3,1375,27);
INSERT INTO "auth_user_user_permissions" VALUES(4,1375,28);
INSERT INTO "auth_user_user_permissions" VALUES(5,1375,33);
INSERT INTO "auth_user_user_permissions" VALUES(6,1375,34);
INSERT INTO "auth_user_user_permissions" VALUES(7,1375,35);
INSERT INTO "auth_user_user_permissions" VALUES(8,1375,36);
INSERT INTO "auth_user_user_permissions" VALUES(9,1375,32);
INSERT INTO "auth_user_user_permissions" VALUES(10,1375,29);
INSERT INTO "auth_user_user_permissions" VALUES(11,1375,30);
INSERT INTO "auth_user_user_permissions" VALUES(12,1375,31);
INSERT INTO "auth_user_user_permissions" VALUES(13,1375,49);
INSERT INTO "auth_user_user_permissions" VALUES(14,1375,50);
INSERT INTO "auth_user_user_permissions" VALUES(15,1375,51);
INSERT INTO "auth_user_user_permissions" VALUES(16,1375,52);
INSERT INTO "auth_user_user_permissions" VALUES(17,1375,40);
INSERT INTO "auth_user_user_permissions" VALUES(18,1375,37);
INSERT INTO "auth_user_user_permissions" VALUES(19,1375,38);
INSERT INTO "auth_user_user_permissions" VALUES(20,1375,39);
INSERT INTO "auth_user_user_permissions" VALUES(21,1375,41);
INSERT INTO "auth_user_user_permissions" VALUES(22,1375,42);
INSERT INTO "auth_user_user_permissions" VALUES(23,1375,43);
INSERT INTO "auth_user_user_permissions" VALUES(24,1375,44);
INSERT INTO "auth_user_user_permissions" VALUES(25,1460,25);
INSERT INTO "auth_user_user_permissions" VALUES(26,1460,26);
INSERT INTO "auth_user_user_permissions" VALUES(27,1460,27);
INSERT INTO "auth_user_user_permissions" VALUES(28,1460,28);
INSERT INTO "auth_user_user_permissions" VALUES(29,1460,33);
INSERT INTO "auth_user_user_permissions" VALUES(30,1460,34);
INSERT INTO "auth_user_user_permissions" VALUES(31,1460,35);
INSERT INTO "auth_user_user_permissions" VALUES(32,1460,36);
INSERT INTO "auth_user_user_permissions" VALUES(33,1460,32);
INSERT INTO "auth_user_user_permissions" VALUES(34,1460,29);
INSERT INTO "auth_user_user_permissions" VALUES(35,1460,30);
INSERT INTO "auth_user_user_permissions" VALUES(36,1460,31);
INSERT INTO "auth_user_user_permissions" VALUES(37,1460,49);
INSERT INTO "auth_user_user_permissions" VALUES(38,1460,50);
INSERT INTO "auth_user_user_permissions" VALUES(39,1460,51);
INSERT INTO "auth_user_user_permissions" VALUES(40,1460,52);
INSERT INTO "auth_user_user_permissions" VALUES(41,1460,40);
INSERT INTO "auth_user_user_permissions" VALUES(42,1460,37);
INSERT INTO "auth_user_user_permissions" VALUES(43,1460,38);
INSERT INTO "auth_user_user_permissions" VALUES(44,1460,39);
INSERT INTO "auth_user_user_permissions" VALUES(45,1460,41);
INSERT INTO "auth_user_user_permissions" VALUES(46,1460,42);
INSERT INTO "auth_user_user_permissions" VALUES(47,1460,43);
INSERT INTO "auth_user_user_permissions" VALUES(48,1460,44);
CREATE TABLE "contact_contactmessage" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "full_name" varchar(120) NOT NULL, "email" varchar(254) NOT NULL, "phone" varchar(30) NULL, "subject" varchar(150) NOT NULL, "message" text NOT NULL, "is_read" bool NOT NULL, "created_at" datetime NOT NULL, "admin_response" text NOT NULL, "responded_at" datetime NULL, "user_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "user_response_read" bool NOT NULL);
INSERT INTO "contact_contactmessage" VALUES(1270,'Sophie Bernard','sophie.bernard.001@example.com','0470000001','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.946277','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1271,'Lucas Dubois','lucas.dubois.002@example.com','0470000002','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.947288','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1272,'Nadia Leroy','nadia.leroy.003@example.com','0470000003','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.948264','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1273,'Marc Lambert','marc.lambert.004@example.com','0470000004','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.948986','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1274,'Camille Moreau','camille.moreau.005@example.com','0470000005','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.949715','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1275,'Youssef Benali','youssef.benali.006@example.com','0470000006','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.950794','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1276,'Laura Simon','laura.simon.007@example.com','0470000007','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.952003','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1277,'Tom Petit','tom.petit.008@example.com','0470000008','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.952999','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1278,'Sarah Laurent','sarah.laurent.009@example.com','0470000009','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.953738','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1279,'Amine Garcia','amine.garcia.010@example.com','0470000010','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.954457','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1280,'Eva Robert','eva.robert.011@example.com','0470000011','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.955176','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1281,'Noah Martin','noah.martin.012@example.com','0470000012','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.955907','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1282,'Chloe Bernard','chloe.bernard.013@example.com','0470000013','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.956628','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1283,'Romain Dubois','romain.dubois.014@example.com','0470000014','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.957350','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1284,'Mina Leroy','mina.leroy.015@example.com','0470000015','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.958076','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1285,'Alexandre Lambert','alexandre.lambert.016@example.com','0470000016','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.958798','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1286,'Elisa Moreau','elisa.moreau.017@example.com','0470000017','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.959523','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1287,'Mehdi Benali','mehdi.benali.018@example.com','0470000018','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.960244','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1288,'Julie Simon','julie.simon.019@example.com','0470000019','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.960965','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1289,'Jean Petit','jean.petit.020@example.com','0470000020','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.961685','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1290,'Sophie Laurent','sophie.laurent.021@example.com','0470000021','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.962405','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1291,'Lucas Garcia','lucas.garcia.022@example.com','0470000022','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.963287','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1292,'Nadia Robert','nadia.robert.023@example.com','0470000023','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.964013','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1293,'Marc Martin','marc.martin.024@example.com','0470000024','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.964735','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1294,'Camille Bernard','camille.bernard.025@example.com','0470000025','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.965452','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1295,'Youssef Dubois','youssef.dubois.026@example.com','0470000026','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.966171','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1296,'Laura Leroy','laura.leroy.027@example.com','0470000027','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.966900','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1297,'Tom Lambert','tom.lambert.028@example.com','0470000028','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.967614','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1298,'Sarah Moreau','sarah.moreau.029@example.com','0470000029','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.968350','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1299,'Amine Benali','amine.benali.030@example.com','0470000030','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.969067','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1300,'Eva Simon','eva.simon.031@example.com','0470000031','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.969793','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1301,'Noah Petit','noah.petit.032@example.com','0470000032','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.970507','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1302,'Chloe Laurent','chloe.laurent.033@example.com','0470000033','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.971223','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1303,'Romain Garcia','romain.garcia.034@example.com','0470000034','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.971939','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1304,'Mina Robert','mina.robert.035@example.com','0470000035','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.972654','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1305,'Alexandre Martin','alexandre.martin.036@example.com','0470000036','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.973367','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1306,'Elisa Bernard','elisa.bernard.037@example.com','0470000037','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.974089','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1307,'Mehdi Dubois','mehdi.dubois.038@example.com','0470000038','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.974808','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1308,'Julie Leroy','julie.leroy.039@example.com','0470000039','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.975526','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1309,'Jean Lambert','jean.lambert.040@example.com','0470000040','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.976238','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1310,'Sophie Moreau','sophie.moreau.041@example.com','0470000041','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.976953','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1311,'Lucas Benali','lucas.benali.042@example.com','0470000042','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.977666','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1312,'Nadia Simon','nadia.simon.043@example.com','0470000043','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.978376','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1313,'Marc Petit','marc.petit.044@example.com','0470000044','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.979199','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1314,'Camille Laurent','camille.laurent.045@example.com','0470000045','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.979923','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1315,'Youssef Garcia','youssef.garcia.046@example.com','0470000046','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.980637','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1316,'Laura Robert','laura.robert.047@example.com','0470000047','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.981350','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1317,'Tom Martin','tom.martin.048@example.com','0470000048','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.982065','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1318,'Sarah Bernard','sarah.bernard.049@example.com','0470000049','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.982788','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1319,'Amine Dubois','amine.dubois.050@example.com','0470000050','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.983547','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1320,'Eva Leroy','eva.leroy.051@example.com','0470000051','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.984268','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1321,'Noah Lambert','noah.lambert.052@example.com','0470000052','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.984988','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1322,'Chloe Moreau','chloe.moreau.053@example.com','0470000053','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.985707','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1323,'Romain Benali','romain.benali.054@example.com','0470000054','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.986421','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1324,'Mina Simon','mina.simon.055@example.com','0470000055','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.987133','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1325,'Alexandre Petit','alexandre.petit.056@example.com','0470000056','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.987851','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1326,'Elisa Laurent','elisa.laurent.057@example.com','0470000057','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.988564','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1327,'Mehdi Garcia','mehdi.garcia.058@example.com','0470000058','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.989274','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1328,'Julie Robert','julie.robert.059@example.com','0470000059','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.989988','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1329,'Jean Martin','jean.martin.060@example.com','0470000060','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.990696','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1330,'Sophie Bernard','sophie.bernard.061@example.com','0470000061','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.991401','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1331,'Lucas Dubois','lucas.dubois.062@example.com','0470000062','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.992113','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1332,'Nadia Leroy','nadia.leroy.063@example.com','0470000063','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.992819','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1333,'Marc Lambert','marc.lambert.064@example.com','0470000064','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.993527','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1334,'Camille Moreau','camille.moreau.065@example.com','0470000065','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.994246','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1335,'Youssef Benali','youssef.benali.066@example.com','0470000066','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.994956','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1336,'Laura Simon','laura.simon.067@example.com','0470000067','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.995672','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1337,'Tom Petit','tom.petit.068@example.com','0470000068','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.996381','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1338,'Sarah Laurent','sarah.laurent.069@example.com','0470000069','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.997092','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1339,'Amine Garcia','amine.garcia.070@example.com','0470000070','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.997817','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1340,'Eva Robert','eva.robert.071@example.com','0470000071','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.998527','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1341,'Noah Martin','noah.martin.072@example.com','0470000072','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.999236','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1342,'Chloe Bernard','chloe.bernard.073@example.com','0470000073','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:04.999952','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1343,'Romain Dubois','romain.dubois.074@example.com','0470000074','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.000671','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1344,'Mina Leroy','mina.leroy.075@example.com','0470000075','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.001389','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1345,'Alexandre Lambert','alexandre.lambert.076@example.com','0470000076','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.002106','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1346,'Elisa Moreau','elisa.moreau.077@example.com','0470000077','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.002819','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1347,'Mehdi Benali','mehdi.benali.078@example.com','0470000078','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.003540','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1348,'Julie Simon','julie.simon.079@example.com','0470000079','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.004251','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1349,'Jean Petit','jean.petit.080@example.com','0470000080','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.004969','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1350,'Sophie Laurent','sophie.laurent.081@example.com','0470000081','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.005678','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1351,'Lucas Garcia','lucas.garcia.082@example.com','0470000082','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.006383','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1352,'Nadia Robert','nadia.robert.083@example.com','0470000083','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.007094','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1353,'Marc Martin','marc.martin.084@example.com','0470000084','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.007807','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1354,'Camille Bernard','camille.bernard.085@example.com','0470000085','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.008519','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1355,'Youssef Dubois','youssef.dubois.086@example.com','0470000086','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.009236','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1356,'Laura Leroy','laura.leroy.087@example.com','0470000087','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.009958','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1357,'Tom Lambert','tom.lambert.088@example.com','0470000088','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.010670','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1358,'Sarah Moreau','sarah.moreau.089@example.com','0470000089','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.011379','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1359,'Amine Benali','amine.benali.090@example.com','0470000090','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.012171','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1360,'Eva Simon','eva.simon.091@example.com','0470000091','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.012884','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1361,'Noah Petit','noah.petit.092@example.com','0470000092','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.013591','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1362,'Chloe Laurent','chloe.laurent.093@example.com','0470000093','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.014308','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1363,'Romain Garcia','romain.garcia.094@example.com','0470000094','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.015023','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1364,'Mina Robert','mina.robert.095@example.com','0470000095','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.015739','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1365,'Alexandre Martin','alexandre.martin.096@example.com','0470000096','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.016450','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1366,'Elisa Bernard','elisa.bernard.097@example.com','0470000097','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.017167','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1367,'Mehdi Dubois','mehdi.dubois.098@example.com','0470000098','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.017883','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1368,'Julie Leroy','julie.leroy.099@example.com','0470000099','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.018597','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1369,'Jean Lambert','jean.lambert.100@example.com','0470000100','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.019307','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1370,'Sophie Moreau','sophie.moreau.101@example.com','0470000101','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.020024','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1371,'Lucas Benali','lucas.benali.102@example.com','0470000102','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.020737','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1372,'Nadia Simon','nadia.simon.103@example.com','0470000103','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.021452','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1373,'Marc Petit','marc.petit.104@example.com','0470000104','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.022168','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1374,'Camille Laurent','camille.laurent.105@example.com','0470000105','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.022878','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1375,'Youssef Garcia','youssef.garcia.106@example.com','0470000106','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.023592','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1376,'Laura Robert','laura.robert.107@example.com','0470000107','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.024310','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1377,'Tom Martin','tom.martin.108@example.com','0470000108','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.025026','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1378,'Sarah Bernard','sarah.bernard.109@example.com','0470000109','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.025744','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1379,'Amine Dubois','amine.dubois.110@example.com','0470000110','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.026452','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1380,'Eva Leroy','eva.leroy.111@example.com','0470000111','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.027163','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1381,'Noah Lambert','noah.lambert.112@example.com','0470000112','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.027879','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1382,'Chloe Moreau','chloe.moreau.113@example.com','0470000113','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.028589','Bonjour,

Merci pour votre message et votre interet pour notre showroom.

Nos vehicules sont visibles sur rendez-vous du lundi au samedi, de 9h a 18h. Pour planifier une visite, nous vous invitons a faire une reservation en ligne via notre catalogue, ou a nous recontacter en precisant le vehicule qui vous interesse et vos disponibilites.

Nous serons ravis de vous accueillir.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1383,'Romain Benali','romain.benali.114@example.com','0470000114','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.029296','Bonjour,

Merci pour votre message concernant le controle technique.

Tous nos vehicules sont proposes avec leur historique d''entretien disponible sur demande. Le controle technique en cours de validite est systematiquement mentionne dans la fiche du vehicule. Si vous avez une question specifique sur un vehicule en particulier, n''hesitez pas a nous indiquer sa reference et nous vous communiquerons les informations disponibles.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1384,'Mina Simon','mina.simon.115@example.com','0470000115','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.030018','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1385,'Alexandre Petit','alexandre.petit.116@example.com','0470000116','Demande de reprise','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.030733','Bonjour,

Merci pour votre message concernant votre demande de reprise.

Nous avons bien pris note de votre demande. Malheureusement, MultiDrive ne propose pas de service de reprise de vehicule a ce stade. Nous vous invitons a consulter notre catalogue pour decouvrir nos vehicules disponibles a la vente.

N''hesitez pas a nous recontacter si vous avez d''autres questions.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1386,'Elisa Laurent','elisa.laurent.117@example.com','0470000117','Question financement','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.031443','Bonjour,

Merci pour votre message concernant le financement.

MultiDrive propose un systeme de paiement en deux etapes : un acompte de 20 % a la reservation, puis le solde lors de la livraison du vehicule. Nous ne proposons pas de credit a la consommation ou de leasing directement, mais nous pouvons vous orienter vers des organismes partenaires sur demande.

Si vous souhaitez des precisions sur un vehicule en particulier, n''hesitez pas a nous indiquer lequel vous interesse.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1387,'Mehdi Garcia','mehdi.garcia.118@example.com','0470000118','Visite du showroom','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.032164','Bonjour, 

le showroom est fermé durant les vacances. 

merci, 
Younes','2026-08-03 10:49:45',NULL,0);
INSERT INTO "contact_contactmessage" VALUES(1388,'Julie Robert','julie.robert.119@example.com','0470000119','Informations controle technique','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.032876','aucune information n''est disponible pour le moment','2026-06-11 18:21:13',NULL,0);
INSERT INTO "contact_contactmessage" VALUES(1389,'Jean Martin','jean.martin.120@example.com','0470000120','Disponibilite vehicule','Bonjour, je souhaite recevoir plus d''informations.',1,'2026-05-23 12:36:05.033588','Bonjour,

Merci pour votre message concernant la disponibilite d''un vehicule.

La disponibilite en temps reel de nos vehicules est visible directement sur notre catalogue en ligne. Un vehicule affiche comme ''Disponible'' peut etre reserve immediatement. Si le vehicule qui vous interesse est marque comme ''Reserve'', nous vous invitons a consulter nos autres offres similaires ou a nous contacter pour etre informe en cas de desistement.

Cordialement,
L''equipe MultiDrive',NULL,NULL,1);
INSERT INTO "contact_contactmessage" VALUES(1390,'Jean_sebastien','younesmala124@gmail.com','0485986325','ma trotinette','Bonjour, 

délivrez vous un casque avec la trotinette ?',1,'2026-06-18 16:20:53.186724','Bonjour, 

nous disposons de casque, vendu à 75euros.','2026-06-18 16:22:01',1374,1);
CREATE TABLE "django_admin_log" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "object_id" text NULL, "object_repr" varchar(200) NOT NULL, "action_flag" smallint unsigned NOT NULL CHECK ("action_flag" >= 0), "change_message" text NOT NULL, "content_type_id" integer NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "action_time" datetime NOT NULL);
INSERT INTO "django_admin_log" VALUES(1,'3','Statut du compte client_noah_031',2,'[]',16,2,'2026-05-22 17:55:07.075020');
INSERT INTO "django_admin_log" VALUES(2,'1','Suppression demandee par testsuppression',2,'[{"changed": {"fields": ["Processed at"]}}]',15,2,'2026-05-22 17:58:59.327084');
INSERT INTO "django_admin_log" VALUES(3,'186','Message de test message contact - roller',2,'[{"changed": {"fields": ["Admin response", "Responded at"]}}]',13,2,'2026-05-22 18:20:03.466824');
INSERT INTO "django_admin_log" VALUES(4,'187','Message de Younes - roller',2,'[{"changed": {"fields": ["Admin response", "Responded at"]}}]',13,2,'2026-05-22 18:22:15.394788');
INSERT INTO "django_admin_log" VALUES(5,'189','Message de Younes - cheval',2,'[{"changed": {"fields": ["Admin response", "Responded at"]}}]',13,2,'2026-05-22 18:27:48.432765');
INSERT INTO "django_admin_log" VALUES(6,'189','Message de Younes - cheval',2,'[{"changed": {"fields": ["Is read"]}}]',13,2,'2026-05-22 18:27:55.861078');
INSERT INTO "django_admin_log" VALUES(7,'1','Suppression demandee par testsuppression',2,'[]',15,2,'2026-05-22 18:42:47.197696');
INSERT INTO "django_admin_log" VALUES(8,'1','Suppression demandee par testsuppression',2,'[]',15,2,'2026-05-22 18:42:52.463713');
INSERT INTO "django_admin_log" VALUES(9,'243','Reservation de Younes pour Decathlon Rockrider 340 2016 #001',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-05-22 18:59:02.137656');
INSERT INTO "django_admin_log" VALUES(10,'246','Reservation de Younes pour Peugeot 307 SW 2007 #085',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-05-22 18:59:12.486571');
INSERT INTO "django_admin_log" VALUES(11,'247','Reservation de Younes pour Decathlon Rockrider 340 2016 #031',2,'[{"changed": {"fields": ["Status", "Message"]}}]',10,2,'2026-05-22 19:07:21.821682');
INSERT INTO "django_admin_log" VALUES(12,'1717','Reservation de client_adam_001 pour Dacia Duster 2011 #120',2,'[{"changed": {"fields": ["Appointment date"]}}]',10,2,'2026-05-23 12:59:09.097546');
INSERT INTO "django_admin_log" VALUES(13,'1717','Reservation de client_adam_001 pour Dacia Duster 2011 #120',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-05-23 12:59:16.493146');
INSERT INTO "django_admin_log" VALUES(14,'1388','Message de Julie Robert - Informations controle technique',2,'[{"changed": {"fields": ["Admin response", "Responded at"]}}]',13,2,'2026-06-11 18:21:18.663914');
INSERT INTO "django_admin_log" VALUES(15,'1260','Payment 500.00 EUR for reservation #1749',2,'[]',11,2,'2026-06-12 10:46:58.202548');
INSERT INTO "django_admin_log" VALUES(16,'1259','Payment 70.00 EUR for reservation #1748',2,'[]',11,2,'2026-06-12 10:47:04.824511');
INSERT INTO "django_admin_log" VALUES(17,'1261','Payment 20.00 EUR for reservation #1750',2,'[]',11,2,'2026-06-12 10:58:47.666711');
INSERT INTO "django_admin_log" VALUES(18,'1261','Payment 100.00 EUR for reservation #1750',2,'[]',11,2,'2026-06-12 11:00:19.867553');
INSERT INTO "django_admin_log" VALUES(19,'1751','Reservation de Younes pour Mash Seventy 125 2019 #106',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-06-12 11:24:42.335154');
INSERT INTO "django_admin_log" VALUES(20,'1262','Payment 200 EUR for reservation #1751',2,'[{"changed": {"fields": ["Amount", "Status"]}}]',11,2,'2026-06-12 11:26:41.128801');
INSERT INTO "django_admin_log" VALUES(21,'1390','Message de Jean_sebastien - ma trotinette',2,'[{"changed": {"fields": ["Is read", "Admin response", "Responded at"]}}]',13,2,'2026-06-18 16:22:02.897420');
INSERT INTO "django_admin_log" VALUES(22,'1387','Message de Mehdi Garcia - Visite du showroom',2,'[{"changed": {"fields": ["Admin response", "Responded at"]}}]',13,2,'2026-08-03 10:49:48.146424');
INSERT INTO "django_admin_log" VALUES(23,'1723','Reservation de client_yanis_007 pour Xiaomi Mi Electric Scooter 2021 #126',2,'[{"changed": {"fields": ["Status", "Appointment date"]}}]',10,2,'2026-08-03 10:50:37.853060');
INSERT INTO "django_admin_log" VALUES(24,'1755','Reservation de Younes pour Decathlon Rockrider 340 2018 #121',2,'[]',10,2,'2026-08-03 11:05:53.379869');
INSERT INTO "django_admin_log" VALUES(25,'1755','Reservation de Younes pour Decathlon Rockrider 340 2018 #121',2,'[{"changed": {"fields": ["Appointment date"]}}]',10,2,'2026-08-03 11:07:00.043217');
INSERT INTO "django_admin_log" VALUES(26,'1755','Reservation de Younes pour Decathlon Rockrider 340 2018 #121',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-08-03 11:11:36.850314');
INSERT INTO "django_admin_log" VALUES(27,'1758','Reservation de client_adam_001 pour Fiat Punto 2005 #020',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-08-10 15:47:30.815172');
INSERT INTO "django_admin_log" VALUES(28,'1759','Reservation de Younes pour Xiaomi Mi Scooter Essential 2020 #090',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-08-10 15:47:38.027709');
INSERT INTO "django_admin_log" VALUES(29,'1760','Reservation de Phillipe pour Xiaomi Mi Scooter Essential 2020 #090',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-10 16:01:19.496062');
INSERT INTO "django_admin_log" VALUES(30,'1760','Reservation de Phillipe pour Xiaomi Mi Scooter Essential 2020 #090',2,'[{"changed": {"fields": ["User status read"]}}]',10,1375,'2026-08-10 16:01:39.748362');
INSERT INTO "django_admin_log" VALUES(31,'1760','Reservation de Phillipe pour Xiaomi Mi Scooter Essential 2020 #090',2,'[]',10,1375,'2026-08-10 16:06:42.791945');
INSERT INTO "django_admin_log" VALUES(32,'1760','Reservation de Phillipe pour Xiaomi Mi Scooter Essential 2020 #090',2,'[]',10,2,'2026-08-10 16:08:20.045225');
INSERT INTO "django_admin_log" VALUES(33,'1761','Reservation de Phillipe pour Decathlon Rockrider 520 2020 #083',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-10 16:09:50.130002');
INSERT INTO "django_admin_log" VALUES(34,'1809','Reservation de Jean_sebastien pour Citroen C2 2005 #010',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-13 08:45:51.085204');
INSERT INTO "django_admin_log" VALUES(35,'1810','Reservation de Jean_sebastien pour Renault Clio 2004 #001',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-13 08:57:38.474791');
INSERT INTO "django_admin_log" VALUES(36,'1810','Reservation de Jean_sebastien pour Renault Clio 2004 #001',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-13 08:58:46.547005');
INSERT INTO "django_admin_log" VALUES(37,'1811','Reservation de Jean_sebastien pour Renault Clio 2004 #001',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-13 09:09:11.739449');
INSERT INTO "django_admin_log" VALUES(38,'1812','Reservation de Jean_sebastien pour Renault Clio 2004 #001',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-13 09:19:58.118321');
INSERT INTO "django_admin_log" VALUES(39,'1812','Reservation de Jean_sebastien pour Renault Clio 2004 #001',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-13 09:20:35.589488');
INSERT INTO "django_admin_log" VALUES(40,'1812','Reservation de Jean_sebastien pour Renault Clio 2004 #001',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-13 09:20:56.962216');
INSERT INTO "django_admin_log" VALUES(41,'1813','Reservation de Jean_sebastien pour Giant Escape 3 2018 #077',2,'[{"changed": {"fields": ["Status"]}}]',10,1375,'2026-08-13 09:22:36.281082');
INSERT INTO "django_admin_log" VALUES(42,'1852','Reservation de Jean_sebastien pour Giant Escape 3 2018 #077',2,'[{"changed": {"fields": ["Status", "Appointment date"]}}]',10,1375,'2026-08-13 10:32:04.621102');
INSERT INTO "django_admin_log" VALUES(43,'1853','Reservation de Jean_sebastien pour Xiaomi Mi Electric Scooter 3 2021 #088',2,'[{"changed": {"fields": ["Status", "Appointment date"]}}]',10,1375,'2026-08-16 16:11:53.097077');
INSERT INTO "django_admin_log" VALUES(44,'1854','Reservation de Jean_sebastien pour Ninebot ES2 2018 #007',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-08-16 16:59:43.602795');
INSERT INTO "django_admin_log" VALUES(45,'1855','Reservation de Jean_sebastien pour Opel Corsa 2005 #022',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-08-16 17:25:12.969142');
INSERT INTO "django_admin_log" VALUES(46,'1856','Reservation de Jean_sebastien pour Opel Corsa 2005 #022',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-08-16 17:51:16.824919');
INSERT INTO "django_admin_log" VALUES(47,'1857','Reservation de Jean_sebastien pour Btwin Riverside 500 2020 #085',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-08-16 19:10:37.503282');
INSERT INTO "django_admin_log" VALUES(48,'1688','Decathlon Rockrider 340 2016 #061',2,'[{"added": {"name": "Vehicle image", "object": "Image de Decathlon Rockrider 340 2016 #061"}}]',7,2,'2026-08-20 14:13:52.655142');
INSERT INTO "django_admin_log" VALUES(49,'1748','Decathlon Rockrider 340 2018 #121',2,'[{"added": {"name": "Vehicle image", "object": "Image de Decathlon Rockrider 340 2018 #121"}}]',7,2,'2026-08-20 14:15:56.108874');
INSERT INTO "django_admin_log" VALUES(50,'1858','Reservation de Younes pour Decathlon Rockrider 340 2018 #121',2,'[{"changed": {"fields": ["Status"]}}]',10,2,'2026-08-23 10:22:49.391022');
CREATE TABLE "django_content_type" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app_label" varchar(100) NOT NULL, "model" varchar(100) NOT NULL);
INSERT INTO "django_content_type" VALUES(1,'admin','logentry');
INSERT INTO "django_content_type" VALUES(2,'auth','permission');
INSERT INTO "django_content_type" VALUES(3,'auth','group');
INSERT INTO "django_content_type" VALUES(4,'auth','user');
INSERT INTO "django_content_type" VALUES(5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES(6,'sessions','session');
INSERT INTO "django_content_type" VALUES(7,'vehicles','vehicle');
INSERT INTO "django_content_type" VALUES(8,'vehicles','vehiclecategory');
INSERT INTO "django_content_type" VALUES(9,'vehicles','vehicleimage');
INSERT INTO "django_content_type" VALUES(10,'reservations','reservation');
INSERT INTO "django_content_type" VALUES(11,'payments','payment');
INSERT INTO "django_content_type" VALUES(12,'payments','invoice');
INSERT INTO "django_content_type" VALUES(13,'contact','contactmessage');
INSERT INTO "django_content_type" VALUES(14,'vehicles','review');
INSERT INTO "django_content_type" VALUES(15,'accounts','accountdeletionrequest');
INSERT INTO "django_content_type" VALUES(16,'accounts','accountstatus');
INSERT INTO "django_content_type" VALUES(17,'vehicles','favorite');
INSERT INTO "django_content_type" VALUES(18,'payments','testimonial');
INSERT INTO "django_content_type" VALUES(19,'accounts','adminnote');
CREATE TABLE "django_migrations" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "applied" datetime NOT NULL);
INSERT INTO "django_migrations" VALUES(1,'contenttypes','0001_initial','2026-04-19 14:03:24.411143');
INSERT INTO "django_migrations" VALUES(2,'auth','0001_initial','2026-04-19 14:03:24.469298');
INSERT INTO "django_migrations" VALUES(3,'admin','0001_initial','2026-04-19 14:03:24.516552');
INSERT INTO "django_migrations" VALUES(4,'admin','0002_logentry_remove_auto_add','2026-04-19 14:03:24.564979');
INSERT INTO "django_migrations" VALUES(5,'admin','0003_logentry_add_action_flag_choices','2026-04-19 14:03:24.604003');
INSERT INTO "django_migrations" VALUES(6,'contenttypes','0002_remove_content_type_name','2026-04-19 14:03:24.704377');
INSERT INTO "django_migrations" VALUES(7,'auth','0002_alter_permission_name_max_length','2026-04-19 14:03:24.739395');
INSERT INTO "django_migrations" VALUES(8,'auth','0003_alter_user_email_max_length','2026-04-19 14:03:24.772393');
INSERT INTO "django_migrations" VALUES(9,'auth','0004_alter_user_username_opts','2026-04-19 14:03:24.796232');
INSERT INTO "django_migrations" VALUES(10,'auth','0005_alter_user_last_login_null','2026-04-19 14:03:24.829364');
INSERT INTO "django_migrations" VALUES(11,'auth','0006_require_contenttypes_0002','2026-04-19 14:03:24.837065');
INSERT INTO "django_migrations" VALUES(12,'auth','0007_alter_validators_add_error_messages','2026-04-19 14:03:24.865663');
INSERT INTO "django_migrations" VALUES(13,'auth','0008_alter_user_username_max_length','2026-04-19 14:03:24.901431');
INSERT INTO "django_migrations" VALUES(14,'auth','0009_alter_user_last_name_max_length','2026-04-19 14:03:24.934014');
INSERT INTO "django_migrations" VALUES(15,'auth','0010_alter_group_name_max_length','2026-04-19 14:03:24.964026');
INSERT INTO "django_migrations" VALUES(16,'auth','0011_update_proxy_permissions','2026-04-19 14:03:24.985111');
INSERT INTO "django_migrations" VALUES(17,'auth','0012_alter_user_first_name_max_length','2026-04-19 14:03:25.021351');
INSERT INTO "django_migrations" VALUES(18,'sessions','0001_initial','2026-04-19 14:03:25.040171');
INSERT INTO "django_migrations" VALUES(19,'vehicles','0001_initial','2026-04-19 14:03:25.056003');
INSERT INTO "django_migrations" VALUES(20,'vehicles','0002_vehiclecategory_vehicle_created_at_and_more','2026-04-19 14:27:53.110196');
INSERT INTO "django_migrations" VALUES(21,'vehicles','0003_vehicleimage','2026-04-19 14:42:02.492348');
INSERT INTO "django_migrations" VALUES(22,'reservations','0001_initial','2026-04-19 14:51:42.967742');
INSERT INTO "django_migrations" VALUES(23,'payments','0001_initial','2026-04-19 14:54:19.123199');
INSERT INTO "django_migrations" VALUES(24,'payments','0002_invoice','2026-04-19 15:01:17.070700');
INSERT INTO "django_migrations" VALUES(25,'contact','0001_initial','2026-04-19 15:02:25.572441');
INSERT INTO "django_migrations" VALUES(26,'contact','0002_alter_contactmessage_options','2026-04-19 15:19:16.390172');
INSERT INTO "django_migrations" VALUES(27,'payments','0003_alter_invoice_options_alter_payment_options','2026-04-19 15:19:16.403808');
INSERT INTO "django_migrations" VALUES(28,'reservations','0002_alter_reservation_options_alter_reservation_status','2026-04-19 15:19:16.421777');
INSERT INTO "django_migrations" VALUES(29,'vehicles','0004_alter_vehiclecategory_options_and_more','2026-04-19 15:19:16.442993');
INSERT INTO "django_migrations" VALUES(30,'vehicles','0005_review','2026-05-04 10:20:17.530981');
INSERT INTO "django_migrations" VALUES(31,'accounts','0001_initial','2026-05-22 17:32:26.097412');
INSERT INTO "django_migrations" VALUES(32,'accounts','0002_accountstatus_admin_note_and_more','2026-05-22 17:52:00.354183');
INSERT INTO "django_migrations" VALUES(33,'contact','0003_contactmessage_admin_response_and_more','2026-05-22 18:15:43.427455');
INSERT INTO "django_migrations" VALUES(34,'contact','0004_contactmessage_user_response_read','2026-05-22 18:25:35.864057');
INSERT INTO "django_migrations" VALUES(35,'payments','0004_payment_user_status_read','2026-05-22 19:04:45.924168');
INSERT INTO "django_migrations" VALUES(36,'reservations','0003_reservation_user_status_read','2026-05-22 19:04:45.969365');
INSERT INTO "django_migrations" VALUES(37,'payments','0005_payment_admin_notif_read','2026-05-23 13:07:53.510745');
INSERT INTO "django_migrations" VALUES(38,'reservations','0004_add_cancelled_status','2026-06-12 11:09:35.454114');
INSERT INTO "django_migrations" VALUES(39,'payments','0006_add_refund_requested_status','2026-06-12 11:19:40.387642');
INSERT INTO "django_migrations" VALUES(40,'payments','0007_add_refund_fields','2026-06-12 11:29:18.753313');
INSERT INTO "django_migrations" VALUES(41,'vehicles','0006_add_favorite_model','2026-08-03 11:19:41.893829');
INSERT INTO "django_migrations" VALUES(42,'vehicles','0007_add_carrosserie_moteur_condition_notes','2026-08-07 09:53:52.533770');
INSERT INTO "django_migrations" VALUES(43,'vehicles','0008_add_description_translations','2026-08-10 14:42:39.634926');
INSERT INTO "django_migrations" VALUES(44,'payments','0008_add_testimonial','2026-08-10 17:14:38.144321');
INSERT INTO "django_migrations" VALUES(45,'vehicles','0009_remove_review','2026-08-10 17:14:38.151370');
INSERT INTO "django_migrations" VALUES(46,'payments','0009_testimonial_pending_by_default','2026-08-10 17:22:11.249364');
INSERT INTO "django_migrations" VALUES(47,'payments','0010_testimonial_comment_translations','2026-08-10 17:36:42.688239');
INSERT INTO "django_migrations" VALUES(48,'reservations','0005_add_phone_to_reservation','2026-08-13 08:53:31.842754');
INSERT INTO "django_migrations" VALUES(49,'accounts','0003_add_admin_note','2026-08-13 09:04:32.233769');
INSERT INTO "django_migrations" VALUES(50,'accounts','0004_accountstatus_phone','2026-08-13 09:57:30.025437');
INSERT INTO "django_migrations" VALUES(51,'payments','0011_add_soft_delete_testimonial','2026-08-13 16:33:13.476647');
INSERT INTO "django_migrations" VALUES(52,'payments','0012_add_admin_reply_testimonial','2026-08-13 16:38:11.304567');
INSERT INTO "django_migrations" VALUES(53,'accounts','0005_add_ban_fields','2026-08-16 17:22:53.709137');
INSERT INTO "django_migrations" VALUES(54,'accounts','0006_add_bank_cgv_fields','2026-08-16 17:22:53.756658');
INSERT INTO "django_migrations" VALUES(55,'payments','0013_add_refund_reason','2026-08-16 19:35:17.293685');
INSERT INTO "django_migrations" VALUES(56,'payments','0014_add_stripe_refund_id','2026-08-17 17:36:26.350730');
CREATE TABLE "django_session" ("session_key" varchar(40) NOT NULL PRIMARY KEY, "session_data" text NOT NULL, "expire_date" datetime NOT NULL);
INSERT INTO "django_session" VALUES('m9eb1mj92owtmj3tbp2dn5dgw6cozzhi','.eJxVjLsOwjAMAP8lM4pKnIfLyN5viBw7kAJKpaadEP-OInWA9e50bxVp30rcW17jLOqijDr9skT8zLULeVC9L5qXuq1z0j3Rh216WiS_rkf7NyjUSt9CYha0iMEBD_mGAXkEsoPJbCC4xGCJkGH05AVNciIegM7WZ8dGfb7i7jfU:1wETlp:XQv_XnztLjORJriNbmqt4AVoh0CsSx1y1q7P5B_XEPY','2026-05-03 15:09:13.904819');
INSERT INTO "django_session" VALUES('2a1fms38fk0wzep6t6xj7ju5b8zcerj5','.eJxVjEsOgjAUAO_y1qaBFvth6Z4zNO_TWtSUhMLKeHdDwkK3M5N5Q8R9K3FvaY2zwAi9NXD5pYT8TPVQ8sB6XxQvdVtnUkeiTtvUtEh63c72b1CwFRjB0-ARtZFgOkqkhaxmDN4FziEHtIKMnXC2rF0iMkGL9tfkyPTEOMDnC15eObc:1wEVTO:FEq0Miges9ILiSyOA7G8JXGQLD6LKaSGB1TFKxobCC8','2026-05-03 16:58:18.951074');
INSERT INTO "django_session" VALUES('icyq1empdsostkdxm7bez2srrupetkww','.eJxVjEEOwiAQAP-yZ0NA2KX06L1vIEvZStXQpLQn499Nkx70OjOZN0TetxL3JmucM_RgCOHySxOPT6mHyg-u90WNS93WOakjUadtaliyvG5n-zco3Ar0IBmNsRb1FanryJLliTwHTj77CZ3WQRvxzqGVwCZJEC9imDNbL4ng8wUKDTgP:1wEVa3:WP1qtW40I4u8eCGZdsqGjaGvcwx4tIdvWsesRcVmdAU','2026-05-03 17:05:11.512393');
INSERT INTO "django_session" VALUES('j147fxo15x9m6tszok8lyslx5cli07fr','.eJxVjLsOwjAMAP_FM4rspm7Sjux8QxQnDi2gRupjQvw7qtQB1rvTvSHEfRvDvuoSpgwDUNfC5ZdKTE-dD5Ufcb5Xk-q8LZOYIzGnXc2tZn1dz_ZvMMZ1hAEsxmwpi3iP3HhuE7qivTrU0hAKE6ZWWJkSF5fQdpZ78k7QW--0wOcLIDk3pQ:1wGNWC:WcuwCFdxaS3xhpE60h4ErOpmNn92unI2cl8t8U3sJbw','2026-05-08 20:52:56.198106');
INSERT INTO "django_session" VALUES('z0u2s5dwshrnhwrjnp3u02oc4bxg2usl','.eJxVjLsOwjAMAP8lM4pKnIfLyN5viBw7kAJKpaadEP-OInWA9e50bxVp30rcW17jLOqijDr9skT8zLULeVC9L5qXuq1z0j3Rh216WiS_rkf7NyjUSt9CYha0iMEBD_mGAXkEsoPJbCC4xGCJkGH05AVNciIegM7WZ8dGfb7i7jfU:1wJpxj:phUnHdtI45Z2qFUz1eIna4WMlnhMB8uOWPwRFUKBjfo','2026-05-18 09:51:39.764100');
INSERT INTO "django_session" VALUES('0vv5rsg9gs9qodqxmne5r1t4u9pnpgys','.eJxVjLsOwjAMAP_FM4rspm7Sjux8QxQnDi2gRupjQvw7qtQB1rvTvSHEfRvDvuoSpgwDUNfC5ZdKTE-dD5Ufcb5Xk-q8LZOYIzGnXc2tZn1dz_ZvMMZ1hAEsxmwpi3iP3HhuE7qivTrU0hAKE6ZWWJkSF5fQdpZ78k7QW--0wOcLIDk3pQ:1wJpxr:YtptW4l8sbCa70gEonPuKE02AlWEADfJuYh961PCyao','2026-05-18 09:51:47.906947');
INSERT INTO "django_session" VALUES('gdrd9tda0tv0x3uhylej564u43j2p1rv','.eJxVjTsOgzAQBa8SbY2QP2CvKdOnygGs9doESAQStqsod4-QKJJ2ZvTeGzzVMvma0-7nCANIY6H5pYH4mdZDxYXWx9bytpZ9Du2RtKfN7W2L6XU927-BifIEA1A39mFEl7TQ0lpyaBhVH0zgrhvRKY6sTK8laidJWLQClYzSoZGClIEGjmfi4nMNS-ICA9zrksrl5JeScoHPF5HSRR0:1wQUR0:0VZ0Cm4tTKlnHbwHYRkjVywLKHilLNJXO8izdNmPZpI','2026-06-05 18:17:22.491982');
INSERT INTO "django_session" VALUES('esxfinyln1c6ef2vwbaegpgvn2z7unt2','.eJxVjLsOwjAMAP8lM4pKnIfLyN5viBw7kAJKpaadEP-OInWA9e50bxVp30rcW17jLOqijDr9skT8zLULeVC9L5qXuq1z0j3Rh216WiS_rkf7NyjUSt9CYha0iMEBD_mGAXkEsoPJbCC4xGCJkGH05AVNciIegM7WZ8dGfb7i7jfU:1wQUSf:PmVbyjhq6Ob-oRz4c4FAoejt5qU3FqzJ_2Au5-O3vMY','2026-06-05 18:19:05.448868');
INSERT INTO "django_session" VALUES('1j75f08e7v8frgo18b91reqizktt368t','.eJxVjLsOwjAMAP_FM4rspm7Sjux8QxQnDi2gRupjQvw7qtQB1rvTvSHEfRvDvuoSpgwDUNfC5ZdKTE-dD5Ufcb5Xk-q8LZOYIzGnXc2tZn1dz_ZvMMZ1hAEsxmwpi3iP3HhuE7qivTrU0hAKE6ZWWJkSF5fQdpZ78k7QW--0wOcLIDk3pQ:1wQUUJ:BJEkSnouJHKQbF9FHfufWavVXl_CpyKL4BI3Te5e0Sw','2026-06-05 18:20:47.023864');
INSERT INTO "django_session" VALUES('e8a93c1igvxpqgpnga9j58y0m40649o8','e30:1wQUZH:wokLHcLSvrTRWlJz97nJQW0Qgti7EizRlSCooCp2fFQ','2026-06-05 18:25:55.618254');
INSERT INTO "django_session" VALUES('7x8ucl3ckwt0ex0ul3g75nxo7kjx2vvx','.eJxVjEEOwiAQAP-yZ0OApVB69O4bCLtQqRpISnsy_t006UGvM5N5Q4j7VsLe8xqWBBMoJ-HySynyM9dDpUes9ya41W1dSByJOG0Xt5by63q2f4MSe4EJEBENJTJoUDvp9Txoab1mzrNXSZEhkoO37LOUbEeDObrkvGUdjRoRPl8Jcjdw:1wQUlv:Da11lp2sFBQqu6WsBqQCBvl9nv34rfC8vd_Mc1O_25A','2026-06-05 18:38:59.858647');
INSERT INTO "django_session" VALUES('dbn3e7mvhzln5p5bs4eshr3m6intjr1v','.eJxVjLsOwjAMAP_FM4rspm7Sjux8QxQnDi2gRupjQvw7qtQB1rvTvSHEfRvDvuoSpgwDUNfC5ZdKTE-dD5Ufcb5Xk-q8LZOYIzGnXc2tZn1dz_ZvMMZ1hAEsxmwpi3iP3HhuE7qivTrU0hAKE6ZWWJkSF5fQdpZ78k7QW--0wOcLIDk3pQ:1wQV1z:Feau3hDGZ6CSYK2blC2lORVHO0tw-Op_7L106ydP1Go','2026-06-05 18:55:35.704739');
INSERT INTO "django_session" VALUES('lf08t35g4yo344jwhjg0jg23noko8d47','.eJxVjLsOwjAMAP_FM4rspm7Sjux8QxQnDi2gRupjQvw7qtQB1rvTvSHEfRvDvuoSpgwDUNfC5ZdKTE-dD5Ufcb5Xk-q8LZOYIzGnXc2tZn1dz_ZvMMZ1hAEsxmwpi3iP3HhuE7qivTrU0hAKE6ZWWJkSF5fQdpZ78k7QW--0wOcLIDk3pQ:1wQVDf:Xvtzs3t6pBXvNw3OPyUCxoPTJJX1w_NqY5PqLPhoKI8','2026-06-05 19:07:39.499883');
INSERT INTO "django_session" VALUES('wtzovnqeaeztfix97xnozpyj39v0f46n','.eJxVjLsOwjAMAP8lM4pKnIfLyN5viBw7kAJKpaadEP-OInWA9e50bxVp30rcW17jLOqijDr9skT8zLULeVC9L5qXuq1z0j3Rh216WiS_rkf7NyjUSt9CYha0iMEBD_mGAXkEsoPJbCC4xGCJkGH05AVNciIegM7WZ8dGfb7i7jfU:1wQmKu:3U0fL0hGbPcLQinxfbxy8G7CXbT2dZCmlmjnRaPdRwI','2026-06-06 13:24:16.350095');
INSERT INTO "django_session" VALUES('m0hyhgpqwdzt3s19v6ls95jivas5eyjb','.eJxVjLsOwjAMAP8lM4pKnIfLyN5viBw7kAJKpaadEP-OInWA9e50bxVp30rcW17jLOqijDr9skT8zLULeVC9L5qXuq1z0j3Rh216WiS_rkf7NyjUSt9CYha0iMEBD_mGAXkEsoPJbCC4xGCJkGH05AVNciIegM7WZ8dGfb7i7jfU:1wQmKw:c-lLYrphmLZkDUyFTC2uLsDQmEvoMz70pGDnKe1w8Mk','2026-06-06 13:24:18.603242');
INSERT INTO "django_session" VALUES('ckq3wjvx4fy3hxl6zm1o892ehfrrqeq9','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wXz7E:_q-zKZueU-xS_zTBdLsggBRkISrgSdKSqPorx2v1Dyg','2026-06-26 10:27:56.845360');
INSERT INTO "django_session" VALUES('uud0z1j68lpoe9yeck3qq9ecuk4nnbu7','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wXz7G:XP3dYJ1KYdWTKrQb5Tj9vhJDfb5Xoy6GcvbN_CptAfs','2026-06-26 10:27:58.952492');
INSERT INTO "django_session" VALUES('g5y2d9jvtbc2dmaxl1qhc59ylq6sxn2n','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wXz9M:nf7XudDaFEDrYRag8u2y0zklWpFEGUFQw83VsO2qDmw','2026-06-26 10:30:08.379641');
INSERT INTO "django_session" VALUES('whvbs2sxei2hfxh0awaflc0thhrdzyta','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wXzBW:Pr305nXG0vMbBWZbiY2_xRst2I4tzc_AtMbjl_bxclM','2026-06-26 10:32:22.374554');
INSERT INTO "django_session" VALUES('zi3kf7f1o6ks65ne00yau8t6g39kkzzq','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wXzFb:R12vyocbNrCiPG74dWFqXDo9k-5le7RGOkcAbKCfPZ8','2026-06-26 10:36:35.350156');
INSERT INTO "django_session" VALUES('0kgjllp9gnxbh7tvrx68aovm5z28smsv','.eJxVjLsOwjAMAP8lM4pKnIfLyN5viBw7kAJKpaadEP-OInWA9e50bxVp30rcW17jLOqijDr9skT8zLULeVC9L5qXuq1z0j3Rh216WiS_rkf7NyjUSt9CYha0iMEBD_mGAXkEsoPJbCC4xGCJkGH05AVNciIegM7WZ8dGfb7i7jfU:1wXzYJ:zcpGy8oq4aagGAbq2aPBdiBH-lhZZQbAhyrwIrG7C44','2026-06-26 10:55:55.026330');
INSERT INTO "django_session" VALUES('ntbr6vif9o1nhmn5r38306t32bzgso4u','.eJxVjLsOwjAMAP_FM4qauGmajux8Q-XYLimgROpjQvw7qtQB1rvTvWGkfcvjvuoyzgIDWAwIl1-ciJ9aDicPKvdquJZtmZM5EnPa1dyq6Ot6tn-DTGuGAbTvkTFwxM7bpk-xCeQloMOJnFWLXXJBubGep7aNnVAbZIqMrMn6JPD5AjoZOG4:1wXzbL:AImYzayxxJXPaRTa5DEVeYDXsadDGLoh_2QCUnptM8g','2026-06-26 10:59:03.257070');
INSERT INTO "django_session" VALUES('o45q4lnvm4dmcb5k5utp0orgr1of1092','.eJxVjLsOwjAMAP_FM4qauGmajux8Q-XYLimgROpjQvw7qtQB1rvTvWGkfcvjvuoyzgIDWAwIl1-ciJ9aDicPKvdquJZtmZM5EnPa1dyq6Ot6tn-DTGuGAbTvkTFwxM7bpk-xCeQloMOJnFWLXXJBubGep7aNnVAbZIqMrMn6JPD5AjoZOG4:1wXzbN:XQakgC3GH_U12TwlRZ5YaQSPmfcJDacoDAo4Zl1Osts','2026-06-26 10:59:05.660795');
INSERT INTO "django_session" VALUES('oyftjrqmg7zoqndee8tkajj4760jfvoa','.eJxVjLsOwjAMAP_FM4qauGmajux8Q-XYLimgROpjQvw7qtQB1rvTvWGkfcvjvuoyzgIDWAwIl1-ciJ9aDicPKvdquJZtmZM5EnPa1dyq6Ot6tn-DTGuGAbTvkTFwxM7bpk-xCeQloMOJnFWLXXJBubGep7aNnVAbZIqMrMn6JPD5AjoZOG4:1wXzcq:5dWzXoZeA8E4ExPLQe6u_U2IbdzGgIkm4arGJ5A17k0','2026-06-26 11:00:36.482063');
INSERT INTO "django_session" VALUES('wym4pue7mjf3elcekosy5wpyi8wmz2s1','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wXzqB:R7Qv9OnhbaqGHTNjt7YfZVdVBHTyjh1GsyJo2SHSv0w','2026-06-26 11:14:23.270051');
INSERT INTO "django_session" VALUES('wsal371t0kdxvs63w6lvm686060w3k9i','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wXzzf:Z4N4_L73XIJ0fnVCUoAMbDBvPQlotBjkx0o15WjmLu4','2026-06-26 11:24:11.722896');
INSERT INTO "django_session" VALUES('ik0qnq0vlsy3p2v5t8luk49ybw3yijgh','.eJxVjLsOwjAMAP8lM4pKnIfLyN5viBw7kAJKpaadEP-OInWA9e50bxVp30rcW17jLOqijDr9skT8zLULeVC9L5qXuq1z0j3Rh216WiS_rkf7NyjUSt9CYha0iMEBD_mGAXkEsoPJbCC4xGCJkGH05AVNciIegM7WZ8dGfb7i7jfU:1wXzzi:GaJNHFKphOIo7ltrHskqr0dAjWiM4MsIRbSOn7d7f44','2026-06-26 11:24:14.581937');
INSERT INTO "django_session" VALUES('4kdvswubapb1ifivf7phh9zm045cmaiv','.eJxVjLsOwjAMAP8lM4pKnIfLyN5viBw7kAJKpaadEP-OInWA9e50bxVp30rcW17jLOqijDr9skT8zLULeVC9L5qXuq1z0j3Rh216WiS_rkf7NyjUSt9CYha0iMEBD_mGAXkEsoPJbCC4xGCJkGH05AVNciIegM7WZ8dGfb7i7jfU:1waFO1:84ocWOR2wT4-jcR45Ep5bdw7IL3rQUdFtyIOKMuon74','2026-07-02 16:14:37.745394');
INSERT INTO "django_session" VALUES('nusjxcin469fxjpjbfwxryutd1zfm9t2','.eJxVjLsOwjAMAP8lM4pKnIfLyN5viBw7kAJKpaadEP-OInWA9e50bxVp30rcW17jLOqijDr9skT8zLULeVC9L5qXuq1z0j3Rh216WiS_rkf7NyjUSt9CYha0iMEBD_mGAXkEsoPJbCC4xGCJkGH05AVNciIegM7WZ8dGfb7i7jfU:1wtSA3:iJroVvjlP9Ipybi9yYRQQnl6QXFtPJpswSshirVuyUg','2026-08-24 15:43:35.669890');
INSERT INTO "django_session" VALUES('dknl2m8odwxe3bkwmwbajnqephojm0h0','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wtSEC:jFmyRQnddZmbJKEmxlg4odd5RzMB-72G-WSMXTqIeTU','2026-08-24 15:47:52.379522');
INSERT INTO "django_session" VALUES('1ubmerzw7kagu2n6v12sgpul7ekztn8l','.eJxVjLsOwjAMAP_FM4qauGmajux8Q-XYLimgROpjQvw7qtQB1rvTvWGkfcvjvuoyzgIDWAwIl1-ciJ9aDicPKvdquJZtmZM5EnPa1dyq6Ot6tn-DTGuGAbTvkTFwxM7bpk-xCeQloMOJnFWLXXJBubGep7aNnVAbZIqMrMn6JPD5AjoZOG4:1wtSRv:jTIJfQqRwZWlFRRuAtPkaAbdK4hMTFCPlxER2VtqfF4','2026-08-24 16:02:03.132557');
INSERT INTO "django_session" VALUES('jn3kyivwpj0yy609qg5no1pi7jsfkg60','.eJxVjLsOwjAMAP_FM4qauGmajux8Q-XYLimgROpjQvw7qtQB1rvTvWGkfcvjvuoyzgIDWAwIl1-ciJ9aDicPKvdquJZtmZM5EnPa1dyq6Ot6tn-DTGuGAbTvkTFwxM7bpk-xCeQloMOJnFWLXXJBubGep7aNnVAbZIqMrMn6JPD5AjoZOG4:1wtSRx:L9jqdWDZaDzH52fwxo0nSNRLQhmFYhdqUiD6CA5u-z8','2026-08-24 16:02:05.170993');
INSERT INTO "django_session" VALUES('ombdjmud8jake9gjl0rkbdh0ja9mrpzu','.eJxVjDEOwjAMAP_iGUU0TmKnIztvqJzE0AJKpaadEH9HlTrAene6NwyyreOwNV2GqUAPHZKH0y9Okp9ad1ceUu-zyXNdlymZPTGHbeY6F31djvZvMEoboQdVoojqGIvDWzpL5OARrWXVSBa5S8E779BKh6kwhejRchSNxJQLfL4wczdN:1wtSW7:cZwfvrPfj2aSOAy7oQ8Sj5Iw1v4biuUxZkBa06UlW1I','2026-08-24 16:06:23.853954');
INSERT INTO "django_session" VALUES('giuxoy59iob3rl0gfu35v2q3xrfqxq2p','.eJxVjDEOwjAMAP_iGUU0TmKnIztvqJzE0AJKpaadEH9HlTrAene6NwyyreOwNV2GqUAPHZKH0y9Okp9ad1ceUu-zyXNdlymZPTGHbeY6F31djvZvMEoboQdVoojqGIvDWzpL5OARrWXVSBa5S8E779BKh6kwhejRchSNxJQLfL4wczdN:1wtUDW:g1oSanabX5LtmB-rsKfIT9KmPxEG2pIUn_x2nHY5FdY','2026-08-24 17:55:18.256543');
INSERT INTO "django_session" VALUES('98eyvvko63jezfll34io3lzjv3vc97x8','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wup2u:J2t9Q2CL7ss9ANn9X20qXzX6D2gSQO7tZqiv8r4Pjsk','2026-08-28 10:21:52.270114');
INSERT INTO "django_session" VALUES('92ds5haa2aooe5259hzxbe7h6874x41r','.eJxVjMsOwiAQAP9lz4aAy6P06L3fQJYFpGpoUtqT8d9Nkx70OjOZNwTatxr2ntcwJxhBodNw-cWR-Jnb4dKD2n0RvLRtnaM4EnHaLqYl5dftbP8GlXqFETBH4ih1QYPGusETJhutNIbZW4zSlnIlYtauDMgaXdGIZJNSUkuv4PMFXU44MQ:1wupAy:LtuikCg-3Nv5MQOsa9u9CseXV3mRLzD_JP_rPTCCSfA','2026-08-28 10:30:12.669459');
INSERT INTO "django_session" VALUES('bu0pk0uwphprb0uwggsi4aavqxr45h0a','.eJxVjMsOwiAQAP9lz4aAy6P06L3fQJYFpGpoUtqT8d9Nkx70OjOZNwTatxr2ntcwJxhBodNw-cWR-Jnb4dKD2n0RvLRtnaM4EnHaLqYl5dftbP8GlXqFETBH4ih1QYPGusETJhutNIbZW4zSlnIlYtauDMgaXdGIZJNSUkuv4PMFXU44MQ:1wvgT3:6tHs5iPW8XLtdyCuwh6LPal1U0Lm_duLKzqR8yoj6rg','2026-08-30 19:24:25.580921');
INSERT INTO "django_session" VALUES('ith2kr3yf3at4rwh6x01b2p4203pk33j','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1wvgem:L25QZxaGet1LMsSu6wd8FtkFfcW4R7iRuWMbXcy60Go','2026-08-30 19:36:32.219685');
INSERT INTO "django_session" VALUES('aq6lfiub3o1d28rg1zqwlo8rjmkml7m2','.eJxVjLsOAiEUBf-F2hCWKwtY2vsNm_sAWTWQ7KMy_rsh2ULbMzPnrSbctzLta1qmWdRFDeCtOv3OhPxMtTN5YL03za1uy0y6K_qgq741Sa_r4f4dFFxLr9GhpRApGk8oAD774Eafzg6ixZHAIWY27EKMmQHzIEZGBmMpkbD6fAFk4zla:1ww1PM:ZVpKuMELNtCsIK0mfrlPRQ0MIRwf7Fy1wVDfLWXj8uQ','2026-08-31 17:46:00.793859');
INSERT INTO "django_session" VALUES('wkjz1u2mkm6p6fvebgb5do7frugy8sha','.eJxVjLsOwjAMAP_FM4rqJK3djux8Q-TECSmgVupjQvw7qtQB1rvTvSHIvtWwr3kJo8IA6DuEyy-Okp55Opw-ZLrPJs3TtozRHIk57Wpus-bX9Wz_BlXWCgMULFYZk3CxrXVWkJzjYptOlCIjUWblqG1iwhR9H5FcRtK-tA36Bj5fTls4Dg:1wy9jM:LDbsN_hsy3pnOmtbtwY4U-ryMHkbFxZ6UX5Sgs0ghOM','2026-09-06 15:03:28.150328');
INSERT INTO "django_session" VALUES('g5yfif3yd9nqz8edxvc4fqpopvg7od85','.eJxVjDkOAjEQBP_iGFm-D0LyfcNqxh7jBWRLe0SIvyNLG0DSQVd1v9kMx17nY6N1XjK7MmmcYJffGiE9qQ2WH9Dunafe9nVBPhR-0o1PPdPrdrp_BxW2OtYCQykiFJJUwEKwziRpsopZUwTwGoOX1jtlR1LB4CMZoVEYpTCxzxdn4jh0:1wy9jN:-2jQNOiNtsnutQNi8cpuM32y32vWQ2pVaxilnxIzEg4','2026-09-06 15:03:29.188061');
INSERT INTO "django_session" VALUES('4q67rac1obf1v9m3tr8luumhsbr2usxc','.eJxVjLsOwjAMAP_FM4rqJK3djux8Q-TECSmgVupjQvw7qtQB1rvTvSHIvtWwr3kJo8IA6DuEyy-Okp55Opw-ZLrPJs3TtozRHIk57Wpus-bX9Wz_BlXWCgMULFYZk3CxrXVWkJzjYptOlCIjUWblqG1iwhR9H5FcRtK-tA36Bj5fTls4Dg:1wy9jb:-Ae1kC2jNJ-Xlbd1PkcaX7QrofOtDuXYafwkoIiL5V8','2026-09-06 15:03:43.890062');
INSERT INTO "django_session" VALUES('e7gaf54meo9kclinnh3nykz8r0teh2vl','.eJxVjMsOwiAQAP9lz4YA8ig9eu83NMsuSNVAUtqT8d9Nkx70OjOZN8y4b2Xee1rnhWEEZZyCyy-OSM9UD8cPrPcmqNVtXaI4EnHaLqbG6XU7279BwV5gBB0HnRBtsN5LbxTZjPJKFKx3aA0zsvGeZQqBKGtnUw46ZI7R5WjyAJ8vWt85Rw:1wyA1t:6kdj1aQFmZNXjVBVZtlsiZt6k_zm8EeAvE5TtXD9Ib4','2026-09-06 15:22:37.484293');
INSERT INTO "django_session" VALUES('7q59pcxnc3f9qmrt06ttpi4370952u8x','.eJxVjLsOwjAMAP8lM4oSN3EwIzvfUNmJSwsokfqYEP-OKnWA9e50b9Pzto79tujcT8VcjA_ozOkXC-en1t2VB9d7s7nVdZ7E7ok97GJvrejrerR_g5GXcT878eoUWKAMMRUqwXmRBJhTJEwxxTRAx4ykPncAFIgCnhW9xAHBfL5IgDe2:1wyA2F:Yz0SCZ7Pk4psxkwXRnUFiFLZY7VXAURu-DOS9KLamhI','2026-09-06 15:22:59.260748');
INSERT INTO "django_session" VALUES('hfzehgj24ccbkg2qlep68by2fxp149xg','.eJxVjMsOwiAQAP9lz4YA8ig9eu83NMsuSNVAUtqT8d9Nkx70OjOZN8y4b2Xee1rnhWEEZZyCyy-OSM9UD8cPrPcmqNVtXaI4EnHaLqbG6XU7279BwV5gBB0HnRBtsN5LbxTZjPJKFKx3aA0zsvGeZQqBKGtnUw46ZI7R5WjyAJ8vWt85Rw:1wyA2S:xVUhjQ9HlLuIXBgpLxTmJNUkxWstfuNjcLFkXiSkAEw','2026-09-06 15:23:12.402668');
INSERT INTO "django_session" VALUES('fz8oc0rfawgtjnhy0eniuim38ra9zhxe','.eJxVjMsOwiAQAP9lz4YA8ig9eu83NMsuSNVAUtqT8d9Nkx70OjOZN8y4b2Xee1rnhWEEZZyCyy-OSM9UD8cPrPcmqNVtXaI4EnHaLqbG6XU7279BwV5gBB0HnRBtsN5LbxTZjPJKFKx3aA0zsvGeZQqBKGtnUw46ZI7R5WjyAJ8vWt85Rw:1wyA7R:h5_ppABUiIlu5TuJAIhbgH7TAM1K1wyjxr8hDe889wM','2026-09-06 15:28:21.980897');
CREATE TABLE "payments_invoice" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "invoice_number" varchar(50) NOT NULL UNIQUE, "total_amount" decimal NOT NULL, "vat_amount" decimal NOT NULL, "issued_at" datetime NOT NULL, "due_date" date NULL, "notes" text NULL, "payment_id" bigint NOT NULL UNIQUE REFERENCES "payments_payment" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "payments_invoice" VALUES(1090,'MD-INV-2026-0003',36,0,'2026-05-23 12:36:04.875009','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1150);
INSERT INTO "payments_invoice" VALUES(1093,'MD-INV-2026-0006',28,0,'2026-05-23 12:36:04.877017','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1153);
INSERT INTO "payments_invoice" VALUES(1094,'MD-INV-2026-0007',44,0,'2026-05-23 12:36:04.877693','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1154);
INSERT INTO "payments_invoice" VALUES(1096,'MD-INV-2026-0009',20,0,'2026-05-23 12:36:04.879104','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1156);
INSERT INTO "payments_invoice" VALUES(1099,'MD-INV-2026-0012',138,0,'2026-05-23 12:36:04.881260','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1159);
INSERT INTO "payments_invoice" VALUES(1102,'MD-INV-2026-0015',250,0,'2026-05-23 12:36:04.883249','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1162);
INSERT INTO "payments_invoice" VALUES(1105,'MD-INV-2026-0018',250,0,'2026-05-23 12:36:04.885235','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1165);
INSERT INTO "payments_invoice" VALUES(1106,'MD-INV-2026-0019',250,0,'2026-05-23 12:36:04.885895','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1166);
INSERT INTO "payments_invoice" VALUES(1108,'MD-INV-2026-0021',250,0,'2026-05-23 12:36:04.887215','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1168);
INSERT INTO "payments_invoice" VALUES(1111,'MD-INV-2026-0024',250,0,'2026-05-23 12:36:04.889208','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1171);
INSERT INTO "payments_invoice" VALUES(1114,'MD-INV-2026-0027',250,0,'2026-05-23 12:36:04.891198','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1174);
INSERT INTO "payments_invoice" VALUES(1117,'MD-INV-2026-0030',250,0,'2026-05-23 12:36:04.893194','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1177);
INSERT INTO "payments_invoice" VALUES(1118,'MD-INV-2026-0031',20,0,'2026-05-23 12:36:04.893865','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1178);
INSERT INTO "payments_invoice" VALUES(1120,'MD-INV-2026-0033',52,0,'2026-05-23 12:36:04.895296','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1180);
INSERT INTO "payments_invoice" VALUES(1123,'MD-INV-2026-0036',38,0,'2026-05-23 12:36:04.897428','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1183);
INSERT INTO "payments_invoice" VALUES(1126,'MD-INV-2026-0039',20,0,'2026-05-23 12:36:04.899415','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1186);
INSERT INTO "payments_invoice" VALUES(1129,'MD-INV-2026-0042',230,0,'2026-05-23 12:36:04.901435','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1189);
INSERT INTO "payments_invoice" VALUES(1132,'MD-INV-2026-0045',250,0,'2026-05-23 12:36:04.903464','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1192);
INSERT INTO "payments_invoice" VALUES(1135,'MD-INV-2026-0048',250,0,'2026-05-23 12:36:04.905497','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1195);
INSERT INTO "payments_invoice" VALUES(1138,'MD-INV-2026-0051',240,0,'2026-05-23 12:36:04.907541','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1198);
INSERT INTO "payments_invoice" VALUES(1141,'MD-INV-2026-0054',250,0,'2026-05-23 12:36:04.909612','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1201);
INSERT INTO "payments_invoice" VALUES(1144,'MD-INV-2026-0057',250,0,'2026-05-23 12:36:04.911654','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1204);
INSERT INTO "payments_invoice" VALUES(1147,'MD-INV-2026-0060',250,0,'2026-05-23 12:36:04.913685','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1207);
INSERT INTO "payments_invoice" VALUES(1148,'MD-INV-2026-0061',30,0,'2026-05-23 12:36:04.914356','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1208);
INSERT INTO "payments_invoice" VALUES(1150,'MD-INV-2026-0063',62,0,'2026-05-23 12:36:04.915711','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1210);
INSERT INTO "payments_invoice" VALUES(1153,'MD-INV-2026-0066',44,0,'2026-05-23 12:36:04.917749','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1213);
INSERT INTO "payments_invoice" VALUES(1156,'MD-INV-2026-0069',20,0,'2026-05-23 12:36:04.919779','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1216);
INSERT INTO "payments_invoice" VALUES(1159,'MD-INV-2026-0072',118,0,'2026-05-23 12:36:04.921796','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1219);
INSERT INTO "payments_invoice" VALUES(1162,'MD-INV-2026-0075',240,0,'2026-05-23 12:36:04.923818','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1222);
INSERT INTO "payments_invoice" VALUES(1165,'MD-INV-2026-0078',250,0,'2026-05-23 12:36:04.925850','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1225);
INSERT INTO "payments_invoice" VALUES(1168,'MD-INV-2026-0081',250,0,'2026-05-23 12:36:04.927878','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1228);
INSERT INTO "payments_invoice" VALUES(1171,'MD-INV-2026-0084',250,0,'2026-05-23 12:36:04.930107','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1231);
INSERT INTO "payments_invoice" VALUES(1174,'MD-INV-2026-0087',250,0,'2026-05-23 12:36:04.932579','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1234);
INSERT INTO "payments_invoice" VALUES(1177,'MD-INV-2026-0090',250,0,'2026-05-23 12:36:04.934863','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1237);
INSERT INTO "payments_invoice" VALUES(1180,'MD-INV-2026-0093',52,0,'2026-05-23 12:36:04.936920','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1240);
INSERT INTO "payments_invoice" VALUES(1183,'MD-INV-2026-0096',42,0,'2026-05-23 12:36:04.939144','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1243);
INSERT INTO "payments_invoice" VALUES(1186,'MD-INV-2026-0099',20,0,'2026-05-23 12:36:04.941191','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1246);
INSERT INTO "payments_invoice" VALUES(1189,'MD-INV-2026-0102',228,0,'2026-05-23 12:36:04.943242','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1249);
INSERT INTO "payments_invoice" VALUES(1192,'MD-INV-2026-0105',250,0,'2026-05-23 12:36:04.945284','2026-06-06','Facture d''acompte pour reservation de vehicule d''occasion.',1252);
CREATE TABLE "payments_payment" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "amount" decimal NOT NULL, "status" varchar(20) NOT NULL, "payment_method" varchar(50) NULL, "transaction_reference" varchar(120) NULL UNIQUE, "paid_at" datetime NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "reservation_id" bigint NOT NULL UNIQUE REFERENCES "reservations_reservation" ("id") DEFERRABLE INITIALLY DEFERRED, "user_status_read" bool NOT NULL, "admin_notif_read" bool NOT NULL, "refund_amount" decimal NULL, "refund_note" text NULL, "refund_reason" text NOT NULL, "stripe_refund_id" varchar(50) NOT NULL);
INSERT INTO "payments_payment" VALUES(1150,36,'paid','cash','MD-PAY-0003','2026-05-05 12:36:04.762564','2026-05-23 12:36:04.763069','2026-05-23 12:36:04.763076',1600,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1153,28,'paid','cash','MD-PAY-0006','2026-05-10 12:36:04.764683','2026-05-23 12:36:04.765187','2026-05-23 12:36:04.765194',1603,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1154,44,'paid','card','MD-PAY-0007','2026-05-06 12:36:04.765385','2026-05-23 12:36:04.765889','2026-05-23 12:36:04.765896',1604,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1156,20,'paid','card','MD-PAY-0009','2026-05-09 12:36:04.766792','2026-05-23 12:36:04.767301','2026-05-23 12:36:04.767308',1606,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1159,138,'paid','bank_transfer','MD-PAY-0012','2026-05-17 12:36:04.768915','2026-05-23 12:36:04.769416','2026-05-23 12:36:04.769423',1609,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1162,250,'paid','card','MD-PAY-0015','2026-05-18 12:36:04.771023','2026-05-23 12:36:04.771530','2026-05-23 12:36:04.771536',1612,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1165,250,'paid','cash','MD-PAY-0018','2026-05-05 12:36:04.773150','2026-05-23 12:36:04.773654','2026-05-23 12:36:04.773661',1615,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1166,250,'paid','card','MD-PAY-0019','2026-05-04 12:36:04.773852','2026-05-23 12:36:04.774483','2026-05-23 12:36:04.774492',1616,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1168,250,'paid','bank_transfer','MD-PAY-0021','2026-05-14 12:36:04.775662','2026-05-23 12:36:04.776229','2026-05-23 12:36:04.776236',1618,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1171,250,'paid','bank_transfer','MD-PAY-0024','2026-05-06 12:36:04.777859','2026-05-23 12:36:04.778367','2026-05-23 12:36:04.778374',1621,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1174,250,'paid','card','MD-PAY-0027','2026-05-14 12:36:04.780378','2026-05-23 12:36:04.780924','2026-05-23 12:36:04.780931',1624,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1177,250,'paid','bank_transfer','MD-PAY-0030','2026-05-23 12:36:04.782856','2026-05-23 12:36:04.783361','2026-05-23 12:36:04.783368',1627,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1178,20,'paid','card','MD-PAY-0031','2026-05-14 12:36:04.783560','2026-05-23 12:36:04.784068','2026-05-23 12:36:04.784075',1628,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1180,52,'paid','cash','MD-PAY-0033','2026-05-13 12:36:04.784976','2026-05-23 12:36:04.785481','2026-05-23 12:36:04.785488',1630,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1183,38,'paid','bank_transfer','MD-PAY-0036','2026-05-21 12:36:04.787082','2026-05-23 12:36:04.787770','2026-05-23 12:36:04.787777',1633,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1186,20,'paid','card','MD-PAY-0039','2026-05-22 12:36:04.789382','2026-05-23 12:36:04.789938','2026-05-23 12:36:04.789946',1636,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1189,230,'paid','bank_transfer','MD-PAY-0042','2026-05-16 12:36:04.791569','2026-05-23 12:36:04.792069','2026-05-23 12:36:04.792076',1639,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1192,250,'paid','card','MD-PAY-0045','2026-05-04 12:36:04.793675','2026-05-23 12:36:04.794186','2026-05-23 12:36:04.794193',1642,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1195,250,'paid','cash','MD-PAY-0048','2026-05-14 12:36:04.795792','2026-05-23 12:36:04.796297','2026-05-23 12:36:04.796304',1645,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1198,240,'paid','card','MD-PAY-0051','2026-05-22 12:36:04.797901','2026-05-23 12:36:04.798409','2026-05-23 12:36:04.798416',1648,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1201,250,'paid','bank_transfer','MD-PAY-0054','2026-05-15 12:36:04.800015','2026-05-23 12:36:04.800515','2026-05-23 12:36:04.800522',1651,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1204,250,'paid','bank_transfer','MD-PAY-0057','2026-05-06 12:36:04.802094','2026-05-23 12:36:04.802596','2026-05-23 12:36:04.802603',1654,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1207,250,'paid','cash','MD-PAY-0060','2026-05-04 12:36:04.804175','2026-05-23 12:36:04.804676','2026-05-23 12:36:04.804683',1657,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1208,30,'paid','cash','MD-PAY-0061','2026-05-14 12:36:04.804871','2026-05-23 12:36:04.805374','2026-05-23 12:36:04.805381',1658,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1210,62,'paid','cash','MD-PAY-0063','2026-05-14 12:36:04.807221','2026-05-23 12:36:04.807845','2026-05-23 12:36:04.807852',1660,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1213,44,'paid','cash','MD-PAY-0066','2026-05-03 12:36:04.809600','2026-05-23 12:36:04.810118','2026-05-23 12:36:04.810125',1663,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1216,20,'paid','card','MD-PAY-0069','2026-05-16 12:36:04.815331','2026-05-23 12:36:04.816714','2026-05-23 12:36:04.816737',1666,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1219,118,'paid','bank_transfer','MD-PAY-0072','2026-05-22 12:36:04.832844','2026-05-23 12:36:04.833795','2026-05-23 12:36:04.833812',1669,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1222,240,'paid','cash','MD-PAY-0075','2026-05-09 12:36:04.837075','2026-05-23 12:36:04.838055','2026-05-23 12:36:04.838076',1672,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1225,250,'paid','card','MD-PAY-0078','2026-05-11 12:36:04.841378','2026-05-23 12:36:04.842070','2026-05-23 12:36:04.842090',1675,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1228,250,'paid','cash','MD-PAY-0081','2026-05-21 12:36:04.843818','2026-05-23 12:36:04.844524','2026-05-23 12:36:04.844539',1678,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1231,250,'paid','card','MD-PAY-0084','2026-05-15 12:36:04.848146','2026-05-23 12:36:04.849336','2026-05-23 12:36:04.849358',1681,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1234,250,'paid','card','MD-PAY-0087','2026-05-23 12:36:04.852990','2026-05-23 12:36:04.854035','2026-05-23 12:36:04.854055',1684,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1237,250,'paid','bank_transfer','MD-PAY-0090','2026-05-08 12:36:04.857144','2026-05-23 12:36:04.857713','2026-05-23 12:36:04.857721',1687,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1240,52,'paid','bank_transfer','MD-PAY-0093','2026-05-05 12:36:04.859549','2026-05-23 12:36:04.860121','2026-05-23 12:36:04.860128',1690,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1243,42,'paid','cash','MD-PAY-0096','2026-05-12 12:36:04.861920','2026-05-23 12:36:04.862431','2026-05-23 12:36:04.862438',1693,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1246,20,'paid','bank_transfer','MD-PAY-0099','2026-05-13 12:36:04.864351','2026-05-23 12:36:04.864968','2026-05-23 12:36:04.864975',1696,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1249,228,'paid','card','MD-PAY-0102','2026-05-22 12:36:04.866619','2026-05-23 12:36:04.867147','2026-05-23 12:36:04.867154',1699,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1252,250,'paid','cash','MD-PAY-0105','2026-05-20 12:36:04.868788','2026-05-23 12:36:04.869295','2026-05-23 12:36:04.869302',1702,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1255,240,'paid','cash','MD-PAY-0108','2026-05-10 12:36:04.870889','2026-05-23 12:36:04.871393','2026-05-23 12:36:04.871400',1705,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1258,250,'paid','card','edf22579e6eb430288058afc295e958d','2026-05-23 13:19:17.123741','2026-05-23 13:19:17.128306','2026-05-23 13:19:17.128343',1717,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1261,100,'paid','card','6144b4386507492182c55466e9eb0bf5','2026-06-12 10:59:34','2026-06-12 10:56:47.904219','2026-06-12 11:00:19.860452',1750,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1263,1270,'paid','card','cs_test_a1BrIege9VVUjXK3rL6oDY76eFuAFNosoa5HzvvKB47YpuJnSXxxi6RM3j','2026-06-18 11:15:47.322309','2026-06-18 11:15:24.017864','2026-06-18 11:15:47.322969',1753,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1264,220,'refunded','card','cs_test_a1vefAjkS5UdsnarkwDj6ycOcvZglAjoZcofaYev7czSK8DtkhfhSdYmf5','2026-06-18 16:18:30.693433','2026-06-18 16:18:11.325858','2026-08-13 08:43:10.199355',1754,1,1,198,'10% de retenue pour les frais administratif et le nettoyage','','');
INSERT INTO "payments_payment" VALUES(1265,170,'refunded','card','cs_test_a1kaOTmSu4UmVW6FoI409RlZHvK0acHP7kqfKHPHrsL8RSFXEy42u6FmkT','2026-08-07 10:44:44.296111','2026-08-03 11:12:51.136888','2026-08-17 17:54:13.791553',1755,1,1,153,'test stripe refund
[Stripe échoué : Le montant (153.00 EUR) dépasse la somme encaissée par Stripe. Réduisez le montant et réessayez.]','test stripe refund','');
INSERT INTO "payments_payment" VALUES(1266,150,'refunded','card','cs_test_a1GCD9na0Cd8d3DNuSy5LfVccrFks0ubpkiakGkbjpTg0x0RItlELG9Hn4','2026-08-07 10:45:08.142948','2026-08-03 11:28:51.293409','2026-08-17 17:42:23.343688',1756,1,1,135,'test stripe refund
[Stripe échoué : Refund amount (€135.00) is greater than charge amount (€120.00)]','test remboursement stripe refund','');
INSERT INTO "payments_payment" VALUES(1267,180,'refunded','card','cs_test_a1g2KaJqV6FqXh9ktQSCjBvbqMpwIrFw2wZDlp9mSnDF7xtl4Dn2c42pbQ','2026-08-07 10:45:23.174955','2026-08-07 10:44:10.310894','2026-08-16 19:40:59.661227',1757,1,1,144,'[Virement] IBAN : BE68545896325 — Titulaire : Younes
Tardif...','mon papa m''a trouvé une autre voiture... merci quand meme pourrions-nous nous accorder sur le remboursement ?','');
INSERT INTO "payments_payment" VALUES(1268,800,'paid','card','cs_test_a1w33Ql3Rv4Y2HkjpJySR2chmsNyMgStZ5pRcUOn55MbAwNL6n9sR1Lbyk','2026-08-10 18:02:38.219799','2026-08-10 15:58:05.005970','2026-08-10 18:02:38.221857',1758,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1269,40,'paid','card','cs_test_a13MQVPbjJb4s3qGyhYdqlYZMBox45DgFpVFybtHvClIHy9DCP3JdcG8Si','2026-08-10 16:10:46.133567','2026-08-10 16:10:46.138071','2026-08-10 16:10:46.138110',1760,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1270,56,'paid','card','cs_test_a14GuXsTh10qN8WahCMiZlBhCOCw38GZKHTvsqE050OJVE8pJNGpURChAO','2026-08-10 16:11:29.126086','2026-08-10 16:11:29.130129','2026-08-10 16:11:29.130185',1761,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1271,900,'paid','card','DEMO-9488937D1D','2026-08-10 17:45:38.866955','2026-08-10 17:45:38.867724','2026-08-10 17:45:38.867745',1762,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1272,800,'paid','card','DEMO-79FF686178','2026-08-10 17:45:38.895370','2026-08-10 17:45:38.895669','2026-08-10 17:45:38.895682',1763,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1273,750,'paid','card','DEMO-A217E47C01','2026-08-10 17:45:38.913947','2026-08-10 17:45:38.914245','2026-08-10 17:45:38.914258',1764,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1274,850,'paid','card','DEMO-C644819F2A','2026-08-10 17:45:38.936219','2026-08-10 17:45:38.936962','2026-08-10 17:45:38.936982',1765,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1275,1300,'paid','card','DEMO-190880157D','2026-08-10 17:45:38.961257','2026-08-10 17:45:38.961766','2026-08-10 17:45:38.961791',1766,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1276,1100,'paid','card','DEMO-10C07C9500','2026-08-10 17:45:38.988200','2026-08-10 17:45:38.988716','2026-08-10 17:45:38.988738',1767,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1277,1100,'paid','card','DEMO-A076CC5506','2026-08-10 17:45:39.017529','2026-08-10 17:45:39.017984','2026-08-10 17:45:39.018005',1768,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1278,1800,'paid','card','DEMO-66772B896D','2026-08-10 17:45:39.047087','2026-08-10 17:45:39.047598','2026-08-10 17:45:39.047621',1769,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1279,240,'paid','card','DEMO-7369AD4343','2026-08-10 18:04:57.899091','2026-08-10 18:04:57.900665','2026-08-10 18:04:57.900706',1770,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1280,280,'paid','card','DEMO-09C4733F17','2026-08-10 18:05:01.370335','2026-08-10 18:05:01.371259','2026-08-10 18:05:01.371301',1771,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1281,310,'paid','card','DEMO-6DBA31E3BF','2026-08-10 18:05:04.655845','2026-08-10 18:05:04.656741','2026-08-10 18:05:04.656785',1772,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1282,350,'paid','card','DEMO-ABE7314C1C','2026-08-10 18:05:07.820570','2026-08-10 18:05:07.820947','2026-08-10 18:05:07.820964',1773,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1283,420,'paid','card','DEMO-D60E643D40','2026-08-10 18:05:10.901693','2026-08-10 18:05:10.902620','2026-08-10 18:05:10.902665',1774,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1284,250,'refunded','card','REFUND-63AD2E6A94','2026-07-10 18:26:59.997816','2026-08-10 18:27:34.136669','2026-07-12 18:26:59.997816',1787,1,1,200,'Remboursement integral suite a annulation avant visite.','','');
INSERT INTO "payments_payment" VALUES(1285,100,'refunded','card','REFUND-3A27080930','2026-06-10 18:26:59.997816','2026-08-10 18:27:35.509173','2026-06-12 18:26:59.997816',1788,1,1,100,'Remboursement de l''acompte apres accord mutuel.','','');
INSERT INTO "payments_payment" VALUES(1286,250,'refunded','card','REFUND-6ED5609D59','2026-07-22 18:26:59.997816','2026-08-10 18:27:36.948752','2026-07-24 18:26:59.997816',1789,1,1,200,'Remboursement effectue — vehicule non conforme a la description.','','');
INSERT INTO "payments_payment" VALUES(1287,250,'refunded','card','REFUND-4BA31B895E','2026-04-22 18:26:59.997816','2026-08-10 18:27:38.327191','2026-04-24 18:26:59.997816',1790,1,1,200,'Acompte rendu suite a annulation dans les 48h.','','');
INSERT INTO "payments_payment" VALUES(1288,150,'refunded','card','REFUND-575A91F55D','2026-07-19 18:26:59.997816','2026-08-10 18:27:39.732431','2026-07-21 18:26:59.997816',1791,1,1,135,'Remboursement partiel apres retention de 10 % de frais administratifs.','','');
INSERT INTO "payments_payment" VALUES(1289,250,'refunded','card','REFUND-CFA871F187','2026-06-27 18:26:59.997816','2026-08-10 18:27:41.008580','2026-06-29 18:26:59.997816',1792,1,1,250,'Remboursement total — defaut non signale dans l''annonce.','','');
INSERT INTO "payments_payment" VALUES(1290,250,'refunded','card','REFUND-5826BC8ADE','2026-04-02 18:26:59.997816','2026-08-10 18:27:42.342899','2026-04-04 18:26:59.997816',1793,1,1,250,'Remboursement suite a desistement justifie du client.','','');
INSERT INTO "payments_payment" VALUES(1291,250,'refunded','card','REFUND-B29CB519D1','2026-07-22 18:26:59.997816','2026-08-10 18:27:43.752719','2026-07-24 18:26:59.997816',1794,1,1,250,'Acompte rembourse conformement aux CGV article 7.','','');
INSERT INTO "payments_payment" VALUES(1292,48,'refunded','card','REFUND-E050F239B9','2026-03-17 18:26:59.997816','2026-08-10 18:27:45.013068','2026-03-19 18:26:59.997816',1795,1,1,38.4,'Remboursement effectue apres mediation client.','','');
INSERT INTO "payments_payment" VALUES(1293,250,'refunded','card','REFUND-220CA8623C','2026-07-02 18:26:59.997816','2026-08-10 18:27:46.429475','2026-07-04 18:26:59.997816',1796,1,1,200,'Acompte rendu — vehicule reserve par erreur de double reservation.','','');
INSERT INTO "payments_payment" VALUES(1294,310,'paid','card','HIDDEN-58A13FF9BF','2026-05-25 18:26:59.997816','2026-08-10 18:27:47.704268','2026-08-10 18:27:47.704279',1797,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1295,1700,'paid','card','HIDDEN-0581707979','2026-05-15 18:26:59.997816','2026-08-10 18:27:49.022888','2026-08-10 18:27:49.022899',1798,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1296,2200,'paid','card','HIDDEN-0D53CC7BBC','2026-07-09 18:26:59.997816','2026-08-10 18:27:50.379743','2026-08-10 18:27:50.379756',1799,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1297,1600,'paid','card','HIDDEN-464EC05264','2026-05-30 18:26:59.997816','2026-08-10 18:27:51.657017','2026-08-10 18:27:51.657028',1800,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1298,2200,'paid','card','HIDDEN-AAC90896D9','2026-05-11 18:26:59.997816','2026-08-10 18:27:52.935256','2026-08-10 18:27:52.935268',1801,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1299,1400,'paid','card','HIDDEN-CC519778C6','2026-06-04 18:26:59.997816','2026-08-10 18:27:54.301387','2026-08-10 18:27:54.301399',1802,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1300,1200,'paid','card','HIDDEN-2B41CFA626','2026-06-20 18:26:59.997816','2026-08-10 18:27:55.723341','2026-08-10 18:27:55.723354',1803,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1301,650,'paid','card','HIDDEN-D35848AB2E','2026-05-21 18:26:59.997816','2026-08-10 18:27:57.036026','2026-08-10 18:27:57.036050',1804,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1302,2000,'paid','card','HIDDEN-F9AA75764C','2026-07-08 18:26:59.997816','2026-08-10 18:27:58.438101','2026-08-10 18:27:58.438114',1805,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1303,2200,'paid','card','HIDDEN-DEAE20C3F7','2026-05-13 18:26:59.997816','2026-08-10 18:27:59.891852','2026-08-10 18:27:59.891864',1806,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1304,1500,'paid','card','HIDDEN-D7CF12BCED','2026-06-22 18:26:59.997816','2026-08-10 18:28:01.273173','2026-08-10 18:28:01.273186',1807,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1305,350,'paid','card','HIDDEN-AC62A01496','2026-07-28 18:26:59.997816','2026-08-10 18:28:02.601162','2026-08-10 18:28:02.601173',1808,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1306,98,'paid','card','TEST-DEP-65B9054F51','2026-07-05 09:29:09.856164','2026-08-13 09:30:00.416148','2026-08-13 09:30:00.416161',1834,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1307,250,'paid','card','TEST-DEP-243EE2F081','2026-05-31 09:29:09.856164','2026-08-13 09:30:00.435257','2026-08-13 09:30:00.435285',1835,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1308,250,'paid','card','TEST-DEP-55E26B7165','2026-07-23 09:29:09.856164','2026-08-13 09:30:00.454308','2026-08-13 09:30:00.454322',1836,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1309,74,'paid','card','TEST-DEP-68A11C8810','2026-07-08 09:29:09.856164','2026-08-13 09:30:00.470379','2026-08-13 09:30:00.470390',1837,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1310,88,'paid','card','TEST-DEP-14F44F4E4E','2026-06-09 09:29:09.856164','2026-08-13 09:30:00.485615','2026-08-13 09:30:00.485629',1838,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1311,250,'paid','card','TEST-DEP-60C76891DA','2026-06-13 09:29:09.856164','2026-08-13 09:30:00.501982','2026-08-13 09:30:00.501996',1839,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1312,250,'paid','card','TEST-DEP-83B66818E1','2026-06-19 09:29:09.856164','2026-08-13 09:30:00.517957','2026-08-13 09:30:00.517969',1840,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1313,40,'paid','card','TEST-DEP-B4C0A8290D','2026-07-27 09:29:09.856164','2026-08-13 09:30:00.533593','2026-08-13 09:30:00.533604',1841,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1314,110,'paid','card','TEST-DEP-732D900F3B','2026-06-06 09:29:09.856164','2026-08-13 09:30:00.548577','2026-08-13 09:30:00.548587',1842,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1315,30,'paid','card','TEST-DEP-AD1B5A6B89','2026-06-30 09:29:09.856164','2026-08-13 09:30:00.564385','2026-08-13 09:30:00.564399',1843,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1316,250,'refunded','card','TEST-REF-07D6DC5F0E','2026-04-08 09:29:09.856164','2026-08-13 09:30:00.580382','2026-04-12 09:29:09.856164',1844,1,1,225,'Remboursement integral — annulation dans les 48h apres paiement de l''acompte.','','');
INSERT INTO "payments_payment" VALUES(1317,250,'refunded','card','TEST-REF-15AA4FCB1D','2026-06-03 09:29:09.856164','2026-08-13 09:30:00.601756','2026-06-07 09:29:09.856164',1845,1,1,250,'Remboursement apres accord mutuel — retention de 10% de frais administratifs.','','');
INSERT INTO "payments_payment" VALUES(1318,250,'refunded','card','TEST-REF-ECBEE43055','2026-05-15 09:29:09.856164','2026-08-13 09:30:00.623480','2026-05-19 09:29:09.856164',1846,1,1,225,'Acompte rembourse suite a annulation justifiee (financement refuse par la banque).','','');
INSERT INTO "payments_payment" VALUES(1319,240,'refunded','card','TEST-REF-EFF7D89544','2026-07-01 09:29:09.856164','2026-08-13 09:30:00.644473','2026-07-05 09:29:09.856164',1847,1,1,216,'Remboursement total — vehicule non conforme aux specifications annoncees.','','');
INSERT INTO "payments_payment" VALUES(1320,250,'refunded','card','TEST-REF-51EB4CE3DF','2026-06-17 09:29:09.856164','2026-08-13 09:30:00.667004','2026-06-21 09:29:09.856164',1848,1,1,200,'Remboursement partiel — frais de dossier retenus conformement aux CGV article 7.','','');
INSERT INTO "payments_payment" VALUES(1321,250,'refunded','card','TEST-REF-51B3AA9DA9','2026-07-31 09:29:09.856164','2026-08-13 09:30:00.686231','2026-08-04 09:29:09.856164',1849,1,1,225,'Remboursement integral — annulation dans les 48h apres paiement de l''acompte.','','');
INSERT INTO "payments_payment" VALUES(1322,250,'refunded','card','TEST-REF-A2A7B87ACE','2026-07-31 09:29:09.856164','2026-08-13 09:30:00.708078','2026-08-04 09:29:09.856164',1850,1,1,250,'Remboursement apres accord mutuel — retention de 10% de frais administratifs.','','');
INSERT INTO "payments_payment" VALUES(1323,180,'refunded','card','TEST-REF-7482F07D6E','2026-03-20 09:29:09.856164','2026-08-13 09:30:00.732084','2026-03-24 09:29:09.856164',1851,1,1,180,'Acompte rembourse suite a annulation justifiee (financement refuse par la banque).','','');
INSERT INTO "payments_payment" VALUES(1324,350,'paid','card','cs_test_a1sDrB6A6rgpKxek7fXKoJL6lezBa4YFfULUThUAhrV42NqecXiKjOy3C2','2026-08-13 10:39:50.223819','2026-08-13 10:39:50.226918','2026-08-13 10:39:50.226941',1852,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1325,900,'paid','card','cs_test_a1pMcsI8mhyfRoI4G90d8oVMbWwauBwCauWUPEHa1fUu2nNGsAvljdG9cd','2026-08-13 16:21:13.633761','2026-08-13 16:21:13.639959','2026-08-13 16:21:13.640000',1812,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1326,280,'refunded','card','cs_test_a1xHzDOYQLWsFfEN8sX6BdgVnRn0LUobWrVeH8kOye3v5YSeVTogolS9Cl','2026-08-16 16:18:21.284658','2026-08-16 16:18:21.287389','2026-08-16 16:23:25.508629',1853,1,1,252,'on a retenu 10% pour le nettoyage et l''huile ajoutée aux roues','','');
INSERT INTO "payments_payment" VALUES(1327,220,'refunded','card','cs_test_a1I9Z1VcVohu2KETwiLA8qHmGtd8gyJU3ro1TAIoo1G3JqDUeXNl0p18RE','2026-08-16 17:00:21.426035','2026-08-16 17:00:21.428791','2026-08-16 17:01:17.652450',1854,1,1,210,'test retenue','','');
INSERT INTO "payments_payment" VALUES(1328,950,'refunded','card','cs_test_a1cgW0AwsrX3BL02p4QFPPA9jkRPcAhyoNXPRQLb9RMixO2EKErXLWun9M','2026-08-16 17:25:52.730433','2026-08-16 17:25:52.734062','2026-08-16 17:41:06.831199',1855,1,1,950,'aucune retenue','','');
INSERT INTO "payments_payment" VALUES(1329,950,'refunded','card','cs_test_a1p97JhOULql5wH8lgGwmhh5dHwxHT1Zh5btVofJXb1vyiRh1KuZ7Cj9Hv','2026-08-16 17:51:53.663135','2026-08-16 17:51:53.666959','2026-08-16 17:53:17.355326',1856,1,1,950,'test 2','','');
INSERT INTO "payments_payment" VALUES(1330,260,'refunded','card','cs_test_a1FYJiDOrbwUPbAvwmHQ1cU59S9kXCnLBuhe0ZP2ZAztcInxefQU2aKPir','2026-08-16 19:11:09.280009','2026-08-16 19:11:09.281643','2026-08-16 19:26:28.530228',1857,0,1,234,'[Virement] IBAN : be684818489451651 — Titulaire : jean','','');
INSERT INTO "payments_payment" VALUES(1331,170,'paid','card','cs_test_a1kaHPhyAswIxLAVJ6K4EI1dW8KV91j9WZkSxQOHF25pSraNk02bAz034V','2026-08-23 10:25:29.319602','2026-08-23 10:25:29.322160','2026-08-23 10:25:29.322182',1858,1,1,NULL,NULL,'','');
INSERT INTO "payments_payment" VALUES(1332,220,'paid','card','cs_test_a187qpUeHBnDRH3v0cI59hShYQPVwWAgTZ09MbTU7aILcqWkRSP8AbPjA1','2026-08-23 15:28:46.202254','2026-08-23 15:28:46.205324','2026-08-23 15:28:46.205353',1859,1,0,NULL,NULL,'','');
CREATE TABLE "payments_testimonial" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "rating" smallint unsigned NOT NULL CHECK ("rating" >= 0), "comment" text NOT NULL, "is_visible" bool NOT NULL, "created_at" datetime NOT NULL, "payment_id" bigint NOT NULL UNIQUE REFERENCES "payments_payment" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "comment_en" text NOT NULL, "comment_nl" text NOT NULL, "deleted_at" datetime NULL, "is_deleted" bool NOT NULL, "admin_reply" text NOT NULL, "admin_reply_at" datetime NULL);
INSERT INTO "payments_testimonial" VALUES(1,5,'la vente s''est faite magnifiquement, merci à Sohaib qui a répondu à ma demande malgré le timing serré. Il a été pro et m''a donné un max d''information sur la trottinette.',1,'2026-08-10 17:18:05.693538',1264,1374,'The sale went perfectly, many thanks to Sohaib who responded to my request despite the tight timing. He was professional and gave me a lot of information about the scooter.','De verkoop verliep uitstekend, veel dank aan Sohaib die op mijn aanvraag heeft gereageerd ondanks de krappe timing. Hij was professioneel en gaf me veel informatie over de step.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(2,3,'l''achat s''est passé sans encombre mais mauvaise surprise après 1 semaine, la roue a éclaté... bon dans l''ensemble.',1,'2026-08-10 17:26:38.311537',1267,1372,'The purchase went smoothly but bad surprise after 1 week, the tyre blew out... overall it is fine though.','De aankoop verliep vlot maar een onaangename verrassing na 1 week: de band is geklapt... over het algemeen toch in orde.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(3,5,'excellente voiture pour apprendre à conduire, je viens de passer le permis et roule vraiment bien. Le vendeur m''a prevenu des petites réparations à prévoir mais ça fait toujours tout drôle une fois chez le mécano car les montants sont toujours un peu plus élevés.. mais sinon très bien.',1,'2026-08-10 17:29:08.863310',1263,1372,'Excellent car for learning to drive, I just got my licence and it handles really well. The seller warned me about some minor repairs needed, which always feels a bit odd once you are at the garage and the bill is a bit higher than expected... but overall very happy.','Uitstekende auto om te leren rijden, ik heb net mijn rijbewijs gehaald en hij rijdt heel goed. De verkoper heeft me gewaarschuwd voor enkele kleine herstellingen, maar dat voelt altijd een beetje vreemd als je bij de garage bent en de rekening iets hoger uitvalt dan verwacht... maar over het algemeen zeer tevreden.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(4,5,'Super experience du debut a la fin ! La Renault Clio etait exactement comme decrite, tres bien entretenue. Le processus de reservation est simple et clair. Je recommande MultiDrive sans hesitation.',1,'2026-08-10 17:45:38.879561',1271,1252,'Amazing experience from start to finish! The Renault Clio was exactly as described, very well maintained. The booking process is simple and clear. I recommend MultiDrive without hesitation.','Geweldige ervaring van begin tot eind! De Renault Clio was precies zoals beschreven, zeer goed onderhouden. Het reserveringsproces is eenvoudig en duidelijk. Ik beveel MultiDrive absoluut aan.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(5,4,'Tres bonne plateforme pour acheter une voiture d occasion. La Peugeot 206 tourne parfaitement. Petit bemol sur les delais de reponse mais tout s est bien passe au final.',1,'2026-08-10 17:45:38.901278',1272,1253,'Very good platform to buy a used car. The Peugeot 206 runs perfectly. Minor issue with response times but everything went well in the end.','Heel goed platform om een tweedehands auto te kopen. De Peugeot 206 rijdt perfect. Kleine opmerking over de reactietijden maar uiteindelijk is alles goed verlopen.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(6,5,'Vraiment impressionnant ! La Renault Twingo est en excellent etat, bien mieux que ce a quoi je m attendais pour ce prix. Le suivi du paiement en ligne est tres pratique.',1,'2026-08-10 17:45:38.921435',1273,1254,'Really impressive! The Renault Twingo is in excellent condition, much better than I expected for this price. The online payment tracking is very convenient.','Echt indrukwekkend! De Renault Twingo is in uitstekende staat, veel beter dan ik verwachtte voor deze prijs. De online betalingsopvolging is heel handig.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(7,3,'Experience correcte dans l ensemble. La Citroen C2 correspond a la description mais j ai eu quelques difficultes a joindre le support. Le vehicule roule bien, ca reste l essentiel.',1,'2026-08-10 17:45:38.943604',1274,1255,'Overall decent experience. The Citroen C2 matches the description but I had some difficulty reaching support. The vehicle runs well, which is the main thing.','Over het algemeen een behoorlijke ervaring. De Citroen C2 klopt met de beschrijving maar ik had moeite om de klantenservice te bereiken. Het voertuig rijdt goed, dat is het belangrijkste.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(8,5,'Achat parfait ! La Peugeot 207 est nickel, propre et bien entretenue. Le site est tres facile a utiliser et toutes les informations sont claires. Je reviendrai sans hesiter pour mon prochain vehicule.',1,'2026-08-10 17:45:38.970185',1275,1256,'Perfect purchase! The Peugeot 207 is spotless, clean and well maintained. The website is very easy to use and all information is clear. I will return without hesitation for my next vehicle.','Perfecte aankoop! De Peugeot 207 is vlekkeloos, schoon en goed onderhouden. De website is heel gemakkelijk te gebruiken en alle informatie is duidelijk. Ik kom zeker terug voor mijn volgende voertuig.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(9,4,'Bonne experience globale. La Citroen C3 roule comme une horloge. J aurais aime avoir plus de photos mais le vehicule est a la hauteur. Prix honnete pour la qualite proposee.',1,'2026-08-10 17:45:38.996609',1276,1257,'Good overall experience. The Citroen C3 runs like clockwork. I would have liked more photos but the vehicle delivers. Honest price for the quality offered.','Goede algemene ervaring. De Citroen C3 rijdt als een klok. Ik had graag meer fotos gehad maar het voertuig stelt niet teleur. Eerlijke prijs voor de aangeboden kwaliteit.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(10,2,'Decevu par la communication. Le vehicule en lui-meme est correct mais j ai du relancer plusieurs fois pour obtenir des informations. Esperons que ce soit un cas isole.',1,'2026-08-10 17:45:39.027543',1277,1258,'Disappointed by the communication. The vehicle itself is fine but I had to follow up several times to get information. Hopefully this is an isolated case.','Teleurgesteld door de communicatie. Het voertuig zelf is in orde maar ik moest meerdere keren opvolgen om informatie te krijgen. Hopelijk is dit een uitzonderlijk geval.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(11,4,'Tres satisfaite de mon achat ! La Peugeot 207 est dans un etat impeccable. Le systeme de paiement en ligne est securise et simple. Je recommande a tous ceux qui cherchent un vehicule fiable.',1,'2026-08-10 17:45:39.056618',1278,1259,'Very satisfied with my purchase! The Peugeot 207 is in impeccable condition. The online payment system is secure and simple. I recommend it to everyone looking for a reliable vehicle.','Heel tevreden met mijn aankoop! De Peugeot 207 is in onberispelijke staat. Het online betaalsysteem is veilig en eenvoudig. Ik beveel het aan voor iedereen die op zoek is naar een betrouwbaar voertuig.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(12,3,'petit soucis avec les documents mais équipe réactive dommage car ça m''a fait raté une offre de mon assurance (-2 étoiles pour ça...)',1,'2026-08-10 18:03:32.306273',1268,1252,'small problem with the documents but reactive team damage because it made me miss an offer of my insurance (-2 stars for that...)','klein probleem met de documenten maar reactieve teamschade omdat het me een aanbod van mijn verzekering liet missen (-2 sterren daarvoor...)',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(13,4,'Trottinette en bon etat, livraison rapide. Je l''utilise tous les jours pour aller au travail, franchement top rapport qualite-prix. Rien a redire sur le suivi de commande.',1,'2026-08-10 18:04:57.914572',1279,1260,'Scooter in good condition, fast delivery. I use it every day to go to work, frankly top quality-price ratio. Nothing to complain about order tracking.','Scooter in goede staat, snelle levering. Ik gebruik het elke dag om naar mijn werk te gaan, eerlijk gezegd de beste prijs-kwaliteitverhouding. Niets te klagen over het volgen van bestellingen.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(14,5,'La Xiaomi Mi Electric Scooter 3 est vraiment une belle surprise ! Autonomie excellente, confort de conduite au top. Le processus d''achat sur MultiDrive est clair et rassure. Je recommande vivement.',1,'2026-08-10 18:05:01.384824',1280,1261,'The Xiaomi Mi Electric Scooter 3 is really a nice surprise! Excellent autonomy, driving comfort at the top. The purchase process on MultiDrive is clear and reassuring. I highly recommend it.','De Xiaomi Mi Elektrische Scooter 3 is echt een leuke verrassing! Uitstekende autonomie, rijcomfort aan de top. Het aankoopproces op MultiDrive is duidelijk en geruststellend. Ik raad het ten zeerste aan.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(15,3,'Velo en etat correct mais quelques rayures non mentionnees dans l''annonce. Le service client a repondu rapidement, ce qui est appreciable. Dans l''ensemble ca reste un bon achat pour le prix.',1,'2026-08-10 18:05:04.669626',1281,1262,'Bike in correct condition but some scratches not mentioned in the ad. Customer service responded quickly, which is appreciable. Overall it remains a good buy for the price.','Fiets in goede staat, maar sommige krassen zijn niet vermeld in de advertentie. De klantenservice reageerde snel, wat merkbaar is. Over het algemeen blijft het een goede koop voor de prijs.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(16,5,'Excellent achat ! Le Giant Escape 3 est parfait pour mes trajets quotidiens. Tres bien entretenu, mecanique impeccable. La plateforme est serieuse et le paiement securise. Je reviendrai sans hesiter.',1,'2026-08-10 18:05:07.826724',1282,1263,'Great buy! The Giant Escape 3 is perfect for my daily commute. Very well maintained, impeccable mechanics. The platform is serious and the payment is secure. I''ll be right back.','Geweldige aankoop! De Giant Escape 3 is perfect voor mijn dagelijkse woon-werkverkeer. Zeer goed onderhouden, onberispelijke monteurs. Het platform is serieus en de betaling is veilig. Ik ben zo terug.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(17,2,'Decepu. Le scooter avait un probleme de demarrage non signale dans l''annonce. Heureusement le vendeur a accepte de revoir le prix. Communication difficile au debut mais ca s est arrange.',1,'2026-08-10 18:05:10.915546',1283,1264,'Deceptive. The scooter had a non-reported start problem in the listing. Fortunately, the seller agreed to review the price. Difficult communication at the beginning but it worked out.','Misleidend. De scooter had een niet-gerapporteerd startprobleem in de accommodatie. Gelukkig stemde de verkoper ermee in om de prijs te herzien. Moeilijke communicatie in het begin, maar het is gelukt.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(18,2,'Pas terrible. Le vendeur a ete long a repondre et le vehicule avait plus de rayures que sur les photos. Je suis decu.',1,'2026-08-10 18:27:47.709732',1294,1410,'Not great. The seller took a long time to answer and the vehicle had more scratches than in the photos. I''m disappointed.','Niet geweldig. Het duurde lang voordat de verkoper antwoordde en het voertuig had meer krassen dan op de foto''s. Ik ben teleurgesteld.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(19,1,'Arnaque pure et simple. Le moteur avait un probleme cache, rien n''etait mentionne. Je ne recommande pas ce site.',0,'2026-08-10 18:27:49.028965',1295,1411,'Outright scam. The engine had a hidden problem, nothing was mentioned. I do not recommend this site.','Ronduit oplichterij. De motor had een verborgen probleem, er werd niets vermeld. Ik raad deze site niet aan.','2026-08-13 16:36:37.106593',1,'',NULL);
INSERT INTO "payments_testimonial" VALUES(20,3,'Experience moyenne. Le vehicule etait en bon etat mais la communication avec le service client laissait a desirer.',1,'2026-08-10 18:27:50.384512',1296,1412,'Average experience. The vehicle was in good condition but communication with customer service left something to be desired.','Gemiddelde ervaring. Het voertuig was in goede staat, maar de communicatie met de klantenservice liet iets te wensen over.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(21,2,'Trop cher pour ce que c''est. Le prix afiche ne reflete pas l''etat reel du vehicule. A revoir.',1,'2026-08-10 18:27:51.660918',1297,1413,'Too expensive for what it is. The display price does not reflect the actual state of the vehicle. See you again.','Te duur voor wat het is. De weergegeven prijs geeft niet de werkelijke staat van het voertuig weer. Tot ziens.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(22,1,'Vehicule non conforme. Photos trompeuses, etat beaucoup moins bon qu''annonce. Remboursement laborieux.',0,'2026-08-10 18:27:52.940504',1298,1414,'Non-compliant vehicle. Misleading photos, state much worse than advertisement. Laborious reimbursement.','Niet-conform voertuig. Misleidende foto''s, staat veel erger dan reclame. Arbeidsintensieve vergoeding.','2026-08-13 16:36:14.052730',1,'',NULL);
INSERT INTO "payments_testimonial" VALUES(23,2,'Service lent. Il m''a fallu 3 semaines pour avoir une reponse. Pas acceptable pour une plateforme professionnelle.',0,'2026-08-10 18:27:54.306239',1299,1415,'Slow service. It took me 3 weeks to get an answer. Not acceptable for a professional platform.','Trage service. Het kostte me 3 weken om een antwoord te krijgen. Niet acceptabel voor een professioneel platform.','2026-08-13 16:36:04.828380',1,'',NULL);
INSERT INTO "payments_testimonial" VALUES(24,3,'Bof. Le vehicule roule mais j''ai eu des surprises. La description etait trop optimiste sur l''etat mecanique.',1,'2026-08-10 18:27:55.728984',1300,1416,'Bof. The vehicle is moving but I had surprises. The description was too optimistic about the mechanical state.','Bof. Het voertuig beweegt, maar ik had verrassingen. De beschrijving was te optimistisch over de mechanische toestand.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(26,2,'Livraison impossible dans ma region. Cette information n''etait pas claire du tout sur l''annonce.',1,'2026-08-10 18:27:58.443178',1302,1418,'Unable to deliver to my area. This information was not clear at all about the listing.','Kan niet bezorgen in mijn regio. Deze informatie was helemaal niet duidelijk over de accommodatie.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(27,2,'Paiement complique. L''interface Stripe a bugue deux fois. J''ai fini par payer par virement a la main.',1,'2026-08-10 18:27:59.896623',1303,1419,'Payment complicated. Stripe interface bugged twice. I ended up paying by hand transfer.','Betaling gecompliceerd. Stripe-interface twee keer afgeluisterd. Uiteindelijk heb ik per handoverschrijving betaald.',NULL,0,'',NULL);
INSERT INTO "payments_testimonial" VALUES(28,3,'Vehicule correct mais le suivi apres-vente inexistant. Impossible de joindre quelqu''un apres l''achat.',0,'2026-08-10 18:28:01.279439',1304,1420,'Correct vehicle but after-sales follow-up does not exist. Unable to reach someone after purchase.','Correct voertuig, maar follow-up na verkoop bestaat niet. Kan na aankoop niemand bereiken.','2026-08-21 13:59:43.631606',1,'Nous sommes désolé, un message vous a été envoyé au 14/06/26 et au 18/06/2026 sans suite, nous vous avons également contacté via votre profil + téléphone','2026-08-13 16:42:25.914316');
CREATE TABLE "reservations_reservation" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "status" varchar(20) NOT NULL, "message" text NULL, "appointment_date" datetime NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "vehicle_id" bigint NOT NULL REFERENCES "vehicles_vehicle" ("id") DEFERRABLE INITIALLY DEFERRED, "user_status_read" bool NOT NULL, "phone" varchar(20) NOT NULL);
INSERT INTO "reservations_reservation" VALUES(1600,'accepted','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-03 12:36:04.646419','2026-05-23 12:36:04.646994','2026-05-23 12:36:04.647001',1255,1630,1,'');
INSERT INTO "reservations_reservation" VALUES(1603,'accepted','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-10 12:36:04.648706','2026-05-23 12:36:04.649276','2026-05-23 12:36:04.649283',1258,1633,1,'');
INSERT INTO "reservations_reservation" VALUES(1604,'accepted','Je suis interesse pour une visite rapide.','2026-05-24 12:36:04.649464','2026-05-23 12:36:04.650039','2026-05-23 12:36:04.650045',1259,1634,1,'');
INSERT INTO "reservations_reservation" VALUES(1606,'accepted','Le prix est-il negociable ?','2026-06-11 12:36:04.650987','2026-05-23 12:36:04.651556','2026-05-23 12:36:04.651563',1261,1636,1,'');
INSERT INTO "reservations_reservation" VALUES(1609,'accepted','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-04 12:36:04.653263','2026-05-23 12:36:04.653840','2026-05-23 12:36:04.653847',1264,1639,1,'');
INSERT INTO "reservations_reservation" VALUES(1612,'accepted','Le prix est-il negociable ?','2026-06-01 12:36:04.655544','2026-05-23 12:36:04.656125','2026-05-23 12:36:04.656131',1267,1642,1,'');
INSERT INTO "reservations_reservation" VALUES(1615,'accepted','Le prix est-il negociable ?','2026-06-04 12:36:04.657832','2026-05-23 12:36:04.658400','2026-05-23 12:36:04.658407',1270,1645,1,'');
INSERT INTO "reservations_reservation" VALUES(1616,'accepted','Pouvez-vous confirmer que le vehicule est disponible ?','2026-05-26 12:36:04.658590','2026-05-23 12:36:04.659165','2026-05-23 12:36:04.659172',1271,1646,1,'');
INSERT INTO "reservations_reservation" VALUES(1618,'accepted','Je suis interesse pour une visite rapide.','2026-05-27 12:36:04.660110','2026-05-23 12:36:04.660677','2026-05-23 12:36:04.660684',1273,1648,1,'');
INSERT INTO "reservations_reservation" VALUES(1621,'accepted','Je suis interesse pour une visite rapide.','2026-06-05 12:36:04.662393','2026-05-23 12:36:04.662961','2026-05-23 12:36:04.662968',1276,1651,1,'');
INSERT INTO "reservations_reservation" VALUES(1624,'accepted','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-05 12:36:04.664795','2026-05-23 12:36:04.665367','2026-05-23 12:36:04.665374',1279,1654,1,'');
INSERT INTO "reservations_reservation" VALUES(1627,'accepted','Je souhaite venir voir le vehicule cette semaine.','2026-06-02 12:36:04.667075','2026-05-23 12:36:04.667638','2026-05-23 12:36:04.667645',1282,1657,1,'');
INSERT INTO "reservations_reservation" VALUES(1628,'accepted','Je suis interesse pour une visite rapide.','2026-05-30 12:36:04.667839','2026-05-23 12:36:04.668406','2026-05-23 12:36:04.668412',1283,1658,1,'');
INSERT INTO "reservations_reservation" VALUES(1630,'accepted','Je suis interesse pour une visite rapide.','2026-06-07 12:36:04.669356','2026-05-23 12:36:04.669925','2026-05-23 12:36:04.669931',1285,1660,1,'');
INSERT INTO "reservations_reservation" VALUES(1633,'accepted','Pouvez-vous confirmer que le vehicule est disponible ?','2026-05-29 12:36:04.671617','2026-05-23 12:36:04.672186','2026-05-23 12:36:04.672193',1288,1663,1,'');
INSERT INTO "reservations_reservation" VALUES(1636,'accepted','Le prix est-il negociable ?','2026-06-02 12:36:04.673879','2026-05-23 12:36:04.674442','2026-05-23 12:36:04.674449',1291,1666,1,'');
INSERT INTO "reservations_reservation" VALUES(1639,'accepted','Je souhaite venir voir le vehicule cette semaine.','2026-05-31 12:36:04.676144','2026-05-23 12:36:04.676713','2026-05-23 12:36:04.676720',1294,1669,1,'');
INSERT INTO "reservations_reservation" VALUES(1642,'accepted','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-13 12:36:04.678404','2026-05-23 12:36:04.679026','2026-05-23 12:36:04.679051',1297,1672,1,'');
INSERT INTO "reservations_reservation" VALUES(1645,'accepted','Le prix est-il negociable ?','2026-05-28 12:36:04.681210','2026-05-23 12:36:04.681773','2026-05-23 12:36:04.681780',1300,1675,1,'');
INSERT INTO "reservations_reservation" VALUES(1648,'accepted','Le prix est-il negociable ?','2026-06-09 12:36:04.683476','2026-05-23 12:36:04.684042','2026-05-23 12:36:04.684049',1303,1678,1,'');
INSERT INTO "reservations_reservation" VALUES(1651,'accepted','Pouvez-vous confirmer que le vehicule est disponible ?','2026-05-28 12:36:04.685744','2026-05-23 12:36:04.686318','2026-05-23 12:36:04.686325',1306,1681,1,'');
INSERT INTO "reservations_reservation" VALUES(1654,'deposit_paid','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-10 12:36:04.688023','2026-05-23 12:36:04.688585','2026-05-23 12:36:04.688593',1309,1684,1,'');
INSERT INTO "reservations_reservation" VALUES(1657,'deposit_paid','Je suis interesse pour une visite rapide.','2026-05-31 12:36:04.690287','2026-05-23 12:36:04.690850','2026-05-23 12:36:04.690857',1312,1687,1,'');
INSERT INTO "reservations_reservation" VALUES(1658,'deposit_paid','Je suis interesse pour une visite rapide.','2026-06-09 12:36:04.691037','2026-05-23 12:36:04.691598','2026-05-23 12:36:04.691605',1313,1688,1,'');
INSERT INTO "reservations_reservation" VALUES(1660,'deposit_paid','Le prix est-il negociable ?','2026-06-01 12:36:04.692544','2026-05-23 12:36:04.693107','2026-05-23 12:36:04.693114',1315,1690,1,'');
INSERT INTO "reservations_reservation" VALUES(1663,'deposit_paid','Je suis interesse pour une visite rapide.','2026-06-03 12:36:04.694906','2026-05-23 12:36:04.695565','2026-05-23 12:36:04.695572',1318,1693,1,'');
INSERT INTO "reservations_reservation" VALUES(1666,'deposit_paid','Le prix est-il negociable ?','2026-05-31 12:36:04.698067','2026-05-23 12:36:04.698737','2026-05-23 12:36:04.698746',1321,1696,1,'');
INSERT INTO "reservations_reservation" VALUES(1669,'deposit_paid','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-06 12:36:04.700443','2026-05-23 12:36:04.701005','2026-05-23 12:36:04.701012',1324,1699,1,'');
INSERT INTO "reservations_reservation" VALUES(1672,'deposit_paid','Je souhaite venir voir le vehicule cette semaine.','2026-05-30 12:36:04.702708','2026-05-23 12:36:04.703272','2026-05-23 12:36:04.703280',1327,1702,1,'');
INSERT INTO "reservations_reservation" VALUES(1675,'deposit_paid','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-08 12:36:04.704982','2026-05-23 12:36:04.705544','2026-05-23 12:36:04.705551',1330,1705,1,'');
INSERT INTO "reservations_reservation" VALUES(1678,'deposit_paid','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-10 12:36:04.707263','2026-05-23 12:36:04.707831','2026-05-23 12:36:04.707838',1333,1708,1,'');
INSERT INTO "reservations_reservation" VALUES(1681,'deposit_paid','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-08 12:36:04.709519','2026-05-23 12:36:04.710090','2026-05-23 12:36:04.710097',1336,1711,1,'');
INSERT INTO "reservations_reservation" VALUES(1684,'deposit_paid','Le prix est-il negociable ?','2026-06-07 12:36:04.711860','2026-05-23 12:36:04.712423','2026-05-23 12:36:04.712430',1339,1714,1,'');
INSERT INTO "reservations_reservation" VALUES(1687,'deposit_paid','Je souhaite venir voir le vehicule cette semaine.','2026-05-26 12:36:04.714113','2026-05-23 12:36:04.714671','2026-05-23 12:36:04.714678',1342,1717,1,'');
INSERT INTO "reservations_reservation" VALUES(1690,'deposit_paid','Je souhaite venir voir le vehicule cette semaine.','2026-06-01 12:36:04.716372','2026-05-23 12:36:04.716936','2026-05-23 12:36:04.716943',1345,1720,1,'');
INSERT INTO "reservations_reservation" VALUES(1693,'deposit_paid','Je suis interesse pour une visite rapide.','2026-06-03 12:36:04.718629','2026-05-23 12:36:04.719193','2026-05-23 12:36:04.719200',1348,1723,1,'');
INSERT INTO "reservations_reservation" VALUES(1696,'deposit_paid','Je souhaite venir voir le vehicule cette semaine.','2026-06-08 12:36:04.720890','2026-05-23 12:36:04.721451','2026-05-23 12:36:04.721458',1351,1726,1,'');
INSERT INTO "reservations_reservation" VALUES(1699,'deposit_paid','Le prix est-il negociable ?','2026-06-13 12:36:04.723148','2026-05-23 12:36:04.723713','2026-05-23 12:36:04.723720',1354,1729,1,'');
INSERT INTO "reservations_reservation" VALUES(1702,'deposit_paid','Le prix est-il negociable ?','2026-05-30 12:36:04.725416','2026-05-23 12:36:04.725980','2026-05-23 12:36:04.725987',1357,1732,1,'');
INSERT INTO "reservations_reservation" VALUES(1705,'deposit_paid','Le prix est-il negociable ?','2026-06-08 12:36:04.727761','2026-05-23 12:36:04.728326','2026-05-23 12:36:04.728334',1360,1735,1,'');
INSERT INTO "reservations_reservation" VALUES(1708,'accepted','Je suis interesse pour une visite rapide.','2026-06-04 12:36:04.730018','2026-05-23 12:36:04.730583','2026-08-10 17:53:33.290853',1363,1738,1,'');
INSERT INTO "reservations_reservation" VALUES(1711,'accepted','Je suis interesse pour une visite rapide.','2026-05-27 12:36:04.732280','2026-05-23 12:36:04.732837','2026-08-10 17:53:33.299274',1366,1741,1,'');
INSERT INTO "reservations_reservation" VALUES(1714,'accepted','Le prix est-il negociable ?','2026-05-26 12:36:04.734522','2026-05-23 12:36:04.735084','2026-08-10 17:53:33.304609',1369,1744,1,'');
INSERT INTO "reservations_reservation" VALUES(1717,'accepted','Je souhaite venir voir le vehicule cette semaine.','2026-05-23 12:36:04','2026-05-23 12:36:04.737337','2026-05-23 12:59:16.490464',1252,1747,1,'');
INSERT INTO "reservations_reservation" VALUES(1718,'accepted','Je souhaite venir voir le vehicule cette semaine.','2026-06-04 12:36:04.737525','2026-05-23 12:36:04.738090','2026-08-10 17:53:33.308807',1253,1748,1,'');
INSERT INTO "reservations_reservation" VALUES(1720,'accepted','Je souhaite venir voir le vehicule cette semaine.','2026-06-09 12:36:04.739043','2026-05-23 12:36:04.739606','2026-08-10 17:53:33.312426',1255,1750,1,'');
INSERT INTO "reservations_reservation" VALUES(1723,'accepted','Je souhaite venir voir le vehicule cette semaine.','2026-08-12 12:36:04','2026-05-23 12:36:04.741974','2026-08-03 10:50:37.850405',1258,1753,0,'');
INSERT INTO "reservations_reservation" VALUES(1726,'accepted','Pouvez-vous confirmer que le vehicule est disponible ?','2026-05-29 12:36:04.744141','2026-05-23 12:36:04.744709','2026-08-10 17:53:33.315749',1261,1756,1,'');
INSERT INTO "reservations_reservation" VALUES(1729,'rejected','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-11 12:36:04.746413','2026-05-23 12:36:04.746974','2026-05-23 12:36:04.746980',1264,1759,1,'');
INSERT INTO "reservations_reservation" VALUES(1732,'rejected','Je suis interesse pour une visite rapide.','2026-06-07 12:36:04.748663','2026-05-23 12:36:04.749222','2026-05-23 12:36:04.749229',1267,1762,1,'');
INSERT INTO "reservations_reservation" VALUES(1735,'rejected','Je souhaite venir voir le vehicule cette semaine.','2026-06-08 12:36:04.750913','2026-05-23 12:36:04.751479','2026-05-23 12:36:04.751486',1270,1765,1,'');
INSERT INTO "reservations_reservation" VALUES(1738,'rejected','Je suis interesse pour une visite rapide.','2026-06-01 12:36:04.753176','2026-05-23 12:36:04.753744','2026-05-23 12:36:04.753751',1273,1768,1,'');
INSERT INTO "reservations_reservation" VALUES(1741,'rejected','Je souhaite venir voir le vehicule cette semaine.','2026-06-09 12:36:04.755442','2026-05-23 12:36:04.756003','2026-05-23 12:36:04.756010',1276,1771,1,'');
INSERT INTO "reservations_reservation" VALUES(1744,'rejected','Pouvez-vous confirmer que le vehicule est disponible ?','2026-06-10 12:36:04.757688','2026-05-23 12:36:04.758426','2026-05-23 12:36:04.758433',1279,1774,1,'');
INSERT INTO "reservations_reservation" VALUES(1747,'rejected','Je souhaite venir voir le vehicule cette semaine.','2026-05-26 12:36:04.760138','2026-05-23 12:36:04.760705','2026-05-23 12:36:04.760711',1282,1777,1,'');
INSERT INTO "reservations_reservation" VALUES(1750,'deposit_paid','j''adore','2026-06-13 13:55:00','2026-06-12 10:55:42.252147','2026-06-12 10:59:34.171346',1373,1658,0,'');
INSERT INTO "reservations_reservation" VALUES(1753,'deposit_paid','on va tester l''adresse e-mail admin multidrive25 pour voir si l''intégration gmail est ok','2026-06-19 17:00:00','2026-06-18 10:58:51.252108','2026-06-18 11:15:47.328749',1372,1646,0,'');
INSERT INTO "reservations_reservation" VALUES(1754,'cancelled','bonjour, je veux cette trotinette !!  et en même temps testons le workflow entièrement.','2026-06-18 21:00:00','2026-06-18 16:13:38.663217','2026-08-13 08:38:19.877789',1374,1634,1,'');
INSERT INTO "reservations_reservation" VALUES(1755,'cancelled','je veux ce vélo, il est trop beau et super accessible niveau prix','2026-08-03 11:06:55','2026-08-03 11:04:59.226974','2026-08-17 17:46:19.295339',1372,1748,1,'');
INSERT INTO "reservations_reservation" VALUES(1756,'cancelled','','2026-08-03 16:30:00','2026-08-03 11:27:28.554799','2026-08-17 17:37:23.524400',1372,1688,1,'');
INSERT INTO "reservations_reservation" VALUES(1757,'cancelled','','2026-08-07 16:01:00','2026-08-07 10:43:04.292090','2026-08-16 19:39:50.399996',1372,2049,1,'');
INSERT INTO "reservations_reservation" VALUES(1758,'deposit_paid','','2026-08-10 17:39:00','2026-08-10 15:40:00.892462','2026-08-10 18:02:38.234131',1252,1987,0,'');
INSERT INTO "reservations_reservation" VALUES(1759,'cancelled','je veux cette trottinette à tout prix, elle me plait énormément... Plusieurs amis ont commandé sur votre site, c''est vraiment top.','2026-08-10 17:44:00','2026-08-10 15:45:17.334367','2026-08-23 10:24:16.912396',1372,2057,1,'');
INSERT INTO "reservations_reservation" VALUES(1760,'deposit_paid','trop beau, la trottinette me parait un peu petite donc un rendez-vous serait top. Je bosse toute la semaine, donc aujourd''hui seul creneaux disponible !','2026-08-10 18:00:00','2026-08-10 16:00:42.109390','2026-08-10 16:10:46.156733',1373,2057,0,'');
INSERT INTO "reservations_reservation" VALUES(1761,'deposit_paid','je veux ce véhicule svp, les photos sont belles mais il me faut voir ce vélo pour l''acheter !','2026-08-10 18:20:00','2026-08-10 16:09:24.629612','2026-08-10 16:11:29.145070',1373,2050,0,'');
INSERT INTO "reservations_reservation" VALUES(1762,'accepted','Reservation de demonstration.',NULL,'2026-08-10 17:45:38.852245','2026-08-10 17:45:38.852310',1252,1968,1,'');
INSERT INTO "reservations_reservation" VALUES(1763,'accepted','Reservation de demonstration.',NULL,'2026-08-10 17:45:38.889634','2026-08-10 17:45:38.889654',1253,1973,1,'');
INSERT INTO "reservations_reservation" VALUES(1764,'accepted','Reservation de demonstration.',NULL,'2026-08-10 17:45:38.907851','2026-08-10 17:45:38.907871',1254,1971,1,'');
INSERT INTO "reservations_reservation" VALUES(1765,'accepted','Reservation de demonstration.',NULL,'2026-08-10 17:45:38.929414','2026-08-10 17:45:38.929434',1255,1977,1,'');
INSERT INTO "reservations_reservation" VALUES(1766,'accepted','Reservation de demonstration.',NULL,'2026-08-10 17:45:38.952985','2026-08-10 17:45:38.953020',1256,1974,1,'');
INSERT INTO "reservations_reservation" VALUES(1767,'accepted','Reservation de demonstration.',NULL,'2026-08-10 17:45:38.980564','2026-08-10 17:45:38.980598',1257,1978,1,'');
INSERT INTO "reservations_reservation" VALUES(1768,'accepted','Reservation de demonstration.',NULL,'2026-08-10 17:45:39.009154','2026-08-10 17:45:39.009188',1258,1972,1,'');
INSERT INTO "reservations_reservation" VALUES(1769,'accepted','Reservation de demonstration.',NULL,'2026-08-10 17:45:39.038668','2026-08-10 17:45:39.038700',1259,1975,1,'');
INSERT INTO "reservations_reservation" VALUES(1770,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:04:57.882942','2026-08-10 18:04:57.883099',1260,2061,1,'');
INSERT INTO "reservations_reservation" VALUES(1771,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:05:01.355337','2026-08-10 18:05:01.355396',1261,2055,1,'');
INSERT INTO "reservations_reservation" VALUES(1772,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:05:04.640281','2026-08-10 18:05:04.640344',1262,2051,1,'');
INSERT INTO "reservations_reservation" VALUES(1773,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:05:07.811798','2026-08-10 18:05:07.811832',1263,2044,1,'');
INSERT INTO "reservations_reservation" VALUES(1774,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:05:10.887471','2026-08-10 18:05:10.887530',1264,2042,1,'');
INSERT INTO "reservations_reservation" VALUES(1775,'cancelled','Je change d''avis, je n''ai finalement pas besoin du vehicule.',NULL,'2026-08-10 18:27:17.873167','2026-07-31 18:26:59.997816',1388,1973,1,'');
INSERT INTO "reservations_reservation" VALUES(1776,'cancelled','J''ai trouve une meilleure offre ailleurs.',NULL,'2026-08-10 18:27:19.205973','2026-07-22 18:26:59.997816',1389,2016,1,'');
INSERT INTO "reservations_reservation" VALUES(1777,'cancelled','Ma situation financiere a change, je dois annuler.',NULL,'2026-08-10 18:27:20.592243','2026-05-05 18:26:59.997816',1390,2013,1,'');
INSERT INTO "reservations_reservation" VALUES(1778,'cancelled','Le vehicule ne correspond pas exactement a mes attentes.',NULL,'2026-08-10 18:27:22.005555','2026-06-15 18:26:59.997816',1391,2034,1,'');
INSERT INTO "reservations_reservation" VALUES(1779,'cancelled','J''ai obtenu un pret mais le delai est trop long.',NULL,'2026-08-10 18:27:23.427938','2026-06-15 18:26:59.997816',1392,2009,1,'');
INSERT INTO "reservations_reservation" VALUES(1780,'cancelled','Probleme personnel, je dois reporter indefiniment.',NULL,'2026-08-10 18:27:24.714197','2026-05-07 18:26:59.997816',1393,2040,1,'');
INSERT INTO "reservations_reservation" VALUES(1781,'cancelled','Le vehicule a ete vendu avant que je finalise.',NULL,'2026-08-10 18:27:26.048668','2026-06-04 18:26:59.997816',1394,2047,1,'');
INSERT INTO "reservations_reservation" VALUES(1782,'cancelled','Trop loin de chez moi pour la livraison.',NULL,'2026-08-10 18:27:27.398248','2026-06-10 18:26:59.997816',1395,1990,1,'');
INSERT INTO "reservations_reservation" VALUES(1783,'cancelled','J''ai finalement opte pour un vehicule neuf.',NULL,'2026-08-10 18:27:28.897718','2026-06-05 18:26:59.997816',1396,1970,1,'');
INSERT INTO "reservations_reservation" VALUES(1784,'cancelled','Mon permis de conduire est en cours de renouvellement.',NULL,'2026-08-10 18:27:30.242231','2026-06-02 18:26:59.997816',1397,2019,1,'');
INSERT INTO "reservations_reservation" VALUES(1785,'cancelled','Budget revise a la baisse, impossible de continuer.',NULL,'2026-08-10 18:27:31.516663','2026-05-04 18:26:59.997816',1398,1993,1,'');
INSERT INTO "reservations_reservation" VALUES(1786,'cancelled','Demenagement prevu, pas le bon moment pour acheter.',NULL,'2026-08-10 18:27:32.832137','2026-05-09 18:26:59.997816',1399,2059,1,'');
INSERT INTO "reservations_reservation" VALUES(1787,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:34.129529','2026-08-10 18:27:34.129549',1400,2038,1,'');
INSERT INTO "reservations_reservation" VALUES(1788,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:35.500627','2026-08-10 18:27:35.500679',1401,2041,1,'');
INSERT INTO "reservations_reservation" VALUES(1789,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:36.940805','2026-08-10 18:27:36.940845',1402,1974,1,'');
INSERT INTO "reservations_reservation" VALUES(1790,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:38.321465','2026-08-10 18:27:38.321488',1403,2032,1,'');
INSERT INTO "reservations_reservation" VALUES(1791,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:39.727091','2026-08-10 18:27:39.727116',1404,1971,1,'');
INSERT INTO "reservations_reservation" VALUES(1792,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:41.002945','2026-08-10 18:27:41.002967',1405,2006,1,'');
INSERT INTO "reservations_reservation" VALUES(1793,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:42.335933','2026-08-10 18:27:42.335970',1406,2024,1,'');
INSERT INTO "reservations_reservation" VALUES(1794,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:43.748064','2026-08-10 18:27:43.748086',1407,1983,1,'');
INSERT INTO "reservations_reservation" VALUES(1795,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:45.007390','2026-08-10 18:27:45.007417',1408,2061,1,'');
INSERT INTO "reservations_reservation" VALUES(1796,'cancelled','Annulation apres acompte — remboursement traite.',NULL,'2026-08-10 18:27:46.424120','2026-08-10 18:27:46.424145',1409,2004,1,'');
INSERT INTO "reservations_reservation" VALUES(1797,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:47.698849','2026-08-10 18:27:47.698875',1410,2051,1,'');
INSERT INTO "reservations_reservation" VALUES(1798,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:49.016040','2026-08-10 18:27:49.016068',1411,2023,1,'');
INSERT INTO "reservations_reservation" VALUES(1799,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:50.374216','2026-08-10 18:27:50.374245',1412,2022,1,'');
INSERT INTO "reservations_reservation" VALUES(1800,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:51.651105','2026-08-10 18:27:51.651127',1413,1988,1,'');
INSERT INTO "reservations_reservation" VALUES(1801,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:52.930185','2026-08-10 18:27:52.930209',1414,2039,1,'');
INSERT INTO "reservations_reservation" VALUES(1802,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:54.296679','2026-08-10 18:27:54.296701',1415,2001,1,'');
INSERT INTO "reservations_reservation" VALUES(1803,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:55.719099','2026-08-10 18:27:55.719120',1416,1999,1,'');
INSERT INTO "reservations_reservation" VALUES(1804,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:57.027303','2026-08-10 18:27:57.027353',1417,2035,1,'');
INSERT INTO "reservations_reservation" VALUES(1805,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:58.432798','2026-08-10 18:27:58.432824',1418,2011,1,'');
INSERT INTO "reservations_reservation" VALUES(1806,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:27:59.887311','2026-08-10 18:27:59.887334',1419,1982,1,'');
INSERT INTO "reservations_reservation" VALUES(1807,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:28:01.267500','2026-08-10 18:28:01.267523',1420,2008,1,'');
INSERT INTO "reservations_reservation" VALUES(1808,'accepted','Reservation de demonstration.',NULL,'2026-08-10 18:28:02.595879','2026-08-10 18:28:02.595902',1421,2044,1,'');
INSERT INTO "reservations_reservation" VALUES(1809,'cancelled','puis-je voir ce véhicule svp ? pour apprendre à conduire.','2026-08-13 16:50:00','2026-08-13 08:44:56.870202','2026-08-13 08:48:34.567393',1374,1977,1,'');
INSERT INTO "reservations_reservation" VALUES(1810,'rejected','excellent prix, puis-je venir voir et tester la voiture ? la voiture me parait très bien pour apprendre à conduire et pour la vie de tout les jours','2026-08-13 16:58:00','2026-08-13 08:56:19.098121','2026-08-13 08:58:46.539900',1374,1968,1,'0484489864');
INSERT INTO "reservations_reservation" VALUES(1811,'rejected','relance TEST','2026-08-13 16:12:00','2026-08-13 09:08:12.172584','2026-08-13 09:09:11.734380',1374,1968,1,'048489863');
INSERT INTO "reservations_reservation" VALUES(1812,'deposit_paid','test 2','2026-08-13 16:25:00','2026-08-13 09:19:28.943223','2026-08-13 16:21:13.650948',1374,1968,0,'0484489864');
INSERT INTO "reservations_reservation" VALUES(1813,'rejected','test refus','2026-08-14 17:23:00','2026-08-13 09:21:54.121637','2026-08-13 09:22:35.481805',1374,2044,1,'0484489864');
INSERT INTO "reservations_reservation" VALUES(1814,'accepted','Je suis interesse par ce vehicule depuis plusieurs semaines, j''aimerais pouvoir le voir rapidement.','2026-08-06 09:29:09.856164','2026-07-22 09:29:09.856164','2026-07-24 09:29:09.856164',1431,1771,1,'+32 480 01 23 45');
INSERT INTO "reservations_reservation" VALUES(1815,'accepted','Ce modele correspond exactement a ce que je recherche. Quelles sont les disponibilites pour une visite ?','2026-08-24 09:29:09.856164','2026-07-24 09:29:09.856164','2026-07-26 09:29:09.856164',1446,1753,1,'+32 495 56 78 90');
INSERT INTO "reservations_reservation" VALUES(1816,'accepted','Je voudrais prendre rendez-vous pour un essai. Je suis disponible en semaine.','2026-08-21 09:29:09.856164','2026-06-23 09:29:09.856164','2026-06-25 09:29:09.856164',1457,1732,1,'+32 476 77 88 99');
INSERT INTO "reservations_reservation" VALUES(1817,'accepted','Vehicule parfait pour mon usage quotidien. Pouvez-vous me confirmer les disponibilites ?','2026-08-26 09:29:09.856164','2026-06-14 09:29:09.856164','2026-06-16 09:29:09.856164',1433,1998,1,'+32 482 23 45 67');
INSERT INTO "reservations_reservation" VALUES(1818,'accepted','Je cherche un vehicule fiable pour mes trajets professionnels. Ce modele m''interesse vraiment.','2026-08-07 09:29:09.856164','2026-07-22 09:29:09.856164','2026-07-24 09:29:09.856164',1440,1711,1,'+32 489 90 12 34');
INSERT INTO "reservations_reservation" VALUES(1819,'accepted','Apres avoir compare plusieurs offres, je choisis ce vehicule. Comment proceder pour la visite ?','2026-08-11 09:29:09.856164','2026-08-06 09:29:09.856164','2026-08-08 09:29:09.856164',1423,1982,1,'+32 472 23 45 67');
INSERT INTO "reservations_reservation" VALUES(1820,'accepted','Mon vehicule actuel est en fin de vie, j''ai besoin de ce vehicule au plus vite.','2026-09-01 09:29:09.856164','2026-07-04 09:29:09.856164','2026-07-06 09:29:09.856164',1422,2009,1,'+32 471 12 34 56');
INSERT INTO "reservations_reservation" VALUES(1821,'accepted','Je represente une societe et souhaite acquirir ce vehicule pour la flotte. Details a discuter.','2026-08-25 09:29:09.856164','2026-07-02 09:29:09.856164','2026-07-04 09:29:09.856164',1449,2029,1,'+32 498 89 01 23');
INSERT INTO "reservations_reservation" VALUES(1822,'accepted','Famille de 4 personnes, ce vehicule est ideal. Je souhaite le voir au plus vite.','2026-08-10 09:29:09.856164','2026-07-02 09:29:09.856164','2026-07-04 09:29:09.856164',1429,1989,1,'+32 478 89 01 23');
INSERT INTO "reservations_reservation" VALUES(1823,'accepted','Ce vehicule correspond a mon budget. Je suis tres motive pour avancer rapidement.','2026-08-11 09:29:09.856164','2026-07-15 09:29:09.856164','2026-07-17 09:29:09.856164',1458,1634,1,'+32 477 88 99 00');
INSERT INTO "reservations_reservation" VALUES(1824,'accepted','J''ai teste un modele similaire chez un ami, parfait pour mes besoins. Je veux celui-ci.','2026-08-04 09:29:09.856164','2026-08-07 09:29:09.856164','2026-08-09 09:29:09.856164',1452,2030,1,'+32 471 22 33 44');
INSERT INTO "reservations_reservation" VALUES(1825,'accepted','Premiere voiture, budget limite. Ce vehicule est la meilleure option que j''ai trouvee.','2026-08-27 09:29:09.856164','2026-07-18 09:29:09.856164','2026-07-20 09:29:09.856164',1432,1693,1,'+32 481 12 34 56');
INSERT INTO "reservations_reservation" VALUES(1826,'rejected','Je souhaite reserver ce vehicule mais mon budget est un peu serre. Peut-on negocier ?',NULL,'2026-07-20 09:29:09.856164','2026-07-21 09:29:09.856164',1445,1660,1,'+32 494 45 67 89');
INSERT INTO "reservations_reservation" VALUES(1827,'rejected','Interessant, mais j''ai besoin de verification de l''historique avant de m''engager.',NULL,'2026-07-03 09:29:09.856164','2026-07-04 09:29:09.856164',1450,1750,1,'+32 499 90 12 34');
INSERT INTO "reservations_reservation" VALUES(1828,'rejected','Je souhaite reserver, mais j''aurais besoin de plus d''informations sur la garantie.',NULL,'2026-05-25 09:29:09.856164','2026-05-26 09:29:09.856164',1425,2023,1,'+32 474 45 67 89');
INSERT INTO "reservations_reservation" VALUES(1829,'rejected','Le vehicule m''interesse beaucoup, mais je dois d''abord confirmer mon financement.',NULL,'2026-08-04 09:29:09.856164','2026-08-05 09:29:09.856164',1434,1768,1,'+32 483 34 56 78');
INSERT INTO "reservations_reservation" VALUES(1830,'rejected','Est-il possible de tester le vehicule avant de confirmer la reservation ?',NULL,'2026-05-26 09:29:09.856164','2026-05-27 09:29:09.856164',1435,2007,1,'+32 484 45 67 89');
INSERT INTO "reservations_reservation" VALUES(1831,'rejected','Je suis interesse mais j''attends encore un document de mon banquier.',NULL,'2026-07-06 09:29:09.856164','2026-07-07 09:29:09.856164',1428,2060,1,'+32 477 78 90 12');
INSERT INTO "reservations_reservation" VALUES(1832,'rejected','Vehicule attractif. Est-il possible d''avoir un rapport de controle technique recente ?',NULL,'2026-06-13 09:29:09.856164','2026-06-14 09:29:09.856164',1438,2006,1,'+32 487 78 90 12');
INSERT INTO "reservations_reservation" VALUES(1833,'rejected','Je serais interesse si vous pouvez faire un geste sur le prix de base.',NULL,'2026-07-27 09:29:09.856164','2026-07-28 09:29:09.856164',1437,2044,1,'+32 486 67 89 01');
INSERT INTO "reservations_reservation" VALUES(1834,'deposit_paid','Je suis interesse par ce vehicule depuis plusieurs semaines, j''aimerais pouvoir le voir rapidement.',NULL,'2026-07-03 09:29:09.856164','2026-07-06 09:29:09.856164',1459,2047,1,'+32 478 99 00 11');
INSERT INTO "reservations_reservation" VALUES(1835,'deposit_paid','Ce modele correspond exactement a ce que je recherche. Quelles sont les disponibilites pour une visite ?',NULL,'2026-05-29 09:29:09.856164','2026-06-01 09:29:09.856164',1439,1777,1,'+32 488 89 01 23');
INSERT INTO "reservations_reservation" VALUES(1836,'deposit_paid','Je voudrais prendre rendez-vous pour un essai. Je suis disponible en semaine.',NULL,'2026-07-21 09:29:09.856164','2026-07-24 09:29:09.856164',1444,1990,1,'+32 493 34 56 78');
INSERT INTO "reservations_reservation" VALUES(1837,'deposit_paid','Vehicule parfait pour mon usage quotidien. Pouvez-vous me confirmer les disponibilites ?',NULL,'2026-07-06 09:29:09.856164','2026-07-09 09:29:09.856164',1447,2053,1,'+32 496 67 89 01');
INSERT INTO "reservations_reservation" VALUES(1838,'deposit_paid','Je cherche un vehicule fiable pour mes trajets professionnels. Ce modele m''interesse vraiment.',NULL,'2026-06-07 09:29:09.856164','2026-06-10 09:29:09.856164',1442,2054,1,'+32 491 12 34 56');
INSERT INTO "reservations_reservation" VALUES(1839,'deposit_paid','Apres avoir compare plusieurs offres, je choisis ce vehicule. Comment proceder pour la visite ?',NULL,'2026-06-11 09:29:09.856164','2026-06-14 09:29:09.856164',1436,1992,1,'+32 485 56 78 90');
INSERT INTO "reservations_reservation" VALUES(1840,'deposit_paid','Mon vehicule actuel est en fin de vie, j''ai besoin de ce vehicule au plus vite.',NULL,'2026-06-17 09:29:09.856164','2026-06-20 09:29:09.856164',1430,1687,1,'+32 479 90 12 34');
INSERT INTO "reservations_reservation" VALUES(1841,'deposit_paid','Je represente une societe et souhaite acquirir ce vehicule pour la flotte. Details a discuter.',NULL,'2026-07-25 09:29:09.856164','2026-07-28 09:29:09.856164',1426,2057,1,'+32 475 56 78 90');
INSERT INTO "reservations_reservation" VALUES(1842,'deposit_paid','Famille de 4 personnes, ce vehicule est ideal. Je souhaite le voir au plus vite.',NULL,'2026-06-04 09:29:09.856164','2026-06-07 09:29:09.856164',1454,2058,1,'+32 473 44 55 66');
INSERT INTO "reservations_reservation" VALUES(1843,'deposit_paid','Ce vehicule correspond a mon budget. Je suis tres motive pour avancer rapidement.',NULL,'2026-06-28 09:29:09.856164','2026-07-01 09:29:09.856164',1443,1688,1,'+32 492 23 45 67');
INSERT INTO "reservations_reservation" VALUES(1844,'cancelled','Finalement j''ai achete un vehicule neuf, je dois annuler ma reservation.',NULL,'2026-04-06 09:29:09.856164','2026-04-11 09:29:09.856164',1448,1747,1,'+32 497 78 90 12');
INSERT INTO "reservations_reservation" VALUES(1845,'cancelled','Changement de situation professionnelle, je ne peux plus me permettre cet achat.',NULL,'2026-06-01 09:29:09.856164','2026-06-06 09:29:09.856164',1455,1991,1,'+32 474 55 66 77');
INSERT INTO "reservations_reservation" VALUES(1846,'cancelled','J''ai trouve un vehicule similaire plus proche de chez moi.',NULL,'2026-05-13 09:29:09.856164','2026-05-18 09:29:09.856164',1424,2008,1,'+32 473 34 56 78');
INSERT INTO "reservations_reservation" VALUES(1847,'cancelled','Mon dossier de financement n''a pas ete accepte par la banque.',NULL,'2026-06-29 09:29:09.856164','2026-07-04 09:29:09.856164',1456,1999,1,'+32 475 66 77 88');
INSERT INTO "reservations_reservation" VALUES(1848,'cancelled','Demenagement imprevue, je dois reporter cet achat indefiniment.',NULL,'2026-06-15 09:29:09.856164','2026-06-20 09:29:09.856164',1453,2016,1,'+32 472 33 44 55');
INSERT INTO "reservations_reservation" VALUES(1849,'cancelled','Finalement j''ai achete un vehicule neuf, je dois annuler ma reservation.',NULL,'2026-07-29 09:29:09.856164','2026-08-03 09:29:09.856164',1441,2013,1,'+32 490 01 23 45');
INSERT INTO "reservations_reservation" VALUES(1850,'cancelled','Changement de situation professionnelle, je ne peux plus me permettre cet achat.',NULL,'2026-07-29 09:29:09.856164','2026-08-03 09:29:09.856164',1451,1717,1,'+32 470 11 22 33');
INSERT INTO "reservations_reservation" VALUES(1851,'cancelled','J''ai trouve un vehicule similaire plus proche de chez moi.',NULL,'2026-03-18 09:29:09.856164','2026-03-23 09:29:09.856164',1427,1968,1,'+32 476 67 89 01');
INSERT INTO "reservations_reservation" VALUES(1852,'deposit_paid','test 3 prise de rendez-vous','2026-08-13 18:45:00','2026-08-13 10:28:09.643762','2026-08-13 10:39:50.239896',1374,2044,0,'0484489864');
INSERT INTO "reservations_reservation" VALUES(1853,'cancelled','trop belle, puis je la voir svp, rapidement ?','2026-08-17 20:54:00','2026-08-16 15:55:39.398451','2026-08-16 16:20:31.295289',1374,2055,1,'0484489864');
INSERT INTO "reservations_reservation" VALUES(1854,'cancelled','test remboursement','2026-08-17 20:59:00','2026-08-16 16:59:10.080741','2026-08-16 17:00:32.845225',1374,1634,1,'0484489864');
INSERT INTO "reservations_reservation" VALUES(1855,'cancelled','test remboursement','2026-08-17 19:26:00','2026-08-16 17:24:42.058395','2026-08-16 17:25:57.898859',1374,1989,1,'0484489864');
INSERT INTO "reservations_reservation" VALUES(1856,'cancelled','test remboursement','2026-08-17 19:50:00','2026-08-16 17:50:53.960472','2026-08-16 17:52:02.215738',1374,1989,1,'0484489864');
INSERT INTO "reservations_reservation" VALUES(1857,'cancelled','test fonctionnalité','2026-08-17 21:08:00','2026-08-16 19:08:51.725829','2026-08-16 19:11:17.447921',1374,2052,1,'0484489864');
INSERT INTO "reservations_reservation" VALUES(1858,'deposit_paid','je veux voir ce véhicule - il s''agit d''une capture dans le cadre de mon tfe pour montrer comment fonctionne le worklow','2026-08-26 18:22:00','2026-08-23 10:21:31.662238','2026-08-23 10:25:29.339406',1372,1748,0,'0470000119');
INSERT INTO "reservations_reservation" VALUES(1859,'deposit_paid','Reservation de test (audit TFE) sur la copie de demonstration.','2026-08-25 18:00:00','2026-08-23 15:22:37.689016','2026-08-23 15:28:46.218738',1461,1634,0,'+32 470 11 22 33');
CREATE TABLE "vehicles_favorite" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "vehicle_id" bigint NOT NULL REFERENCES "vehicles_vehicle" ("id") DEFERRABLE INITIALLY DEFERRED, CONSTRAINT "unique_favorite_per_user" UNIQUE ("user_id", "vehicle_id"));
INSERT INTO "vehicles_favorite" VALUES(7,'2026-08-13 16:22:36.040631',1374,2052);
INSERT INTO "vehicles_favorite" VALUES(8,'2026-08-16 16:00:08.609318',1374,2055);
INSERT INTO "vehicles_favorite" VALUES(9,'2026-08-16 16:00:10.626937',1374,2061);
INSERT INTO "vehicles_favorite" VALUES(10,'2026-08-16 16:00:18.528607',1374,2056);
CREATE TABLE "vehicles_vehicle" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "title" varchar(120) NOT NULL, "price" decimal NOT NULL, "created_at" datetime NOT NULL, "description" text NULL, "status" varchar(20) NOT NULL, "category_id" bigint NULL REFERENCES "vehicles_vehiclecategory" ("id") DEFERRABLE INITIALLY DEFERRED, "carrosserie" varchar(20) NOT NULL, "condition_notes" text NOT NULL, "moteur" varchar(20) NOT NULL, "description_en" text NULL, "description_nl" text NULL);
INSERT INTO "vehicles_vehicle" VALUES(1630,'Trek FX 1 2018 #003',180,'2026-05-23 12:33:01.573970','Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.','sold',118,'','','','Smooth and economical mobility. Perfect for getting around the city without worrying about traffic or parking.','Zachte en zuinige mobiliteit. Perfect om in de stad rond te rijden zonder zorgen over verkeer of parkeren.');
INSERT INTO "vehicles_vehicle" VALUES(1633,'Xiaomi Mi Electric Scooter 2022 #006',140,'2026-05-23 12:33:01.575886','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1634,'Ninebot ES2 2018 #007',220,'2026-05-23 12:33:01.576713','Solution de mobilite urbaine pratique et economique. Pliable, facile a transporter et simple a utiliser.','sold',119,'','','','Practical and economical urban mobility solution. Foldable, easy to carry and simple to use.','Praktische en zuinige oplossing voor stedelijke mobiliteit. Opvouwbaar, gemakkelijk mee te nemen en eenvoudig te gebruiken.');
INSERT INTO "vehicles_vehicle" VALUES(1636,'Oxelo Town 7 2020 #009',75,'2026-05-23 12:33:01.577977','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1639,'Piaggio Zip 50 2016 #012',690,'2026-05-23 12:33:01.579979','50cc ideal pour les jeunes conducteurs ou les trajets courts. Bon etat general, pret a rouler.','sold',120,'','','','50cc ideal for young riders or short trips. Good general condition, ready to ride.','50cc ideaal voor jonge rijders of korte ritten. Goede algemene staat, rijklaar.');
INSERT INTO "vehicles_vehicle" VALUES(1642,'Yamaha YBR 125 2014 #015',1620,'2026-05-23 12:33:01.582412','Deux-roues fiable et agreable a conduire. Ideal pour les deplacements quotidiens en ville ou en periurbain.','sold',121,'','','','Reliable and pleasant two-wheeler to ride. Ideal for daily commuting in the city or suburbs.','Betrouwbaar en aangenaam tweewielig voertuig. Ideaal voor dagelijkse verplaatsingen in de stad of randgemeenten.');
INSERT INTO "vehicles_vehicle" VALUES(1645,'Renault Clio 2009 #018',1920,'2026-05-23 12:33:01.584381','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','sold',122,'','','','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1646,'Citroen C3 2009 #019',1270,'2026-05-23 12:33:01.585018','Pratique et facile a garer, ce vehicule est parfait pour une utilisation quotidienne en milieu urbain. Faible consommation.','sold',122,'','','','Practical and easy to park, this vehicle is perfect for daily urban use. Low fuel consumption.','Praktisch en gemakkelijk te parkeren, dit voertuig is perfect voor dagelijks stedelijk gebruik. Laag verbruik.');
INSERT INTO "vehicles_vehicle" VALUES(1648,'Toyota Yaris 2006 #021',2290,'2026-05-23 12:33:01.586253','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','sold',122,'','','','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1651,'Volkswagen Golf 2006 #024',1870,'2026-05-23 12:33:01.588142','Un bon compromis entre espace interieur et consommation raisonnable. Vehicule fiable, historique d''entretien disponible.','sold',123,'','','','A good compromise between interior space and reasonable fuel consumption. Reliable vehicle, maintenance history available.','Een goed compromis tussen binnenruimte en redelijk verbruik. Betrouwbaar voertuig, onderhoudshistorie beschikbaar.');
INSERT INTO "vehicles_vehicle" VALUES(1654,'Citroen Berlingo 2006 #027',2180,'2026-05-23 12:33:01.590021','Vehicule en bon etat general, entretien suivi. Une opportunite a saisir pour un achat malin.','sold',125,'','','','Vehicle in good general condition, regular servicing. A great opportunity for a smart purchase.','Voertuig in goede algemene staat, regelmatig onderhouden. Een mooie kans voor een slimme aankoop.');
INSERT INTO "vehicles_vehicle" VALUES(1657,'Dacia Duster 2012 #030',2330,'2026-05-23 12:33:01.591893','Vehicule pratique et spacieux, ideal pour les familles ou les personnes ayant besoin de volume au quotidien.','sold',127,'','','','Practical and spacious vehicle, ideal for families or those who need plenty of room in daily life.','Praktisch en ruim voertuig, ideaal voor gezinnen of personen die dagelijks veel ruimte nodig hebben.');
INSERT INTO "vehicles_vehicle" VALUES(1658,'Decathlon Rockrider 340 2016 #031',100,'2026-05-23 12:33:01.592686','Velo polyvalent adapte aussi bien a la ville qu''aux chemins de campagne. Bon etat general, peu utilise.','sold',118,'','','','Versatile bike suited to both the city and country paths. Good general condition, lightly used.','Veelzijdige fiets geschikt voor zowel de stad als landelijke paden. Goede algemene staat, weinig gebruikt.');
INSERT INTO "vehicles_vehicle" VALUES(1660,'Trek FX 1 2019 #033',260,'2026-05-23 12:33:01.593943','Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.','sold',118,'','','','Smooth and economical mobility. Perfect for getting around the city without worrying about traffic or parking.','Zachte en zuinige mobiliteit. Perfect om in de stad rond te rijden zonder zorgen over verkeer of parkeren.');
INSERT INTO "vehicles_vehicle" VALUES(1663,'Xiaomi Mi Electric Scooter 2021 #036',190,'2026-05-23 12:33:01.596234','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1666,'Oxelo Town 7 2018 #039',75,'2026-05-23 12:33:01.598126','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1669,'Piaggio Zip 50 2015 #042',1150,'2026-05-23 12:33:01.600004','50cc ideal pour les jeunes conducteurs ou les trajets courts. Bon etat general, pret a rouler.','sold',120,'','','','50cc ideal for young riders or short trips. Good general condition, ready to ride.','50cc ideaal voor jonge rijders of korte ritten. Goede algemene staat, rijklaar.');
INSERT INTO "vehicles_vehicle" VALUES(1672,'Yamaha YBR 125 2015 #045',1610,'2026-05-23 12:33:01.601868','Moto legere et maniable, ideale pour debuter ou pour les trajets urbains quotidiens. Entretien a jour.','sold',121,'','','','Light and manoeuvrable motorcycle, ideal for beginners or daily urban commuting. Up-to-date servicing.','Lichte en wendbare motor, ideaal voor beginners of dagelijkse stedelijke ritten. Onderhoud up-to-date.');
INSERT INTO "vehicles_vehicle" VALUES(1675,'Renault Clio 2007 #048',1290,'2026-05-23 12:33:01.603737','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','sold',122,'','','','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1678,'Toyota Yaris 2009 #051',1200,'2026-05-23 12:33:01.605611','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','sold',122,'','','','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1681,'Volkswagen Golf 2006 #054',1590,'2026-05-23 12:33:01.607522','Un bon compromis entre espace interieur et consommation raisonnable. Vehicule fiable, historique d''entretien disponible.','sold',123,'','','','A good compromise between interior space and reasonable fuel consumption. Reliable vehicle, maintenance history available.','Een goed compromis tussen binnenruimte en redelijk verbruik. Betrouwbaar voertuig, onderhoudshistorie beschikbaar.');
INSERT INTO "vehicles_vehicle" VALUES(1684,'Citroen Berlingo 2008 #057',1520,'2026-05-23 12:33:01.609605','Vehicule en bon etat general, entretien suivi. Une opportunite a saisir pour un achat malin.','sold',125,'','','','Vehicle in good general condition, regular servicing. A great opportunity for a smart purchase.','Voertuig in goede algemene staat, regelmatig onderhouden. Een mooie kans voor een slimme aankoop.');
INSERT INTO "vehicles_vehicle" VALUES(1687,'Dacia Duster 2011 #060',1950,'2026-05-23 12:33:01.611479','Vehicule pratique et spacieux, ideal pour les familles ou les personnes ayant besoin de volume au quotidien.','sold',127,'','','','Practical and spacious vehicle, ideal for families or those who need plenty of room in daily life.','Praktisch en ruim voertuig, ideaal voor gezinnen of personen die dagelijks veel ruimte nodig hebben.');
INSERT INTO "vehicles_vehicle" VALUES(1688,'Decathlon Rockrider 340 2016 #061',150,'2026-05-23 12:33:01.612096','Velo polyvalent adapte aussi bien a la ville qu''aux chemins de campagne. Bon etat general, peu utilise.','available',118,'','','','Versatile bike suited to both the city and country paths. Good general condition, lightly used.','Veelzijdige fiets geschikt voor zowel de stad als landelijke paden. Goede algemene staat, weinig gebruikt.');
INSERT INTO "vehicles_vehicle" VALUES(1690,'Trek FX 1 2020 #063',310,'2026-05-23 12:33:01.613336','Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.','sold',118,'','','','Smooth and economical mobility. Perfect for getting around the city without worrying about traffic or parking.','Zachte en zuinige mobiliteit. Perfect om in de stad rond te rijden zonder zorgen over verkeer of parkeren.');
INSERT INTO "vehicles_vehicle" VALUES(1693,'Xiaomi Mi Electric Scooter 2020 #066',220,'2026-05-23 12:33:01.615197','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1696,'Oxelo Town 7 2018 #069',55,'2026-05-23 12:33:01.617062','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1699,'Piaggio Zip 50 2014 #072',590,'2026-05-23 12:33:01.619007','50cc ideal pour les jeunes conducteurs ou les trajets courts. Bon etat general, pret a rouler.','sold',120,'','','','50cc ideal for young riders or short trips. Good general condition, ready to ride.','50cc ideaal voor jonge rijders of korte ritten. Goede algemene staat, rijklaar.');
INSERT INTO "vehicles_vehicle" VALUES(1702,'Yamaha YBR 125 2013 #075',1200,'2026-05-23 12:33:01.620962','Deux-roues fiable et agreable a conduire. Ideal pour les deplacements quotidiens en ville ou en periurbain.','sold',121,'','','','Reliable and pleasant two-wheeler to ride. Ideal for daily commuting in the city or suburbs.','Betrouwbaar en aangenaam tweewielig voertuig. Ideaal voor dagelijkse verplaatsingen in de stad of randgemeenten.');
INSERT INTO "vehicles_vehicle" VALUES(1705,'Renault Clio 2010 #078',1620,'2026-05-23 12:33:01.622817','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','sold',122,'','','','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1708,'Toyota Yaris 2008 #081',1740,'2026-05-23 12:33:01.624666','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','sold',122,'','','','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1711,'Volkswagen Golf 2007 #084',2420,'2026-05-23 12:33:01.626625','Un bon compromis entre espace interieur et consommation raisonnable. Vehicule fiable, historique d''entretien disponible.','sold',123,'','','','A good compromise between interior space and reasonable fuel consumption. Reliable vehicle, maintenance history available.','Een goed compromis tussen binnenruimte en redelijk verbruik. Betrouwbaar voertuig, onderhoudshistorie beschikbaar.');
INSERT INTO "vehicles_vehicle" VALUES(1714,'Citroen Berlingo 2006 #087',1850,'2026-05-23 12:33:01.628501','Vehicule en bon etat general, entretien suivi. Une opportunite a saisir pour un achat malin.','sold',125,'','','','Vehicle in good general condition, regular servicing. A great opportunity for a smart purchase.','Voertuig in goede algemene staat, regelmatig onderhouden. Een mooie kans voor een slimme aankoop.');
INSERT INTO "vehicles_vehicle" VALUES(1717,'Dacia Duster 2011 #090',1950,'2026-05-23 12:33:01.630374','Vehicule pratique et spacieux, ideal pour les familles ou les personnes ayant besoin de volume au quotidien.','sold',127,'','','','Practical and spacious vehicle, ideal for families or those who need plenty of room in daily life.','Praktisch en ruim voertuig, ideaal voor gezinnen of personen die dagelijks veel ruimte nodig hebben.');
INSERT INTO "vehicles_vehicle" VALUES(1720,'Trek FX 1 2018 #093',260,'2026-05-23 12:33:01.632246','Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.','sold',118,'','','','Smooth and economical mobility. Perfect for getting around the city without worrying about traffic or parking.','Zachte en zuinige mobiliteit. Perfect om in de stad rond te rijden zonder zorgen over verkeer of parkeren.');
INSERT INTO "vehicles_vehicle" VALUES(1723,'Xiaomi Mi Electric Scooter 2022 #096',210,'2026-05-23 12:33:01.634105','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1726,'Oxelo Town 7 2019 #099',75,'2026-05-23 12:33:01.635988','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1729,'Piaggio Zip 50 2017 #102',1140,'2026-05-23 12:33:01.637859','50cc ideal pour les jeunes conducteurs ou les trajets courts. Bon etat general, pret a rouler.','sold',120,'','','','50cc ideal for young riders or short trips. Good general condition, ready to ride.','50cc ideaal voor jonge rijders of korte ritten. Goede algemene staat, rijklaar.');
INSERT INTO "vehicles_vehicle" VALUES(1732,'Yamaha YBR 125 2012 #105',1710,'2026-05-23 12:33:01.639730','Moto legere et maniable, ideale pour debuter ou pour les trajets urbains quotidiens. Entretien a jour.','sold',121,'','','','Light and manoeuvrable motorcycle, ideal for beginners or daily urban commuting. Up-to-date servicing.','Lichte en wendbare motor, ideaal voor beginners of dagelijkse stedelijke ritten. Onderhoud up-to-date.');
INSERT INTO "vehicles_vehicle" VALUES(1735,'Renault Clio 2007 #108',1200,'2026-05-23 12:33:01.641588','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','sold',122,'','','','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1738,'Toyota Yaris 2009 #111',1360,'2026-05-23 12:33:01.643570','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','sold',122,'','','','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1741,'Volkswagen Golf 2005 #114',1490,'2026-05-23 12:33:01.645455','Un bon compromis entre espace interieur et consommation raisonnable. Vehicule fiable, historique d''entretien disponible.','sold',123,'','','','A good compromise between interior space and reasonable fuel consumption. Reliable vehicle, maintenance history available.','Een goed compromis tussen binnenruimte en redelijk verbruik. Betrouwbaar voertuig, onderhoudshistorie beschikbaar.');
INSERT INTO "vehicles_vehicle" VALUES(1744,'Citroen Berlingo 2006 #117',1970,'2026-05-23 12:33:01.647335','Vehicule en bon etat general, entretien suivi. Une opportunite a saisir pour un achat malin.','sold',125,'','','','Vehicle in good general condition, regular servicing. A great opportunity for a smart purchase.','Voertuig in goede algemene staat, regelmatig onderhouden. Een mooie kans voor een slimme aankoop.');
INSERT INTO "vehicles_vehicle" VALUES(1747,'Dacia Duster 2011 #120',2320,'2026-05-23 12:33:01.649217','Vehicule pratique et spacieux, ideal pour les familles ou les personnes ayant besoin de volume au quotidien.','sold',127,'','','','Practical and spacious vehicle, ideal for families or those who need plenty of room in daily life.','Praktisch en ruim voertuig, ideaal voor gezinnen of personen die dagelijks veel ruimte nodig hebben.');
INSERT INTO "vehicles_vehicle" VALUES(1748,'Decathlon Rockrider 340 2018 #121',170,'2026-05-23 12:33:01.649841','Velo polyvalent adapte aussi bien a la ville qu''aux chemins de campagne. Bon etat general, peu utilise.','sold',118,'','','','Versatile bike suited to both the city and country paths. Good general condition, lightly used.','Veelzijdige fiets geschikt voor zowel de stad als landelijke paden. Goede algemene staat, weinig gebruikt.');
INSERT INTO "vehicles_vehicle" VALUES(1750,'Trek FX 1 2019 #123',170,'2026-05-23 12:33:01.651112','Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.','sold',118,'','','','Smooth and economical mobility. Perfect for getting around the city without worrying about traffic or parking.','Zachte en zuinige mobiliteit. Perfect om in de stad rond te rijden zonder zorgen over verkeer of parkeren.');
INSERT INTO "vehicles_vehicle" VALUES(1753,'Xiaomi Mi Electric Scooter 2021 #126',320,'2026-05-23 12:33:01.652979','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1756,'Oxelo Town 7 2019 #129',45,'2026-05-23 12:33:01.654852','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','sold',119,'','','','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(1759,'Piaggio Zip 50 2015 #132',830,'2026-05-23 12:33:01.656717','50cc ideal pour les jeunes conducteurs ou les trajets courts. Bon etat general, pret a rouler.','sold',120,'','','','50cc ideal for young riders or short trips. Good general condition, ready to ride.','50cc ideaal voor jonge rijders of korte ritten. Goede algemene staat, rijklaar.');
INSERT INTO "vehicles_vehicle" VALUES(1762,'Yamaha YBR 125 2013 #135',1540,'2026-05-23 12:33:01.658785','Deux-roues fiable et agreable a conduire. Ideal pour les deplacements quotidiens en ville ou en periurbain.','sold',121,'','','','Reliable and pleasant two-wheeler to ride. Ideal for daily commuting in the city or suburbs.','Betrouwbaar en aangenaam tweewielig voertuig. Ideaal voor dagelijkse verplaatsingen in de stad of randgemeenten.');
INSERT INTO "vehicles_vehicle" VALUES(1765,'Renault Clio 2007 #138',1780,'2026-05-23 12:33:01.660849','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','sold',122,'','','','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1768,'Toyota Yaris 2008 #141',2190,'2026-05-23 12:33:01.662723','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','sold',122,'','','','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1771,'Volkswagen Golf 2006 #144',1920,'2026-05-23 12:33:01.664604','Un bon compromis entre espace interieur et consommation raisonnable. Vehicule fiable, historique d''entretien disponible.','sold',123,'','','','A good compromise between interior space and reasonable fuel consumption. Reliable vehicle, maintenance history available.','Een goed compromis tussen binnenruimte en redelijk verbruik. Betrouwbaar voertuig, onderhoudshistorie beschikbaar.');
INSERT INTO "vehicles_vehicle" VALUES(1774,'Citroen Berlingo 2006 #147',1840,'2026-05-23 12:33:01.666481','Vehicule en bon etat general, entretien suivi. Une opportunite a saisir pour un achat malin.','sold',125,'','','','Vehicle in good general condition, regular servicing. A great opportunity for a smart purchase.','Voertuig in goede algemene staat, regelmatig onderhouden. Een mooie kans voor een slimme aankoop.');
INSERT INTO "vehicles_vehicle" VALUES(1777,'Dacia Duster 2014 #150',2120,'2026-05-23 12:33:01.668358','Vehicule pratique et spacieux, ideal pour les familles ou les personnes ayant besoin de volume au quotidien.','sold',127,'','','','Practical and spacious vehicle, ideal for families or those who need plenty of room in daily life.','Praktisch en ruim voertuig, ideaal voor gezinnen of personen die dagelijks veel ruimte nodig hebben.');
INSERT INTO "vehicles_vehicle" VALUES(1968,'Renault Clio 2004 #001',900,'2026-08-06 14:52:30.633902','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','sold',122,'accidente','','reparation','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1969,'Renault Clio 2006 #002',1400,'2026-08-06 14:52:30.636065','Vehicule economique et polyvalent. Parfait pour les petits budgets qui recherchent fiabilite et praticite.','available',122,'accidente','','reparation','Economical and versatile vehicle. Perfect for small budgets seeking reliability and practicality.','Zuinig en veelzijdig voertuig. Perfect voor kleine budgetten die op zoek zijn naar betrouwbaarheid en praktisch gemak.');
INSERT INTO "vehicles_vehicle" VALUES(1970,'Renault Clio 2009 #003',2000,'2026-08-06 14:52:30.637721','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','available',122,'accidente','','reparation','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1971,'Renault Twingo 2005 #004',750,'2026-08-06 14:52:30.639336','Pratique et facile a garer, ce vehicule est parfait pour une utilisation quotidienne en milieu urbain. Faible consommation.','available',122,'accidente','','reparation','Practical and easy to park, this vehicle is perfect for daily urban use. Low fuel consumption.','Praktisch en gemakkelijk te parkeren, dit voertuig is perfect voor dagelijks stedelijk gebruik. Laag verbruik.');
INSERT INTO "vehicles_vehicle" VALUES(1972,'Renault Twingo 2008 #005',1100,'2026-08-06 14:52:30.640973','Un excellent choix pour un premier vehicule ou un usage urbain. Maniable, sobre et fiable au quotidien.','available',122,'accidente','','reparation','An excellent choice for a first vehicle or urban use. Manoeuvrable, economical and reliable in daily use.','Een uitstekende keuze voor een eerste voertuig of stedelijk gebruik. Wendbaar, zuinig en betrouwbaar in het dagelijks leven.');
INSERT INTO "vehicles_vehicle" VALUES(1973,'Peugeot 206 2004 #006',800,'2026-08-06 14:52:30.642561','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','available',122,'accidente','','reparation','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1974,'Peugeot 207 2007 #007',1300,'2026-08-06 14:52:30.644170','Vehicule economique et polyvalent. Parfait pour les petits budgets qui recherchent fiabilite et praticite.','available',122,'accidente','','reparation','Economical and versatile vehicle. Perfect for small budgets seeking reliability and practicality.','Zuinig en veelzijdig voertuig. Perfect voor kleine budgetten die op zoek zijn naar betrouwbaarheid en praktisch gemak.');
INSERT INTO "vehicles_vehicle" VALUES(1975,'Peugeot 207 2010 #008',1800,'2026-08-06 14:52:30.645255','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','available',122,'accidente','','reparation','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1976,'Peugeot 208 2013 #009',2600,'2026-08-06 14:52:30.646854','Pratique et facile a garer, ce vehicule est parfait pour une utilisation quotidienne en milieu urbain. Faible consommation.','available',122,'bon','','bon','Practical and easy to park, this vehicle is perfect for daily urban use. Low fuel consumption.','Praktisch en gemakkelijk te parkeren, dit voertuig is perfect voor dagelijks stedelijk gebruik. Laag verbruik.');
INSERT INTO "vehicles_vehicle" VALUES(1977,'Citroen C2 2005 #010',850,'2026-08-06 14:52:30.647999','Un excellent choix pour un premier vehicule ou un usage urbain. Maniable, sobre et fiable au quotidien.','available',122,'accidente','','reparation','An excellent choice for a first vehicle or urban use. Manoeuvrable, economical and reliable in daily use.','Een uitstekende keuze voor een eerste voertuig of stedelijk gebruik. Wendbaar, zuinig en betrouwbaar in het dagelijks leven.');
INSERT INTO "vehicles_vehicle" VALUES(1978,'Citroen C3 2005 #011',1100,'2026-08-06 14:52:30.649168','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','available',122,'accidente','','reparation','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1979,'Citroen C3 2008 #012',1600,'2026-08-06 14:52:30.650371','Vehicule economique et polyvalent. Parfait pour les petits budgets qui recherchent fiabilite et praticite.','available',122,'accidente','','reparation','Economical and versatile vehicle. Perfect for small budgets seeking reliability and practicality.','Zuinig en veelzijdig voertuig. Perfect voor kleine budgetten die op zoek zijn naar betrouwbaarheid en praktisch gemak.');
INSERT INTO "vehicles_vehicle" VALUES(1980,'Ford Fiesta 2005 #013',1000,'2026-08-06 14:52:30.651651','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','available',122,'accidente','','reparation','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1981,'Ford Fiesta 2008 #014',1600,'2026-08-06 14:52:30.652753','Pratique et facile a garer, ce vehicule est parfait pour une utilisation quotidienne en milieu urbain. Faible consommation.','available',122,'accidente','','reparation','Practical and easy to park, this vehicle is perfect for daily urban use. Low fuel consumption.','Praktisch en gemakkelijk te parkeren, dit voertuig is perfect voor dagelijks stedelijk gebruik. Laag verbruik.');
INSERT INTO "vehicles_vehicle" VALUES(1982,'Ford Fiesta 2011 #015',2200,'2026-08-06 14:52:30.653826','Un excellent choix pour un premier vehicule ou un usage urbain. Maniable, sobre et fiable au quotidien.','available',122,'bon','','bon','An excellent choice for a first vehicle or urban use. Manoeuvrable, economical and reliable in daily use.','Een uitstekende keuze voor een eerste voertuig of stedelijk gebruik. Wendbaar, zuinig en betrouwbaar in het dagelijks leven.');
INSERT INTO "vehicles_vehicle" VALUES(1983,'Volkswagen Polo 2006 #016',1400,'2026-08-06 14:52:30.654978','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','available',122,'accidente','','reparation','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1984,'Volkswagen Polo 2009 #017',2000,'2026-08-06 14:52:30.656048','Vehicule economique et polyvalent. Parfait pour les petits budgets qui recherchent fiabilite et praticite.','available',122,'accidente','','reparation','Economical and versatile vehicle. Perfect for small budgets seeking reliability and practicality.','Zuinig en veelzijdig voertuig. Perfect voor kleine budgetten die op zoek zijn naar betrouwbaarheid en praktisch gemak.');
INSERT INTO "vehicles_vehicle" VALUES(1985,'Toyota Yaris 2005 #018',1100,'2026-08-06 14:52:30.657116','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','available',122,'accidente','','reparation','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1986,'Toyota Yaris 2008 #019',1700,'2026-08-06 14:52:30.658174','Pratique et facile a garer, ce vehicule est parfait pour une utilisation quotidienne en milieu urbain. Faible consommation.','available',122,'accidente','','reparation','Practical and easy to park, this vehicle is perfect for daily urban use. Low fuel consumption.','Praktisch en gemakkelijk te parkeren, dit voertuig is perfect voor dagelijks stedelijk gebruik. Laag verbruik.');
INSERT INTO "vehicles_vehicle" VALUES(1987,'Fiat Punto 2005 #020',800,'2026-08-06 14:52:30.659242','Un excellent choix pour un premier vehicule ou un usage urbain. Maniable, sobre et fiable au quotidien.','sold',122,'accidente','','reparation','An excellent choice for a first vehicle or urban use. Manoeuvrable, economical and reliable in daily use.','Een uitstekende keuze voor een eerste voertuig of stedelijk gebruik. Wendbaar, zuinig en betrouwbaar in het dagelijks leven.');
INSERT INTO "vehicles_vehicle" VALUES(1988,'Fiat 500 2009 #021',1600,'2026-08-06 14:52:30.660311','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','available',122,'accidente','','reparation','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1989,'Opel Corsa 2005 #022',950,'2026-08-06 14:52:30.661376','Vehicule economique et polyvalent. Parfait pour les petits budgets qui recherchent fiabilite et praticite.','available',122,'accidente','','reparation','Economical and versatile vehicle. Perfect for small budgets seeking reliability and practicality.','Zuinig en veelzijdig voertuig. Perfect voor kleine budgetten die op zoek zijn naar betrouwbaarheid en praktisch gemak.');
INSERT INTO "vehicles_vehicle" VALUES(1990,'Opel Corsa 2008 #023',1500,'2026-08-06 14:52:30.662434','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','available',122,'accidente','','reparation','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1991,'Dacia Sandero 2009 #024',1800,'2026-08-06 14:52:30.663500','Pratique et facile a garer, ce vehicule est parfait pour une utilisation quotidienne en milieu urbain. Faible consommation.','available',122,'accidente','','reparation','Practical and easy to park, this vehicle is perfect for daily urban use. Low fuel consumption.','Praktisch en gemakkelijk te parkeren, dit voertuig is perfect voor dagelijks stedelijk gebruik. Laag verbruik.');
INSERT INTO "vehicles_vehicle" VALUES(1992,'Dacia Sandero 2012 #025',2400,'2026-08-06 14:52:30.664555','Un excellent choix pour un premier vehicule ou un usage urbain. Maniable, sobre et fiable au quotidien.','available',122,'bon','','bon','An excellent choice for a first vehicle or urban use. Manoeuvrable, economical and reliable in daily use.','Een uitstekende keuze voor een eerste voertuig of stedelijk gebruik. Wendbaar, zuinig en betrouwbaar in het dagelijks leven.');
INSERT INTO "vehicles_vehicle" VALUES(1993,'Seat Ibiza 2006 #026',1100,'2026-08-06 14:52:30.665622','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','available',122,'accidente','','reparation','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1994,'Seat Ibiza 2009 #027',1700,'2026-08-06 14:52:30.666692','Vehicule economique et polyvalent. Parfait pour les petits budgets qui recherchent fiabilite et praticite.','available',122,'accidente','','reparation','Economical and versatile vehicle. Perfect for small budgets seeking reliability and practicality.','Zuinig en veelzijdig voertuig. Perfect voor kleine budgetten die op zoek zijn naar betrouwbaarheid en praktisch gemak.');
INSERT INTO "vehicles_vehicle" VALUES(1995,'Hyundai i10 2009 #028',1200,'2026-08-06 14:52:30.667767','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','available',122,'accidente','','reparation','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(1996,'Hyundai i20 2011 #029',1800,'2026-08-06 14:52:30.668857','Pratique et facile a garer, ce vehicule est parfait pour une utilisation quotidienne en milieu urbain. Faible consommation.','available',122,'bon','','bon','Practical and easy to park, this vehicle is perfect for daily urban use. Low fuel consumption.','Praktisch en gemakkelijk te parkeren, dit voertuig is perfect voor dagelijks stedelijk gebruik. Laag verbruik.');
INSERT INTO "vehicles_vehicle" VALUES(1997,'Kia Picanto 2007 #030',1000,'2026-08-06 14:52:30.669933','Un excellent choix pour un premier vehicule ou un usage urbain. Maniable, sobre et fiable au quotidien.','available',122,'accidente','','reparation','An excellent choice for a first vehicle or urban use. Manoeuvrable, economical and reliable in daily use.','Een uitstekende keuze voor een eerste voertuig of stedelijk gebruik. Wendbaar, zuinig en betrouwbaar in het dagelijks leven.');
INSERT INTO "vehicles_vehicle" VALUES(1998,'Kia Picanto 2010 #031',1500,'2026-08-06 14:52:30.670999','Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.','available',122,'accidente','','reparation','Small city car with ideal dimensions for urban use. Regular servicing done, ready to drive without surprises.','Kleine stadsauto met ideale afmetingen voor de stad. Regelmatig onderhoud uitgevoerd, rijklaar zonder verrassingen.');
INSERT INTO "vehicles_vehicle" VALUES(1999,'Suzuki Swift 2007 #032',1200,'2026-08-06 14:52:30.672050','Vehicule economique et polyvalent. Parfait pour les petits budgets qui recherchent fiabilite et praticite.','available',122,'accidente','','reparation','Economical and versatile vehicle. Perfect for small budgets seeking reliability and practicality.','Zuinig en veelzijdig voertuig. Perfect voor kleine budgetten die op zoek zijn naar betrouwbaarheid en praktisch gemak.');
INSERT INTO "vehicles_vehicle" VALUES(2000,'Skoda Fabia 2008 #033',1300,'2026-08-06 14:52:30.673115','Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.','available',122,'accidente','','reparation','Compact and economical city car, ideal for urban use and daily short trips. Regular servicing, well-maintained interior.','Compacte en zuinige stadsauto, ideaal voor de stad en dagelijkse korte ritten. Regelmatig onderhouden, goed bewaard interieur.');
INSERT INTO "vehicles_vehicle" VALUES(2001,'Renault Megane 2004 #034',1400,'2026-08-06 14:52:30.674171','Un bon compromis entre espace interieur et consommation raisonnable. Vehicule fiable, historique d''entretien disponible.','available',123,'accidente','','reparation','A good compromise between interior space and reasonable fuel consumption. Reliable vehicle, maintenance history available.','Een goed compromis tussen binnenruimte en redelijk verbruik. Betrouwbaar voertuig, onderhoudshistorie beschikbaar.');
INSERT INTO "vehicles_vehicle" VALUES(2002,'Renault Megane 2007 #035',1900,'2026-08-06 14:52:30.675233','Habitacle spacieux et conduite agreable. Ideale pour une utilisation familiale ou des trajets mixtes.','available',123,'accidente','','reparation','Spacious interior and pleasant drive. Ideal for family use or mixed journeys.','Ruime cabine en aangenaam rijgedrag. Ideaal voor gezinsgebruik of gemengde ritten.');
INSERT INTO "vehicles_vehicle" VALUES(2003,'Renault Megane 2010 #036',2500,'2026-08-06 14:52:30.676291','Compacte bien equipee et robuste. Elle offre un excellent rapport qualite-prix pour les conducteurs exigeants.','available',123,'accidente','','reparation','Well-equipped and robust compact car. Offers excellent value for money for demanding drivers.','Goed uitgeruste en robuuste compacte auto. Biedt een uitstekende prijs-kwaliteitverhouding voor veeleisende bestuurders.');
INSERT INTO "vehicles_vehicle" VALUES(2004,'Peugeot 307 2004 #037',1400,'2026-08-06 14:52:30.677360','Fiable et econome, cette compacte convient aussi bien aux deplacements professionnels qu''aux sorties en famille.','available',123,'accidente','','reparation','Reliable and fuel-efficient, this compact car suits both professional commuting and family outings.','Betrouwbaar en zuinig, deze compacte auto is geschikt voor zowel professionele verplaatsingen als familieuitjes.');
INSERT INTO "vehicles_vehicle" VALUES(2005,'Peugeot 308 2009 #038',2400,'2026-08-06 14:52:30.678408','Compacte polyvalente et confortable, aussi a l''aise en ville que sur route. Entretien regulier, bon etat general.','available',123,'accidente','','reparation','Versatile and comfortable compact car, at ease in the city and on the road. Regular servicing, good general condition.','Veelzijdige en comfortabele compacte auto, thuis in de stad en op de weg. Regelmatig onderhouden, goede algemene staat.');
INSERT INTO "vehicles_vehicle" VALUES(2006,'Volkswagen Golf 2005 #039',2100,'2026-08-06 14:52:30.679469','Un bon compromis entre espace interieur et consommation raisonnable. Vehicule fiable, historique d''entretien disponible.','available',123,'accidente','','reparation','A good compromise between interior space and reasonable fuel consumption. Reliable vehicle, maintenance history available.','Een goed compromis tussen binnenruimte en redelijk verbruik. Betrouwbaar voertuig, onderhoudshistorie beschikbaar.');
INSERT INTO "vehicles_vehicle" VALUES(2007,'Volkswagen Golf 2008 #040',2700,'2026-08-06 14:52:30.680527','Habitacle spacieux et conduite agreable. Ideale pour une utilisation familiale ou des trajets mixtes.','available',123,'accidente','','reparation','Spacious interior and pleasant drive. Ideal for family use or mixed journeys.','Ruime cabine en aangenaam rijgedrag. Ideaal voor gezinsgebruik of gemengde ritten.');
INSERT INTO "vehicles_vehicle" VALUES(2008,'Ford Focus 2005 #041',1500,'2026-08-06 14:52:30.681586','Compacte bien equipee et robuste. Elle offre un excellent rapport qualite-prix pour les conducteurs exigeants.','available',123,'accidente','','reparation','Well-equipped and robust compact car. Offers excellent value for money for demanding drivers.','Goed uitgeruste en robuuste compacte auto. Biedt een uitstekende prijs-kwaliteitverhouding voor veeleisende bestuurders.');
INSERT INTO "vehicles_vehicle" VALUES(2009,'Ford Focus 2008 #042',2100,'2026-08-06 14:52:30.682645','Fiable et econome, cette compacte convient aussi bien aux deplacements professionnels qu''aux sorties en famille.','available',123,'accidente','','reparation','Reliable and fuel-efficient, this compact car suits both professional commuting and family outings.','Betrouwbaar en zuinig, deze compacte auto is geschikt voor zowel professionele verplaatsingen als familieuitjes.');
INSERT INTO "vehicles_vehicle" VALUES(2010,'Opel Astra 2005 #043',1400,'2026-08-06 14:52:30.683711','Compacte polyvalente et confortable, aussi a l''aise en ville que sur route. Entretien regulier, bon etat general.','available',123,'accidente','','reparation','Versatile and comfortable compact car, at ease in the city and on the road. Regular servicing, good general condition.','Veelzijdige en comfortabele compacte auto, thuis in de stad en op de weg. Regelmatig onderhouden, goede algemene staat.');
INSERT INTO "vehicles_vehicle" VALUES(2011,'Opel Astra 2008 #044',2000,'2026-08-06 14:52:30.684826','Un bon compromis entre espace interieur et consommation raisonnable. Vehicule fiable, historique d''entretien disponible.','available',123,'accidente','','reparation','A good compromise between interior space and reasonable fuel consumption. Reliable vehicle, maintenance history available.','Een goed compromis tussen binnenruimte en redelijk verbruik. Betrouwbaar voertuig, onderhoudshistorie beschikbaar.');
INSERT INTO "vehicles_vehicle" VALUES(2012,'Toyota Auris 2007 #045',1800,'2026-08-06 14:52:30.685921','Habitacle spacieux et conduite agreable. Ideale pour une utilisation familiale ou des trajets mixtes.','available',123,'accidente','','reparation','Spacious interior and pleasant drive. Ideal for family use or mixed journeys.','Ruime cabine en aangenaam rijgedrag. Ideaal voor gezinsgebruik of gemengde ritten.');
INSERT INTO "vehicles_vehicle" VALUES(2013,'Hyundai i30 2008 #046',1700,'2026-08-06 14:52:30.686990','Compacte bien equipee et robuste. Elle offre un excellent rapport qualite-prix pour les conducteurs exigeants.','available',123,'accidente','','reparation','Well-equipped and robust compact car. Offers excellent value for money for demanding drivers.','Goed uitgeruste en robuuste compacte auto. Biedt een uitstekende prijs-kwaliteitverhouding voor veeleisende bestuurders.');
INSERT INTO "vehicles_vehicle" VALUES(2014,'Seat Leon 2006 #047',1600,'2026-08-06 14:52:30.688050','Fiable et econome, cette compacte convient aussi bien aux deplacements professionnels qu''aux sorties en famille.','available',123,'accidente','','reparation','Reliable and fuel-efficient, this compact car suits both professional commuting and family outings.','Betrouwbaar en zuinig, deze compacte auto is geschikt voor zowel professionele verplaatsingen als familieuitjes.');
INSERT INTO "vehicles_vehicle" VALUES(2015,'Dacia Duster 2011 #048',2800,'2026-08-06 14:52:30.689123','Crossover au bon rapport habitabilite-consommation. Entretien a jour, pret pour de nouvelles aventures.','available',127,'bon','','bon','Crossover with a good balance of interior space and fuel consumption. Up-to-date servicing, ready for new adventures.','Crossover met een goede verhouding tussen ruimte en verbruik. Onderhoud up-to-date, klaar voor nieuwe avonturen.');
INSERT INTO "vehicles_vehicle" VALUES(2016,'Dacia Duster 2013 #049',3000,'2026-08-06 14:52:30.690182','SUV compact offrant confort de conduite et position sureelevee. Polyvalent, robuste, adapte a tous les terrains.','available',127,'bon','','bon','Compact SUV offering driving comfort and an elevated seating position. Versatile, robust, suited to all terrains.','Compacte SUV met rijcomfort en verhoogde zitpositie. Veelzijdig, robuust, geschikt voor alle terreinen.');
INSERT INTO "vehicles_vehicle" VALUES(2017,'Nissan Juke 2011 #050',2600,'2026-08-06 14:52:30.691247','Vehicule pratique et spacieux, ideal pour les familles ou les personnes ayant besoin de volume au quotidien.','available',127,'bon','','bon','Practical and spacious vehicle, ideal for families or those who need plenty of room in daily life.','Praktisch en ruim voertuig, ideaal voor gezinnen of personen die dagelijks veel ruimte nodig hebben.');
INSERT INTO "vehicles_vehicle" VALUES(2018,'Kia Sportage 2008 #051',2100,'2026-08-06 14:52:30.692301','Crossover au bon rapport habitabilite-consommation. Entretien a jour, pret pour de nouvelles aventures.','available',127,'accidente','','reparation','Crossover with a good balance of interior space and fuel consumption. Up-to-date servicing, ready for new adventures.','Crossover met een goede verhouding tussen ruimte en verbruik. Onderhoud up-to-date, klaar voor nieuwe avonturen.');
INSERT INTO "vehicles_vehicle" VALUES(2019,'Hyundai Tucson 2007 #052',1900,'2026-08-06 14:52:30.693365','SUV compact offrant confort de conduite et position sureelevee. Polyvalent, robuste, adapte a tous les terrains.','available',127,'accidente','','reparation','Compact SUV offering driving comfort and an elevated seating position. Versatile, robust, suited to all terrains.','Compacte SUV met rijcomfort en verhoogde zitpositie. Veelzijdig, robuust, geschikt voor alle terreinen.');
INSERT INTO "vehicles_vehicle" VALUES(2020,'Renault Megane Estate 2005 #053',1600,'2026-08-06 14:52:30.694435','Break pratique et econome, ideal pour les longs trajets ou les deplacements professionnels necessitant de l''espace.','available',124,'accidente','','reparation','Practical and fuel-efficient estate, ideal for long journeys or professional trips requiring extra space.','Praktische en zuinige stationwagen, ideaal voor lange ritten of professionele verplaatsingen met veel ruimte.');
INSERT INTO "vehicles_vehicle" VALUES(2021,'Peugeot 307 SW 2005 #054',1700,'2026-08-06 14:52:30.695581','Grande capacite de chargement et confort de conduite. Une valeur sure pour les utilisateurs exigeants.','available',124,'accidente','','reparation','Large loading capacity and driving comfort. A reliable choice for demanding users.','Grote laadcapaciteit en rijcomfort. Een betrouwbare keuze voor veeleisende gebruikers.');
INSERT INTO "vehicles_vehicle" VALUES(2022,'Volkswagen Golf Variant 2007 #055',2200,'2026-08-06 14:52:30.696754','Break au coffre genereux et habitacle modulable. Parfait pour les familles ou le transport de materiel.','available',124,'accidente','','reparation','Estate car with generous boot and modular interior. Perfect for families or transporting equipment.','Stationwagen met ruime kofferruimte en modulaire cabine. Perfect voor gezinnen of materiaalvervoer.');
INSERT INTO "vehicles_vehicle" VALUES(2023,'Ford Focus Estate 2006 #056',1700,'2026-08-06 14:52:30.697858','Break pratique et econome, ideal pour les longs trajets ou les deplacements professionnels necessitant de l''espace.','available',124,'accidente','','reparation','Practical and fuel-efficient estate, ideal for long journeys or professional trips requiring extra space.','Praktische en zuinige stationwagen, ideaal voor lange ritten of professionele verplaatsingen met veel ruimte.');
INSERT INTO "vehicles_vehicle" VALUES(2024,'Opel Astra Sports Tourer 2008 #057',2000,'2026-08-06 14:52:30.698930','Grande capacite de chargement et confort de conduite. Une valeur sure pour les utilisateurs exigeants.','available',124,'accidente','','reparation','Large loading capacity and driving comfort. A reliable choice for demanding users.','Grote laadcapaciteit en rijcomfort. Een betrouwbare keuze voor veeleisende gebruikers.');
INSERT INTO "vehicles_vehicle" VALUES(2025,'Honda CB125F 2016 #058',1800,'2026-08-06 14:52:30.700021','125cc homologuee, parfaite pour eviter les embouteillages. Consommation reduite et prise en main facile.','available',121,'tres_bon','','tres_bon','Road-legal 125cc, perfect for avoiding traffic jams. Low fuel consumption and easy to handle.','Homologeerde 125cc, perfect om files te vermijden. Laag verbruik en gemakkelijk te besturen.');
INSERT INTO "vehicles_vehicle" VALUES(2026,'Honda CB125R 2018 #059',2500,'2026-08-06 14:52:30.701102','Deux-roues fiable et agreable a conduire. Ideal pour les deplacements quotidiens en ville ou en periurbain.','available',121,'tres_bon','','tres_bon','Reliable and pleasant two-wheeler to ride. Ideal for daily commuting in the city or suburbs.','Betrouwbaar en aangenaam tweewielig voertuig. Ideaal voor dagelijkse verplaatsingen in de stad of randgemeenten.');
INSERT INTO "vehicles_vehicle" VALUES(2027,'Honda CBR 125R 2015 #060',2300,'2026-08-06 14:52:30.702173','Moto bien entretenue, accessible avec le permis A1. Parfaite pour allier economie et liberte de deplacement.','available',121,'bon','','bon','Well-maintained motorcycle, accessible with an A1 licence. Perfect for combining economy and freedom of movement.','Goed onderhouden motor, toegankelijk met een A1-rijbewijs. Perfect om zuinigheid en rijvrijheid te combineren.');
INSERT INTO "vehicles_vehicle" VALUES(2028,'Yamaha YBR 125 2012 #061',1400,'2026-08-06 14:52:30.703246','Moto legere et maniable, ideale pour debuter ou pour les trajets urbains quotidiens. Entretien a jour.','available',121,'bon','','bon','Light and manoeuvrable motorcycle, ideal for beginners or daily urban commuting. Up-to-date servicing.','Lichte en wendbare motor, ideaal voor beginners of dagelijkse stedelijke ritten. Onderhoud up-to-date.');
INSERT INTO "vehicles_vehicle" VALUES(2029,'Yamaha YBR 125 2015 #062',1900,'2026-08-06 14:52:30.704303','125cc homologuee, parfaite pour eviter les embouteillages. Consommation reduite et prise en main facile.','available',121,'bon','','bon','Road-legal 125cc, perfect for avoiding traffic jams. Low fuel consumption and easy to handle.','Homologeerde 125cc, perfect om files te vermijden. Laag verbruik en gemakkelijk te besturen.');
INSERT INTO "vehicles_vehicle" VALUES(2030,'Yamaha MT-125 2017 #063',2700,'2026-08-06 14:52:30.705371','Deux-roues fiable et agreable a conduire. Ideal pour les deplacements quotidiens en ville ou en periurbain.','available',121,'tres_bon','','tres_bon','Reliable and pleasant two-wheeler to ride. Ideal for daily commuting in the city or suburbs.','Betrouwbaar en aangenaam tweewielig voertuig. Ideaal voor dagelijkse verplaatsingen in de stad of randgemeenten.');
INSERT INTO "vehicles_vehicle" VALUES(2031,'Kawasaki Z125 Pro 2017 #064',2100,'2026-08-06 14:52:30.706429','Moto bien entretenue, accessible avec le permis A1. Parfaite pour allier economie et liberte de deplacement.','available',121,'tres_bon','','tres_bon','Well-maintained motorcycle, accessible with an A1 licence. Perfect for combining economy and freedom of movement.','Goed onderhouden motor, toegankelijk met een A1-rijbewijs. Perfect om zuinigheid en rijvrijheid te combineren.');
INSERT INTO "vehicles_vehicle" VALUES(2032,'KTM Duke 125 2015 #065',2400,'2026-08-06 14:52:30.707499','Moto legere et maniable, ideale pour debuter ou pour les trajets urbains quotidiens. Entretien a jour.','available',121,'bon','','bon','Light and manoeuvrable motorcycle, ideal for beginners or daily urban commuting. Up-to-date servicing.','Lichte en wendbare motor, ideaal voor beginners of dagelijkse stedelijke ritten. Onderhoud up-to-date.');
INSERT INTO "vehicles_vehicle" VALUES(2033,'Benelli TNT 125 2018 #066',1600,'2026-08-06 14:52:30.709036','125cc homologuee, parfaite pour eviter les embouteillages. Consommation reduite et prise en main facile.','available',121,'tres_bon','','tres_bon','Road-legal 125cc, perfect for avoiding traffic jams. Low fuel consumption and easy to handle.','Homologeerde 125cc, perfect om files te vermijden. Laag verbruik en gemakkelijk te besturen.');
INSERT INTO "vehicles_vehicle" VALUES(2034,'Royal Enfield Bullet 350 2009 #067',1800,'2026-08-06 14:52:30.710478','Deux-roues fiable et agreable a conduire. Ideal pour les deplacements quotidiens en ville ou en periurbain.','available',121,'accidente','','reparation','Reliable and pleasant two-wheeler to ride. Ideal for daily commuting in the city or suburbs.','Betrouwbaar en aangenaam tweewielig voertuig. Ideaal voor dagelijkse verplaatsingen in de stad of randgemeenten.');
INSERT INTO "vehicles_vehicle" VALUES(2035,'Yamaha Aerox 50 2015 #068',650,'2026-08-06 14:52:30.712061','50cc ideal pour les jeunes conducteurs ou les trajets courts. Bon etat general, pret a rouler.','available',120,'bon','','bon','50cc ideal for young riders or short trips. Good general condition, ready to ride.','50cc ideaal voor jonge rijders of korte ritten. Goede algemene staat, rijklaar.');
INSERT INTO "vehicles_vehicle" VALUES(2036,'Yamaha Aerox 50 2019 #069',950,'2026-08-06 14:52:30.713444','Scooter urbain leger, parfait pour le dernier kilometre ou les courses en ville. Faible cout d''entretien.','available',120,'tres_bon','','tres_bon','Light urban scooter, perfect for the last mile or city errands. Low maintenance cost.','Lichte stadscooter, perfect voor de laatste kilometer of boodschappen in de stad. Lage onderhoudskosten.');
INSERT INTO "vehicles_vehicle" VALUES(2037,'Yamaha Xenter 125 2015 #070',1600,'2026-08-06 14:52:30.714757','Scooter pratique et economique pour les deplacements quotidiens en ville. Facile a prendre en main, entretien simple.','available',120,'bon','','bon','Practical and economical scooter for daily city commuting. Easy to handle, simple maintenance.','Praktische en zuinige scooter voor dagelijkse ritten in de stad. Gemakkelijk te besturen, eenvoudig onderhoud.');
INSERT INTO "vehicles_vehicle" VALUES(2038,'Honda SH 125 2013 #071',1800,'2026-08-06 14:52:30.716416','50cc ideal pour les jeunes conducteurs ou les trajets courts. Bon etat general, pret a rouler.','available',120,'bon','','bon','50cc ideal for young riders or short trips. Good general condition, ready to ride.','50cc ideaal voor jonge rijders of korte ritten. Goede algemene staat, rijklaar.');
INSERT INTO "vehicles_vehicle" VALUES(2039,'Honda PCX 125 2016 #072',2200,'2026-08-06 14:52:30.717719','Scooter urbain leger, parfait pour le dernier kilometre ou les courses en ville. Faible cout d''entretien.','available',120,'tres_bon','','tres_bon','Light urban scooter, perfect for the last mile or city errands. Low maintenance cost.','Lichte stadscooter, perfect voor de laatste kilometer of boodschappen in de stad. Lage onderhoudskosten.');
INSERT INTO "vehicles_vehicle" VALUES(2040,'Piaggio Fly 125 2015 #073',1100,'2026-08-06 14:52:30.718968','Scooter pratique et economique pour les deplacements quotidiens en ville. Facile a prendre en main, entretien simple.','available',120,'bon','','bon','Practical and economical scooter for daily city commuting. Easy to handle, simple maintenance.','Praktische en zuinige scooter voor dagelijkse ritten in de stad. Gemakkelijk te besturen, eenvoudig onderhoud.');
INSERT INTO "vehicles_vehicle" VALUES(2041,'Peugeot Vivacity 50 2014 #074',500,'2026-08-06 14:52:30.720217','50cc ideal pour les jeunes conducteurs ou les trajets courts. Bon etat general, pret a rouler.','available',120,'bon','','bon','50cc ideal for young riders or short trips. Good general condition, ready to ride.','50cc ideaal voor jonge rijders of korte ritten. Goede algemene staat, rijklaar.');
INSERT INTO "vehicles_vehicle" VALUES(2042,'Peugeot Kisbee 50 2017 #075',420,'2026-08-06 14:52:30.721463','Scooter urbain leger, parfait pour le dernier kilometre ou les courses en ville. Faible cout d''entretien.','available',120,'tres_bon','','tres_bon','Light urban scooter, perfect for the last mile or city errands. Low maintenance cost.','Lichte stadscooter, perfect voor de laatste kilometer of boodschappen in de stad. Lage onderhoudskosten.');
INSERT INTO "vehicles_vehicle" VALUES(2043,'Kymco Agility 50 2016 #076',580,'2026-08-06 14:52:30.722705','Scooter pratique et economique pour les deplacements quotidiens en ville. Facile a prendre en main, entretien simple.','available',120,'tres_bon','','tres_bon','Practical and economical scooter for daily city commuting. Easy to handle, simple maintenance.','Praktische en zuinige scooter voor dagelijkse ritten in de stad. Gemakkelijk te besturen, eenvoudig onderhoud.');
INSERT INTO "vehicles_vehicle" VALUES(2044,'Giant Escape 3 2018 #077',350,'2026-08-06 14:52:30.723945','Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.','sold',118,'tres_bon','','tres_bon','Smooth and economical mobility. Perfect for getting around the city without worrying about traffic or parking.','Zachte en zuinige mobiliteit. Perfect om in de stad rond te rijden zonder zorgen over verkeer of parkeren.');
INSERT INTO "vehicles_vehicle" VALUES(2045,'Giant Escape 3 2020 #078',480,'2026-08-06 14:52:30.725259','Velo polyvalent adapte aussi bien a la ville qu''aux chemins de campagne. Bon etat general, peu utilise.','available',118,'tres_bon','','tres_bon','Versatile bike suited to both the city and country paths. Good general condition, lightly used.','Veelzijdige fiets geschikt voor zowel de stad als landelijke paden. Goede algemene staat, weinig gebruikt.');
INSERT INTO "vehicles_vehicle" VALUES(2046,'Trek FX 3 2019 #079',420,'2026-08-06 14:52:30.726492','Velo urbain leger et robuste, ideal pour les trajets domicile-travail. Cadre en bon etat, freins revises.','available',118,'tres_bon','','tres_bon','Light and robust city bike, ideal for commuting. Frame in good condition, brakes serviced.','Lichte en robuuste stadsfiets, ideaal voor woon-werkverkeer. Frame in goede staat, remmen nagekeken.');
INSERT INTO "vehicles_vehicle" VALUES(2047,'Trek Marlin 5 2020 #080',490,'2026-08-06 14:52:30.727782','Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.','available',118,'tres_bon','','tres_bon','Smooth and economical mobility. Perfect for getting around the city without worrying about traffic or parking.','Zachte en zuinige mobiliteit. Perfect om in de stad rond te rijden zonder zorgen over verkeer of parkeren.');
INSERT INTO "vehicles_vehicle" VALUES(2048,'Cannondale Quick 4 2019 #081',380,'2026-08-06 14:52:30.729019','Velo polyvalent adapte aussi bien a la ville qu''aux chemins de campagne. Bon etat general, peu utilise.','available',118,'tres_bon','','tres_bon','Versatile bike suited to both the city and country paths. Good general condition, lightly used.','Veelzijdige fiets geschikt voor zowel de stad als landelijke paden. Goede algemene staat, weinig gebruikt.');
INSERT INTO "vehicles_vehicle" VALUES(2049,'Decathlon Rockrider 340 2018 #082',180,'2026-08-06 14:52:30.731096','Velo urbain leger et robuste, ideal pour les trajets domicile-travail. Cadre en bon etat, freins revises.','available',118,'tres_bon','','tres_bon','Light and robust city bike, ideal for commuting. Frame in good condition, brakes serviced.','Lichte en robuuste stadsfiets, ideaal voor woon-werkverkeer. Frame in goede staat, remmen nagekeken.');
INSERT INTO "vehicles_vehicle" VALUES(2050,'Decathlon Rockrider 520 2020 #083',280,'2026-08-06 14:52:30.732467','Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.','sold',118,'tres_bon','','tres_bon','Smooth and economical mobility. Perfect for getting around the city without worrying about traffic or parking.','Zachte en zuinige mobiliteit. Perfect om in de stad rond te rijden zonder zorgen over verkeer of parkeren.');
INSERT INTO "vehicles_vehicle" VALUES(2051,'Scott Aspect 50 2019 #084',310,'2026-08-06 14:52:30.733749','Velo polyvalent adapte aussi bien a la ville qu''aux chemins de campagne. Bon etat general, peu utilise.','available',118,'tres_bon','','tres_bon','Versatile bike suited to both the city and country paths. Good general condition, lightly used.','Veelzijdige fiets geschikt voor zowel de stad als landelijke paden. Goede algemene staat, weinig gebruikt.');
INSERT INTO "vehicles_vehicle" VALUES(2052,'Btwin Riverside 500 2020 #085',260,'2026-08-06 14:52:30.735014','Velo urbain leger et robuste, ideal pour les trajets domicile-travail. Cadre en bon etat, freins revises.','available',118,'tres_bon','','tres_bon','Light and robust city bike, ideal for commuting. Frame in good condition, brakes serviced.','Lichte en robuuste stadsfiets, ideaal voor woon-werkverkeer. Frame in goede staat, remmen nagekeken.');
INSERT INTO "vehicles_vehicle" VALUES(2053,'Cube Nature Pro 2019 #086',370,'2026-08-06 14:52:30.736285','Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.','available',118,'tres_bon','','tres_bon','Smooth and economical mobility. Perfect for getting around the city without worrying about traffic or parking.','Zachte en zuinige mobiliteit. Perfect om in de stad rond te rijden zonder zorgen over verkeer of parkeren.');
INSERT INTO "vehicles_vehicle" VALUES(2054,'Orbea Vector 30 2020 #087',440,'2026-08-06 14:52:30.738144','Velo polyvalent adapte aussi bien a la ville qu''aux chemins de campagne. Bon etat general, peu utilise.','available',118,'tres_bon','','tres_bon','Versatile bike suited to both the city and country paths. Good general condition, lightly used.','Veelzijdige fiets geschikt voor zowel de stad als landelijke paden. Goede algemene staat, weinig gebruikt.');
INSERT INTO "vehicles_vehicle" VALUES(2055,'Xiaomi Mi Electric Scooter 3 2021 #088',280,'2026-08-06 14:52:30.739497','Trottinette electrique legere et maniable, ideale pour le dernier kilometre ou les courts trajets urbains.','available',119,'tres_bon','','tres_bon','Light and manoeuvrable electric scooter, ideal for the last mile or short urban trips.','Lichte en wendbare elektrische step, ideaal voor de laatste kilometer of korte stedelijke ritten.');
INSERT INTO "vehicles_vehicle" VALUES(2056,'Xiaomi Mi Pro 2 2020 #089',370,'2026-08-06 14:52:30.740818','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','available',119,'tres_bon','','tres_bon','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(2057,'Xiaomi Mi Scooter Essential 2020 #090',200,'2026-08-06 14:52:30.742149','Solution de mobilite urbaine pratique et economique. Pliable, facile a transporter et simple a utiliser.','available',119,'tres_bon','','tres_bon','Practical and economical urban mobility solution. Foldable, easy to carry and simple to use.','Praktische en zuinige oplossing voor stedelijke mobiliteit. Opvouwbaar, gemakkelijk mee te nemen en eenvoudig te gebruiken.');
INSERT INTO "vehicles_vehicle" VALUES(2058,'Segway Ninebot Max G30 2021 #091',550,'2026-08-06 14:52:30.743597','Trottinette electrique legere et maniable, ideale pour le dernier kilometre ou les courts trajets urbains.','available',119,'tres_bon','','tres_bon','Light and manoeuvrable electric scooter, ideal for the last mile or short urban trips.','Lichte en wendbare elektrische step, ideaal voor de laatste kilometer of korte stedelijke ritten.');
INSERT INTO "vehicles_vehicle" VALUES(2059,'Segway Ninebot ES2 2019 #092',300,'2026-08-06 14:52:30.744900','Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.','available',119,'tres_bon','','tres_bon','Affordable and eco-friendly electric mobility. Sufficient range for daily trips, fast charging.','Betaalbare en milieuvriendelijke elektrische mobiliteit. Voldoende actieradius voor dagelijkse ritten, snel opladen.');
INSERT INTO "vehicles_vehicle" VALUES(2060,'Kaabo Mantis 10 2021 #093',850,'2026-08-06 14:52:30.746131','Solution de mobilite urbaine pratique et economique. Pliable, facile a transporter et simple a utiliser.','available',119,'tres_bon','','tres_bon','Practical and economical urban mobility solution. Foldable, easy to carry and simple to use.','Praktische en zuinige oplossing voor stedelijke mobiliteit. Opvouwbaar, gemakkelijk mee te nemen en eenvoudig te gebruiken.');
INSERT INTO "vehicles_vehicle" VALUES(2061,'Oxelo Town 7 2020 #094',240,'2026-08-06 14:52:30.747176','Trottinette electrique legere et maniable, ideale pour le dernier kilometre ou les courts trajets urbains.','available',119,'tres_bon','','tres_bon','Light and manoeuvrable electric scooter, ideal for the last mile or short urban trips.','Lichte en wendbare elektrische step, ideaal voor de laatste kilometer of korte stedelijke ritten.');
CREATE TABLE "vehicles_vehiclecategory" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(60) NOT NULL, "slug" varchar(120) NOT NULL UNIQUE, "description" text NULL, "created_at" datetime NOT NULL);
INSERT INTO "vehicles_vehiclecategory" VALUES(118,'Velo','velo','Velos d''occasion pour trajets quotidiens ou loisirs.','2026-05-23 12:31:23.349358');
INSERT INTO "vehicles_vehiclecategory" VALUES(119,'Trottinette','trottinette','Trottinettes classiques et electriques d''occasion.','2026-05-23 12:31:23.350122');
INSERT INTO "vehicles_vehiclecategory" VALUES(120,'Scooter','scooter','Scooters abordables pour la ville.','2026-05-23 12:31:23.350729');
INSERT INTO "vehicles_vehiclecategory" VALUES(121,'Moto legere','moto-legere','Petites motos et 50cc d''occasion.','2026-05-23 12:31:23.351283');
INSERT INTO "vehicles_vehiclecategory" VALUES(122,'Citadine','citadine','Petites voitures economiques pour la ville.','2026-05-23 12:31:23.351843');
INSERT INTO "vehicles_vehiclecategory" VALUES(123,'Compacte','compacte','Voitures pratiques pour tous les jours.','2026-05-23 12:31:23.352404');
INSERT INTO "vehicles_vehiclecategory" VALUES(124,'Break','break','Vehicules avec plus de coffre.','2026-05-23 12:31:23.352961');
INSERT INTO "vehicles_vehiclecategory" VALUES(125,'Utilitaire leger','utilitaire-leger','Petits utilitaires pour livraison ou travaux.','2026-05-23 12:31:23.353498');
INSERT INTO "vehicles_vehiclecategory" VALUES(126,'Monospace','monospace','Vehicules familiaux abordables.','2026-05-23 12:31:23.354040');
INSERT INTO "vehicles_vehiclecategory" VALUES(127,'SUV compact','suv-compact','Petits SUV d''occasion accessibles.','2026-05-23 12:31:23.354619');
CREATE TABLE "vehicles_vehicleimage" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "image" varchar(100) NOT NULL, "is_main" bool NOT NULL, "created_at" datetime NOT NULL, "vehicle_id" bigint NOT NULL REFERENCES "vehicles_vehicle" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "vehicles_vehicleimage" VALUES(6728,'vehicles/vehicle_1630_1.jpg',1,'2026-08-06 13:29:11.782194',1630);
INSERT INTO "vehicles_vehicleimage" VALUES(6729,'vehicles/vehicle_1630_2.jpg',0,'2026-08-06 13:29:12.482144',1630);
INSERT INTO "vehicles_vehicleimage" VALUES(6730,'vehicles/vehicle_1633_1.jpg',1,'2026-08-06 13:29:18.019725',1633);
INSERT INTO "vehicles_vehicleimage" VALUES(6731,'vehicles/vehicle_1633_2.jpg',0,'2026-08-06 13:29:19.054235',1633);
INSERT INTO "vehicles_vehicleimage" VALUES(6734,'vehicles/vehicle_1636_1.jpg',1,'2026-08-06 13:29:32.372315',1636);
INSERT INTO "vehicles_vehicleimage" VALUES(6735,'vehicles/vehicle_1636_2.jpg',0,'2026-08-06 13:29:33.499724',1636);
INSERT INTO "vehicles_vehicleimage" VALUES(6752,'vehicles/vehicle_1658_1.jpg',1,'2026-08-06 13:30:29.012685',1658);
INSERT INTO "vehicles_vehicleimage" VALUES(6753,'vehicles/vehicle_1658_2.jpg',0,'2026-08-06 13:30:29.668226',1658);
INSERT INTO "vehicles_vehicleimage" VALUES(6758,'vehicles/vehicle_1666_1.jpg',1,'2026-08-06 13:30:35.967341',1666);
INSERT INTO "vehicles_vehicleimage" VALUES(6759,'vehicles/vehicle_1666_2.jpg',0,'2026-08-06 13:30:36.835770',1666);
INSERT INTO "vehicles_vehicleimage" VALUES(6958,'vehicles/vehicle_1634_1.jpg',1,'2026-08-06 14:10:39.066542',1634);
INSERT INTO "vehicles_vehicleimage" VALUES(6959,'vehicles/vehicle_1634_2.jpg',0,'2026-08-06 14:10:39.826729',1634);
INSERT INTO "vehicles_vehicleimage" VALUES(6960,'vehicles/vehicle_1639_1.jpg',1,'2026-08-06 14:10:52.183453',1639);
INSERT INTO "vehicles_vehicleimage" VALUES(6961,'vehicles/vehicle_1639_2.jpg',0,'2026-08-06 14:10:52.943127',1639);
INSERT INTO "vehicles_vehicleimage" VALUES(6962,'vehicles/vehicle_1642_1.jpg',1,'2026-08-06 14:10:57.751179',1642);
INSERT INTO "vehicles_vehicleimage" VALUES(6963,'vehicles/vehicle_1642_2.jpg',0,'2026-08-06 14:10:58.898486',1642);
INSERT INTO "vehicles_vehicleimage" VALUES(6964,'vehicles/vehicle_1645_1.jpg',1,'2026-08-06 14:11:04.131697',1645);
INSERT INTO "vehicles_vehicleimage" VALUES(6965,'vehicles/vehicle_1645_2.jpg',0,'2026-08-06 14:11:05.255676',1645);
INSERT INTO "vehicles_vehicleimage" VALUES(6966,'vehicles/vehicle_1646_1.jpg',1,'2026-08-06 14:11:10.245132',1646);
INSERT INTO "vehicles_vehicleimage" VALUES(6967,'vehicles/vehicle_1646_2.jpg',0,'2026-08-06 14:11:11.005506',1646);
INSERT INTO "vehicles_vehicleimage" VALUES(6968,'vehicles/vehicle_1648_1.jpg',1,'2026-08-06 14:11:18.067080',1648);
INSERT INTO "vehicles_vehicleimage" VALUES(6969,'vehicles/vehicle_1648_2.jpg',0,'2026-08-06 14:11:18.966960',1648);
INSERT INTO "vehicles_vehicleimage" VALUES(6970,'vehicles/vehicle_1651_1.jpg',1,'2026-08-06 14:11:24.328910',1651);
INSERT INTO "vehicles_vehicleimage" VALUES(6971,'vehicles/vehicle_1651_2.jpg',0,'2026-08-06 14:11:25.258156',1651);
INSERT INTO "vehicles_vehicleimage" VALUES(6972,'vehicles/vehicle_1654_1.jpg',1,'2026-08-06 14:11:31.349928',1654);
INSERT INTO "vehicles_vehicleimage" VALUES(6973,'vehicles/vehicle_1654_2.jpg',0,'2026-08-06 14:11:32.114269',1654);
INSERT INTO "vehicles_vehicleimage" VALUES(6974,'vehicles/vehicle_1657_1.jpg',1,'2026-08-06 14:11:37.005712',1657);
INSERT INTO "vehicles_vehicleimage" VALUES(6975,'vehicles/vehicle_1657_2.jpg',0,'2026-08-06 14:11:37.786162',1657);
INSERT INTO "vehicles_vehicleimage" VALUES(6976,'vehicles/vehicle_1660_1.jpg',1,'2026-08-06 14:11:46.562217',1660);
INSERT INTO "vehicles_vehicleimage" VALUES(6977,'vehicles/vehicle_1660_2.jpg',0,'2026-08-06 14:11:47.800917',1660);
INSERT INTO "vehicles_vehicleimage" VALUES(6978,'vehicles/vehicle_1663_1.jpg',1,'2026-08-06 14:11:54.475983',1663);
INSERT INTO "vehicles_vehicleimage" VALUES(6979,'vehicles/vehicle_1663_2.jpg',0,'2026-08-06 14:11:55.259558',1663);
INSERT INTO "vehicles_vehicleimage" VALUES(6980,'vehicles/vehicle_1669_1.jpg',1,'2026-08-06 14:12:05.249200',1669);
INSERT INTO "vehicles_vehicleimage" VALUES(6981,'vehicles/vehicle_1669_2.jpg',0,'2026-08-06 14:12:08.761293',1669);
INSERT INTO "vehicles_vehicleimage" VALUES(6982,'vehicles/vehicle_1672_1.jpg',1,'2026-08-06 14:12:18.549902',1672);
INSERT INTO "vehicles_vehicleimage" VALUES(6983,'vehicles/vehicle_1672_2.jpg',0,'2026-08-06 14:12:19.336440',1672);
INSERT INTO "vehicles_vehicleimage" VALUES(6984,'vehicles/vehicle_1675_1.jpg',1,'2026-08-06 14:12:26.296925',1675);
INSERT INTO "vehicles_vehicleimage" VALUES(6985,'vehicles/vehicle_1675_2.jpg',0,'2026-08-06 14:12:27.435034',1675);
INSERT INTO "vehicles_vehicleimage" VALUES(6986,'vehicles/vehicle_1678_1.jpg',1,'2026-08-06 14:12:33.336094',1678);
INSERT INTO "vehicles_vehicleimage" VALUES(6987,'vehicles/vehicle_1678_2.jpg',0,'2026-08-06 14:12:34.362733',1678);
INSERT INTO "vehicles_vehicleimage" VALUES(6988,'vehicles/vehicle_1681_1.jpg',1,'2026-08-06 14:12:39.587347',1681);
INSERT INTO "vehicles_vehicleimage" VALUES(6989,'vehicles/vehicle_1681_2.jpg',0,'2026-08-06 14:12:40.630625',1681);
INSERT INTO "vehicles_vehicleimage" VALUES(6990,'vehicles/vehicle_1684_1.jpg',1,'2026-08-06 14:13:00.819741',1684);
INSERT INTO "vehicles_vehicleimage" VALUES(6991,'vehicles/vehicle_1684_2.jpg',0,'2026-08-06 14:13:01.875639',1684);
INSERT INTO "vehicles_vehicleimage" VALUES(6992,'vehicles/vehicle_1687_1.jpg',1,'2026-08-06 14:13:07.391645',1687);
INSERT INTO "vehicles_vehicleimage" VALUES(6993,'vehicles/vehicle_1687_2.jpg',0,'2026-08-06 14:13:08.482631',1687);
INSERT INTO "vehicles_vehicleimage" VALUES(6994,'vehicles/vehicle_1699_1.jpg',1,'2026-08-06 14:13:28.754542',1699);
INSERT INTO "vehicles_vehicleimage" VALUES(6995,'vehicles/vehicle_1699_2.jpg',0,'2026-08-06 14:13:29.523448',1699);
INSERT INTO "vehicles_vehicleimage" VALUES(6996,'vehicles/vehicle_1702_1.jpg',1,'2026-08-06 14:13:38.092632',1702);
INSERT INTO "vehicles_vehicleimage" VALUES(6997,'vehicles/vehicle_1702_2.jpg',0,'2026-08-06 14:13:40.427839',1702);
INSERT INTO "vehicles_vehicleimage" VALUES(6998,'vehicles/vehicle_1705_1.jpg',1,'2026-08-06 14:13:45.868032',1705);
INSERT INTO "vehicles_vehicleimage" VALUES(6999,'vehicles/vehicle_1705_2.jpg',0,'2026-08-06 14:13:46.898222',1705);
INSERT INTO "vehicles_vehicleimage" VALUES(7000,'vehicles/vehicle_1708_1.jpg',1,'2026-08-06 14:13:52.113917',1708);
INSERT INTO "vehicles_vehicleimage" VALUES(7001,'vehicles/vehicle_1708_2.jpg',0,'2026-08-06 14:13:53.062569',1708);
INSERT INTO "vehicles_vehicleimage" VALUES(7002,'vehicles/vehicle_1711_1.jpg',1,'2026-08-06 14:13:58.405230',1711);
INSERT INTO "vehicles_vehicleimage" VALUES(7003,'vehicles/vehicle_1711_2.jpg',0,'2026-08-06 14:13:59.519521',1711);
INSERT INTO "vehicles_vehicleimage" VALUES(7004,'vehicles/vehicle_1714_1.jpg',1,'2026-08-06 14:14:04.444345',1714);
INSERT INTO "vehicles_vehicleimage" VALUES(7005,'vehicles/vehicle_1714_2.jpg',0,'2026-08-06 14:14:05.246269',1714);
INSERT INTO "vehicles_vehicleimage" VALUES(7006,'vehicles/vehicle_1717_1.jpg',1,'2026-08-06 14:14:10.267109',1717);
INSERT INTO "vehicles_vehicleimage" VALUES(7007,'vehicles/vehicle_1717_2.jpg',0,'2026-08-06 14:14:11.044058',1717);
INSERT INTO "vehicles_vehicleimage" VALUES(7008,'vehicles/vehicle_1729_1.jpg',1,'2026-08-06 14:14:43.360185',1729);
INSERT INTO "vehicles_vehicleimage" VALUES(7009,'vehicles/vehicle_1729_2.jpg',0,'2026-08-06 14:14:44.186895',1729);
INSERT INTO "vehicles_vehicleimage" VALUES(7010,'vehicles/vehicle_1732_1.jpg',1,'2026-08-06 14:14:49.242245',1732);
INSERT INTO "vehicles_vehicleimage" VALUES(7011,'vehicles/vehicle_1732_2.jpg',0,'2026-08-06 14:14:50.256193',1732);
INSERT INTO "vehicles_vehicleimage" VALUES(7012,'vehicles/vehicle_1735_1.jpg',1,'2026-08-06 14:14:55.318177',1735);
INSERT INTO "vehicles_vehicleimage" VALUES(7013,'vehicles/vehicle_1735_2.jpg',0,'2026-08-06 14:15:04.562580',1735);
INSERT INTO "vehicles_vehicleimage" VALUES(7014,'vehicles/vehicle_1738_1.jpg',1,'2026-08-06 14:15:09.800560',1738);
INSERT INTO "vehicles_vehicleimage" VALUES(7015,'vehicles/vehicle_1738_2.jpg',0,'2026-08-06 14:15:10.787844',1738);
INSERT INTO "vehicles_vehicleimage" VALUES(7016,'vehicles/vehicle_1741_1.jpg',1,'2026-08-06 14:15:16.079683',1741);
INSERT INTO "vehicles_vehicleimage" VALUES(7017,'vehicles/vehicle_1741_2.jpg',0,'2026-08-06 14:15:17.245067',1741);
INSERT INTO "vehicles_vehicleimage" VALUES(7018,'vehicles/vehicle_1744_1.jpg',1,'2026-08-06 14:15:22.307814',1744);
INSERT INTO "vehicles_vehicleimage" VALUES(7019,'vehicles/vehicle_1744_2.jpg',0,'2026-08-06 14:15:23.079547',1744);
INSERT INTO "vehicles_vehicleimage" VALUES(7020,'vehicles/vehicle_1747_1.jpg',1,'2026-08-06 14:15:28.140589',1747);
INSERT INTO "vehicles_vehicleimage" VALUES(7021,'vehicles/vehicle_1747_2.jpg',0,'2026-08-06 14:15:28.919457',1747);
INSERT INTO "vehicles_vehicleimage" VALUES(7022,'vehicles/vehicle_1750_1.jpg',1,'2026-08-06 14:15:37.234816',1750);
INSERT INTO "vehicles_vehicleimage" VALUES(7023,'vehicles/vehicle_1750_2.jpg',0,'2026-08-06 14:15:41.730835',1750);
INSERT INTO "vehicles_vehicleimage" VALUES(7024,'vehicles/vehicle_1753_1.jpg',1,'2026-08-06 14:15:47.729732',1753);
INSERT INTO "vehicles_vehicleimage" VALUES(7025,'vehicles/vehicle_1753_2.jpg',0,'2026-08-06 14:15:48.581315',1753);
INSERT INTO "vehicles_vehicleimage" VALUES(7026,'vehicles/vehicle_1759_1.jpg',1,'2026-08-06 14:15:57.692515',1759);
INSERT INTO "vehicles_vehicleimage" VALUES(7027,'vehicles/vehicle_1759_2.jpg',0,'2026-08-06 14:15:58.553924',1759);
INSERT INTO "vehicles_vehicleimage" VALUES(7028,'vehicles/vehicle_1762_1.jpg',1,'2026-08-06 14:16:19.173679',1762);
INSERT INTO "vehicles_vehicleimage" VALUES(7029,'vehicles/vehicle_1762_2.jpg',0,'2026-08-06 14:16:19.939211',1762);
INSERT INTO "vehicles_vehicleimage" VALUES(7030,'vehicles/vehicle_1765_1.jpg',1,'2026-08-06 14:16:25.235678',1765);
INSERT INTO "vehicles_vehicleimage" VALUES(7031,'vehicles/vehicle_1765_2.jpg',0,'2026-08-06 14:16:26.135458',1765);
INSERT INTO "vehicles_vehicleimage" VALUES(7032,'vehicles/vehicle_1768_1.jpg',1,'2026-08-06 14:16:31.328029',1768);
INSERT INTO "vehicles_vehicleimage" VALUES(7033,'vehicles/vehicle_1768_2.jpg',0,'2026-08-06 14:16:32.403209',1768);
INSERT INTO "vehicles_vehicleimage" VALUES(7034,'vehicles/vehicle_1771_1.jpg',1,'2026-08-06 14:16:37.693432',1771);
INSERT INTO "vehicles_vehicleimage" VALUES(7035,'vehicles/vehicle_1771_2.jpg',0,'2026-08-06 14:16:38.468558',1771);
INSERT INTO "vehicles_vehicleimage" VALUES(7036,'vehicles/vehicle_1774_1.jpg',1,'2026-08-06 14:16:43.439981',1774);
INSERT INTO "vehicles_vehicleimage" VALUES(7037,'vehicles/vehicle_1774_2.jpg',0,'2026-08-06 14:16:44.212458',1774);
INSERT INTO "vehicles_vehicleimage" VALUES(7038,'vehicles/vehicle_1777_1.jpg',1,'2026-08-06 14:16:49.946322',1777);
INSERT INTO "vehicles_vehicleimage" VALUES(7039,'vehicles/vehicle_1777_2.jpg',0,'2026-08-06 14:16:50.885159',1777);
INSERT INTO "vehicles_vehicleimage" VALUES(7212,'vehicles/vehicle_1968_1.jpg',1,'2026-08-07 09:23:24.005309',1968);
INSERT INTO "vehicles_vehicleimage" VALUES(7213,'vehicles/vehicle_1968_2.jpg',0,'2026-08-07 09:23:24.016928',1968);
INSERT INTO "vehicles_vehicleimage" VALUES(7214,'vehicles/vehicle_1969_1.jpg',1,'2026-08-07 09:23:24.026681',1969);
INSERT INTO "vehicles_vehicleimage" VALUES(7215,'vehicles/vehicle_1969_2.jpg',0,'2026-08-07 09:23:24.034117',1969);
INSERT INTO "vehicles_vehicleimage" VALUES(7216,'vehicles/vehicle_1970_1.jpg',1,'2026-08-07 09:23:24.042953',1970);
INSERT INTO "vehicles_vehicleimage" VALUES(7217,'vehicles/vehicle_1970_2.jpg',0,'2026-08-07 09:23:24.050091',1970);
INSERT INTO "vehicles_vehicleimage" VALUES(7218,'vehicles/vehicle_1971_1.jpg',1,'2026-08-07 09:23:24.059063',1971);
INSERT INTO "vehicles_vehicleimage" VALUES(7219,'vehicles/vehicle_1971_2.jpg',0,'2026-08-07 09:23:24.065111',1971);
INSERT INTO "vehicles_vehicleimage" VALUES(7220,'vehicles/vehicle_1972_1.jpg',1,'2026-08-07 09:23:24.074257',1972);
INSERT INTO "vehicles_vehicleimage" VALUES(7221,'vehicles/vehicle_1972_2.jpg',0,'2026-08-07 09:23:24.080427',1972);
INSERT INTO "vehicles_vehicleimage" VALUES(7222,'vehicles/vehicle_1973_1.jpg',1,'2026-08-07 09:23:24.089069',1973);
INSERT INTO "vehicles_vehicleimage" VALUES(7223,'vehicles/vehicle_1974_1.jpg',1,'2026-08-07 09:23:24.098562',1974);
INSERT INTO "vehicles_vehicleimage" VALUES(7224,'vehicles/vehicle_1974_2.jpg',0,'2026-08-07 09:23:24.104106',1974);
INSERT INTO "vehicles_vehicleimage" VALUES(7225,'vehicles/vehicle_1975_1.jpg',1,'2026-08-07 09:23:24.115373',1975);
INSERT INTO "vehicles_vehicleimage" VALUES(7226,'vehicles/vehicle_1975_2.jpg',0,'2026-08-07 09:23:24.122426',1975);
INSERT INTO "vehicles_vehicleimage" VALUES(7227,'vehicles/vehicle_1976_1.jpg',1,'2026-08-07 09:23:24.135194',1976);
INSERT INTO "vehicles_vehicleimage" VALUES(7228,'vehicles/vehicle_1976_2.jpg',0,'2026-08-07 09:23:24.145206',1976);
INSERT INTO "vehicles_vehicleimage" VALUES(7229,'vehicles/vehicle_1977_1.jpg',1,'2026-08-07 09:23:24.155293',1977);
INSERT INTO "vehicles_vehicleimage" VALUES(7230,'vehicles/vehicle_1977_2.jpg',0,'2026-08-07 09:23:24.161161',1977);
INSERT INTO "vehicles_vehicleimage" VALUES(7231,'vehicles/vehicle_1978_1.jpg',1,'2026-08-07 09:23:24.170548',1978);
INSERT INTO "vehicles_vehicleimage" VALUES(7232,'vehicles/vehicle_1978_2.jpg',0,'2026-08-07 09:23:24.176127',1978);
INSERT INTO "vehicles_vehicleimage" VALUES(7233,'vehicles/vehicle_1979_1.jpg',1,'2026-08-07 09:23:24.185594',1979);
INSERT INTO "vehicles_vehicleimage" VALUES(7234,'vehicles/vehicle_1979_2.jpg',0,'2026-08-07 09:23:24.190972',1979);
INSERT INTO "vehicles_vehicleimage" VALUES(7235,'vehicles/vehicle_1980_1.jpg',1,'2026-08-07 09:23:24.201959',1980);
INSERT INTO "vehicles_vehicleimage" VALUES(7236,'vehicles/vehicle_1981_1.jpg',1,'2026-08-07 09:23:24.214125',1981);
INSERT INTO "vehicles_vehicleimage" VALUES(7237,'vehicles/vehicle_1981_2.jpg',0,'2026-08-07 09:23:24.221240',1981);
INSERT INTO "vehicles_vehicleimage" VALUES(7238,'vehicles/vehicle_1982_1.jpg',1,'2026-08-07 09:23:24.230396',1982);
INSERT INTO "vehicles_vehicleimage" VALUES(7239,'vehicles/vehicle_1982_2.jpg',0,'2026-08-07 09:23:24.236632',1982);
INSERT INTO "vehicles_vehicleimage" VALUES(7240,'vehicles/vehicle_1983_1.jpg',1,'2026-08-07 09:23:24.246412',1983);
INSERT INTO "vehicles_vehicleimage" VALUES(7241,'vehicles/vehicle_1983_2.jpg',0,'2026-08-07 09:23:24.252256',1983);
INSERT INTO "vehicles_vehicleimage" VALUES(7242,'vehicles/vehicle_1984_1.jpg',1,'2026-08-07 09:23:24.262232',1984);
INSERT INTO "vehicles_vehicleimage" VALUES(7243,'vehicles/vehicle_1984_2.jpg',0,'2026-08-07 09:23:24.268845',1984);
INSERT INTO "vehicles_vehicleimage" VALUES(7244,'vehicles/vehicle_1985_1.jpg',1,'2026-08-07 09:23:24.279456',1985);
INSERT INTO "vehicles_vehicleimage" VALUES(7245,'vehicles/vehicle_1985_2.jpg',0,'2026-08-07 09:23:24.286024',1985);
INSERT INTO "vehicles_vehicleimage" VALUES(7246,'vehicles/vehicle_1986_1.jpg',1,'2026-08-07 09:23:24.296973',1986);
INSERT INTO "vehicles_vehicleimage" VALUES(7247,'vehicles/vehicle_1986_2.jpg',0,'2026-08-07 09:23:24.306855',1986);
INSERT INTO "vehicles_vehicleimage" VALUES(7248,'vehicles/vehicle_1987_1.jpg',1,'2026-08-07 09:23:24.322842',1987);
INSERT INTO "vehicles_vehicleimage" VALUES(7249,'vehicles/vehicle_1987_2.jpg',0,'2026-08-07 09:23:24.330874',1987);
INSERT INTO "vehicles_vehicleimage" VALUES(7250,'vehicles/vehicle_1988_1.jpg',1,'2026-08-07 09:23:24.341032',1988);
INSERT INTO "vehicles_vehicleimage" VALUES(7251,'vehicles/vehicle_1988_2.jpg',0,'2026-08-07 09:23:24.348689',1988);
INSERT INTO "vehicles_vehicleimage" VALUES(7252,'vehicles/vehicle_1989_1.jpg',1,'2026-08-07 09:23:24.360235',1989);
INSERT INTO "vehicles_vehicleimage" VALUES(7253,'vehicles/vehicle_1989_2.jpg',0,'2026-08-07 09:23:24.368744',1989);
INSERT INTO "vehicles_vehicleimage" VALUES(7254,'vehicles/vehicle_1990_1.jpg',1,'2026-08-07 09:23:24.377425',1990);
INSERT INTO "vehicles_vehicleimage" VALUES(7255,'vehicles/vehicle_1990_2.jpg',0,'2026-08-07 09:23:24.383461',1990);
INSERT INTO "vehicles_vehicleimage" VALUES(7256,'vehicles/vehicle_1991_1.jpg',1,'2026-08-07 09:23:24.392508',1991);
INSERT INTO "vehicles_vehicleimage" VALUES(7257,'vehicles/vehicle_1991_2.jpg',0,'2026-08-07 09:23:24.399691',1991);
INSERT INTO "vehicles_vehicleimage" VALUES(7258,'vehicles/vehicle_1992_1.jpg',1,'2026-08-07 09:23:24.413011',1992);
INSERT INTO "vehicles_vehicleimage" VALUES(7259,'vehicles/vehicle_1992_2.jpg',0,'2026-08-07 09:23:24.421972',1992);
INSERT INTO "vehicles_vehicleimage" VALUES(7260,'vehicles/vehicle_1993_1.jpg',1,'2026-08-07 09:23:24.431709',1993);
INSERT INTO "vehicles_vehicleimage" VALUES(7261,'vehicles/vehicle_1993_2.jpg',0,'2026-08-07 09:23:24.437762',1993);
INSERT INTO "vehicles_vehicleimage" VALUES(7262,'vehicles/vehicle_1994_1.jpg',1,'2026-08-07 09:23:24.447613',1994);
INSERT INTO "vehicles_vehicleimage" VALUES(7263,'vehicles/vehicle_1994_2.jpg',0,'2026-08-07 09:23:24.453726',1994);
INSERT INTO "vehicles_vehicleimage" VALUES(7264,'vehicles/vehicle_1995_1.jpg',1,'2026-08-07 09:23:24.462871',1995);
INSERT INTO "vehicles_vehicleimage" VALUES(7265,'vehicles/vehicle_1995_2.jpg',0,'2026-08-07 09:23:24.469058',1995);
INSERT INTO "vehicles_vehicleimage" VALUES(7266,'vehicles/vehicle_1996_1.jpg',1,'2026-08-07 09:23:24.481050',1996);
INSERT INTO "vehicles_vehicleimage" VALUES(7267,'vehicles/vehicle_1996_2.jpg',0,'2026-08-07 09:23:24.488133',1996);
INSERT INTO "vehicles_vehicleimage" VALUES(7268,'vehicles/vehicle_1997_1.jpg',1,'2026-08-07 09:23:24.497985',1997);
INSERT INTO "vehicles_vehicleimage" VALUES(7269,'vehicles/vehicle_1997_2.jpg',0,'2026-08-07 09:23:24.503808',1997);
INSERT INTO "vehicles_vehicleimage" VALUES(7270,'vehicles/vehicle_1998_1.jpg',1,'2026-08-07 09:23:24.515465',1998);
INSERT INTO "vehicles_vehicleimage" VALUES(7271,'vehicles/vehicle_1998_2.jpg',0,'2026-08-07 09:23:24.522537',1998);
INSERT INTO "vehicles_vehicleimage" VALUES(7272,'vehicles/vehicle_1999_1.jpg',1,'2026-08-07 09:23:24.536772',1999);
INSERT INTO "vehicles_vehicleimage" VALUES(7273,'vehicles/vehicle_1999_2.jpg',0,'2026-08-07 09:23:24.543980',1999);
INSERT INTO "vehicles_vehicleimage" VALUES(7274,'vehicles/vehicle_2000_1.jpg',1,'2026-08-07 09:23:24.554072',2000);
INSERT INTO "vehicles_vehicleimage" VALUES(7275,'vehicles/vehicle_2000_2.jpg',0,'2026-08-07 09:23:24.559952',2000);
INSERT INTO "vehicles_vehicleimage" VALUES(7276,'vehicles/vehicle_2001_1.webp',1,'2026-08-07 09:23:24.569549',2001);
INSERT INTO "vehicles_vehicleimage" VALUES(7277,'vehicles/vehicle_2001_2.jpg',0,'2026-08-07 09:23:24.574996',2001);
INSERT INTO "vehicles_vehicleimage" VALUES(7278,'vehicles/vehicle_2002_1.jpg',1,'2026-08-07 09:23:24.587011',2002);
INSERT INTO "vehicles_vehicleimage" VALUES(7279,'vehicles/vehicle_2002_2.jpg',0,'2026-08-07 09:23:24.592804',2002);
INSERT INTO "vehicles_vehicleimage" VALUES(7280,'vehicles/vehicle_2003_1.jpg',1,'2026-08-07 09:23:24.602557',2003);
INSERT INTO "vehicles_vehicleimage" VALUES(7281,'vehicles/vehicle_2003_2.jpg',0,'2026-08-07 09:23:24.607925',2003);
INSERT INTO "vehicles_vehicleimage" VALUES(7282,'vehicles/vehicle_2004_1.jpg',1,'2026-08-07 09:23:24.618517',2004);
INSERT INTO "vehicles_vehicleimage" VALUES(7283,'vehicles/vehicle_2004_2.jpg',0,'2026-08-07 09:23:24.624317',2004);
INSERT INTO "vehicles_vehicleimage" VALUES(7284,'vehicles/vehicle_2005_1.jpg',1,'2026-08-07 09:23:24.636220',2005);
INSERT INTO "vehicles_vehicleimage" VALUES(7285,'vehicles/vehicle_2005_2.jpg',0,'2026-08-07 09:23:24.644949',2005);
INSERT INTO "vehicles_vehicleimage" VALUES(7286,'vehicles/vehicle_2006_1.jpg',1,'2026-08-07 09:23:24.654782',2006);
INSERT INTO "vehicles_vehicleimage" VALUES(7287,'vehicles/vehicle_2006_2.jpg',0,'2026-08-07 09:23:24.660151',2006);
INSERT INTO "vehicles_vehicleimage" VALUES(7288,'vehicles/vehicle_2007_1.jpg',1,'2026-08-07 09:23:24.669613',2007);
INSERT INTO "vehicles_vehicleimage" VALUES(7289,'vehicles/vehicle_2007_2.jpg',0,'2026-08-07 09:23:24.675232',2007);
INSERT INTO "vehicles_vehicleimage" VALUES(7290,'vehicles/vehicle_2008_1.jpg',1,'2026-08-07 09:23:24.685730',2008);
INSERT INTO "vehicles_vehicleimage" VALUES(7291,'vehicles/vehicle_2008_2.jpg',0,'2026-08-07 09:23:24.690921',2008);
INSERT INTO "vehicles_vehicleimage" VALUES(7292,'vehicles/vehicle_2009_1.jpg',1,'2026-08-07 09:23:24.700939',2009);
INSERT INTO "vehicles_vehicleimage" VALUES(7293,'vehicles/vehicle_2009_2.jpg',0,'2026-08-07 09:23:24.706417',2009);
INSERT INTO "vehicles_vehicleimage" VALUES(7294,'vehicles/vehicle_2010_1.jpg',1,'2026-08-07 09:23:24.716240',2010);
INSERT INTO "vehicles_vehicleimage" VALUES(7295,'vehicles/vehicle_2010_2.jpg',0,'2026-08-07 09:23:24.721532',2010);
INSERT INTO "vehicles_vehicleimage" VALUES(7296,'vehicles/vehicle_2012_1.jpg',1,'2026-08-07 09:23:24.733412',2012);
INSERT INTO "vehicles_vehicleimage" VALUES(7297,'vehicles/vehicle_2012_2.jpg',0,'2026-08-07 09:23:24.738718',2012);
INSERT INTO "vehicles_vehicleimage" VALUES(7298,'vehicles/vehicle_2013_1.jpg',1,'2026-08-07 09:23:24.748083',2013);
INSERT INTO "vehicles_vehicleimage" VALUES(7299,'vehicles/vehicle_2013_2.jpg',0,'2026-08-07 09:23:24.753280',2013);
INSERT INTO "vehicles_vehicleimage" VALUES(7300,'vehicles/vehicle_2014_1.jpg',1,'2026-08-07 09:23:24.763312',2014);
INSERT INTO "vehicles_vehicleimage" VALUES(7301,'vehicles/vehicle_2014_2.jpg',0,'2026-08-07 09:23:24.768678',2014);
INSERT INTO "vehicles_vehicleimage" VALUES(7302,'vehicles/vehicle_2015_1.jpg',1,'2026-08-07 09:23:24.777071',2015);
INSERT INTO "vehicles_vehicleimage" VALUES(7303,'vehicles/vehicle_2015_2.jpg',0,'2026-08-07 09:23:24.784153',2015);
INSERT INTO "vehicles_vehicleimage" VALUES(7304,'vehicles/vehicle_2016_1.jpg',1,'2026-08-07 09:23:24.793736',2016);
INSERT INTO "vehicles_vehicleimage" VALUES(7305,'vehicles/vehicle_2016_2.jpg',0,'2026-08-07 09:23:24.799906',2016);
INSERT INTO "vehicles_vehicleimage" VALUES(7306,'vehicles/vehicle_2017_1.jpg',1,'2026-08-07 09:23:24.808468',2017);
INSERT INTO "vehicles_vehicleimage" VALUES(7307,'vehicles/vehicle_2017_2.jpg',0,'2026-08-07 09:23:24.813756',2017);
INSERT INTO "vehicles_vehicleimage" VALUES(7308,'vehicles/vehicle_2018_1.jpg',1,'2026-08-07 09:23:24.822950',2018);
INSERT INTO "vehicles_vehicleimage" VALUES(7309,'vehicles/vehicle_2018_2.jpg',0,'2026-08-07 09:23:24.828622',2018);
INSERT INTO "vehicles_vehicleimage" VALUES(7310,'vehicles/vehicle_2019_1.jpg',1,'2026-08-07 09:23:24.837864',2019);
INSERT INTO "vehicles_vehicleimage" VALUES(7311,'vehicles/vehicle_2019_2.jpg',0,'2026-08-07 09:23:24.842790',2019);
INSERT INTO "vehicles_vehicleimage" VALUES(7312,'vehicles/vehicle_2020_1.jpg',1,'2026-08-07 09:23:24.851525',2020);
INSERT INTO "vehicles_vehicleimage" VALUES(7313,'vehicles/vehicle_2020_2.jpg',0,'2026-08-07 09:23:24.856794',2020);
INSERT INTO "vehicles_vehicleimage" VALUES(7314,'vehicles/vehicle_2021_1.jpg',1,'2026-08-07 09:23:24.870677',2021);
INSERT INTO "vehicles_vehicleimage" VALUES(7315,'vehicles/vehicle_2021_2.jpg',0,'2026-08-07 09:23:24.876098',2021);
INSERT INTO "vehicles_vehicleimage" VALUES(7316,'vehicles/vehicle_2022_1.jpg',1,'2026-08-07 09:23:24.886574',2022);
INSERT INTO "vehicles_vehicleimage" VALUES(7317,'vehicles/vehicle_2022_2.jpg',0,'2026-08-07 09:23:24.892833',2022);
INSERT INTO "vehicles_vehicleimage" VALUES(7318,'vehicles/vehicle_2023_1.jpg',1,'2026-08-07 09:23:24.902859',2023);
INSERT INTO "vehicles_vehicleimage" VALUES(7319,'vehicles/vehicle_2023_2.jpg',0,'2026-08-07 09:23:24.907727',2023);
INSERT INTO "vehicles_vehicleimage" VALUES(7320,'vehicles/vehicle_2024_1.jpg',1,'2026-08-07 09:23:24.917546',2024);
INSERT INTO "vehicles_vehicleimage" VALUES(7321,'vehicles/vehicle_2024_2.jpg',0,'2026-08-07 09:23:24.922802',2024);
INSERT INTO "vehicles_vehicleimage" VALUES(7322,'vehicles/vehicle_2025_1.png',1,'2026-08-07 09:23:24.931850',2025);
INSERT INTO "vehicles_vehicleimage" VALUES(7323,'vehicles/vehicle_2026_1.jpg',1,'2026-08-07 09:23:24.941938',2026);
INSERT INTO "vehicles_vehicleimage" VALUES(7324,'vehicles/vehicle_2027_1.jpg',1,'2026-08-07 09:23:24.951128',2027);
INSERT INTO "vehicles_vehicleimage" VALUES(7325,'vehicles/vehicle_2028_1.jpg',1,'2026-08-07 09:23:24.959704',2028);
INSERT INTO "vehicles_vehicleimage" VALUES(7326,'vehicles/vehicle_2029_1.jpg',1,'2026-08-07 09:23:24.968901',2029);
INSERT INTO "vehicles_vehicleimage" VALUES(7327,'vehicles/vehicle_2030_1.jpg',1,'2026-08-07 09:23:24.978536',2030);
INSERT INTO "vehicles_vehicleimage" VALUES(7328,'vehicles/vehicle_2031_1.jpg',1,'2026-08-07 09:23:24.987083',2031);
INSERT INTO "vehicles_vehicleimage" VALUES(7329,'vehicles/vehicle_2032_1.jpg',1,'2026-08-07 09:23:24.997146',2032);
INSERT INTO "vehicles_vehicleimage" VALUES(7330,'vehicles/vehicle_2033_1.jpg',1,'2026-08-07 09:23:25.005947',2033);
INSERT INTO "vehicles_vehicleimage" VALUES(7331,'vehicles/vehicle_2034_1.jpg',1,'2026-08-07 09:23:25.040425',2034);
INSERT INTO "vehicles_vehicleimage" VALUES(7332,'vehicles/vehicle_2035_1.jpg',1,'2026-08-07 09:23:25.050933',2035);
INSERT INTO "vehicles_vehicleimage" VALUES(7333,'vehicles/vehicle_2036_1.jpg',1,'2026-08-07 09:23:25.059153',2036);
INSERT INTO "vehicles_vehicleimage" VALUES(7334,'vehicles/vehicle_2037_1.jpg',1,'2026-08-07 09:23:25.068612',2037);
INSERT INTO "vehicles_vehicleimage" VALUES(7335,'vehicles/vehicle_2038_1.jpg',1,'2026-08-07 09:23:25.077779',2038);
INSERT INTO "vehicles_vehicleimage" VALUES(7336,'vehicles/vehicle_2039_1.jpg',1,'2026-08-07 09:23:25.087310',2039);
INSERT INTO "vehicles_vehicleimage" VALUES(7337,'vehicles/vehicle_2040_1.jpg',1,'2026-08-07 09:23:25.098240',2040);
INSERT INTO "vehicles_vehicleimage" VALUES(7338,'vehicles/vehicle_2041_1.jpg',1,'2026-08-07 09:23:25.107439',2041);
INSERT INTO "vehicles_vehicleimage" VALUES(7339,'vehicles/vehicle_2042_1.jpg',1,'2026-08-07 09:23:25.117318',2042);
INSERT INTO "vehicles_vehicleimage" VALUES(7340,'vehicles/vehicle_2043_1.jpg',1,'2026-08-07 09:23:25.127409',2043);
INSERT INTO "vehicles_vehicleimage" VALUES(7341,'vehicles/vehicle_2044_1.jpg',1,'2026-08-07 09:23:25.136656',2044);
INSERT INTO "vehicles_vehicleimage" VALUES(7342,'vehicles/vehicle_2045_1.jpeg',1,'2026-08-07 09:23:25.145404',2045);
INSERT INTO "vehicles_vehicleimage" VALUES(7343,'vehicles/vehicle_2046_1.jpg',1,'2026-08-07 09:23:25.153887',2046);
INSERT INTO "vehicles_vehicleimage" VALUES(7344,'vehicles/vehicle_2047_1.jpg',1,'2026-08-07 09:23:25.163270',2047);
INSERT INTO "vehicles_vehicleimage" VALUES(7345,'vehicles/vehicle_2048_1.jpg',1,'2026-08-07 09:23:25.173821',2048);
INSERT INTO "vehicles_vehicleimage" VALUES(7346,'vehicles/vehicle_2049_1.jpg',1,'2026-08-07 09:23:25.183990',2049);
INSERT INTO "vehicles_vehicleimage" VALUES(7347,'vehicles/vehicle_2050_1.jpg',1,'2026-08-07 09:23:25.192572',2050);
INSERT INTO "vehicles_vehicleimage" VALUES(7348,'vehicles/vehicle_2051_1.jpg',1,'2026-08-07 09:23:25.201511',2051);
INSERT INTO "vehicles_vehicleimage" VALUES(7349,'vehicles/vehicle_2052_1.jpg',1,'2026-08-07 09:23:25.209992',2052);
INSERT INTO "vehicles_vehicleimage" VALUES(7350,'vehicles/vehicle_2053_1.jpg',1,'2026-08-07 09:23:25.219193',2053);
INSERT INTO "vehicles_vehicleimage" VALUES(7351,'vehicles/vehicle_2054_1.jpg',1,'2026-08-07 09:23:25.227303',2054);
INSERT INTO "vehicles_vehicleimage" VALUES(7352,'vehicles/vehicle_2055_1.jpg',1,'2026-08-07 09:23:25.236424',2055);
INSERT INTO "vehicles_vehicleimage" VALUES(7353,'vehicles/vehicle_2056_1.jpg',1,'2026-08-07 09:23:25.245925',2056);
INSERT INTO "vehicles_vehicleimage" VALUES(7354,'vehicles/vehicle_2057_1.jpg',1,'2026-08-07 09:23:25.254617',2057);
INSERT INTO "vehicles_vehicleimage" VALUES(7355,'vehicles/vehicle_2058_1.jpg',1,'2026-08-07 09:23:25.263510',2058);
INSERT INTO "vehicles_vehicleimage" VALUES(7356,'vehicles/vehicle_2059_1.jpg',1,'2026-08-07 09:23:25.271840',2059);
INSERT INTO "vehicles_vehicleimage" VALUES(7357,'vehicles/vehicle_2060_1.jpg',1,'2026-08-07 09:23:25.280560',2060);
INSERT INTO "vehicles_vehicleimage" VALUES(7358,'vehicles/vehicle_2061_1.jpg',1,'2026-08-07 09:23:25.288533',2061);
INSERT INTO "vehicles_vehicleimage" VALUES(7359,'vehicles/vehicle_1973_2.jpg',0,'2026-08-07 10:01:56.443425',1973);
INSERT INTO "vehicles_vehicleimage" VALUES(7360,'vehicles/IMG_20220528_192919.jpg',0,'2026-08-20 14:13:52.652602',1688);
INSERT INTO "vehicles_vehicleimage" VALUES(7361,'vehicles/121.avif',0,'2026-08-20 14:15:56.107037',1748);
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" ("group_id", "permission_id");
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" ("permission_id");
CREATE UNIQUE INDEX "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" ("user_id", "group_id");
CREATE INDEX "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_group_id_97559544" ON "auth_user_groups" ("group_id");
CREATE UNIQUE INDEX "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" ("user_id", "permission_id");
CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" ("content_type_id");
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log" ("user_id");
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" ("app_label", "model");
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" ("content_type_id", "codename");
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission" ("content_type_id");
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session" ("expire_date");
CREATE INDEX "vehicles_vehicleimage_vehicle_id_7eda5167" ON "vehicles_vehicleimage" ("vehicle_id");
CREATE INDEX "payments_in_invoice_3fa711_idx" ON "payments_invoice" ("invoice_number");
CREATE INDEX "payments_in_issued__210b19_idx" ON "payments_invoice" ("issued_at");
CREATE INDEX "accounts_accountdeletionrequest_user_id_6a166c52" ON "accounts_accountdeletionrequest" ("user_id");
CREATE INDEX "contact_contactmessage_user_id_0ac8080c" ON "contact_contactmessage" ("user_id");
CREATE INDEX "contact_con_email_233940_idx" ON "contact_contactmessage" ("email");
CREATE INDEX "contact_con_is_read_9a011e_idx" ON "contact_contactmessage" ("is_read");
CREATE INDEX "contact_con_created_fddb83_idx" ON "contact_contactmessage" ("created_at");
CREATE INDEX "vehicles_favorite_user_id_1cea60ed" ON "vehicles_favorite" ("user_id");
CREATE INDEX "vehicles_favorite_vehicle_id_22b341fd" ON "vehicles_favorite" ("vehicle_id");
CREATE INDEX "vehicles_vehicle_category_id_27ac5ae1" ON "vehicles_vehicle" ("category_id");
CREATE INDEX "vehicles_ve_status_f71f77_idx" ON "vehicles_vehicle" ("status");
CREATE INDEX "vehicles_ve_price_da359f_idx" ON "vehicles_vehicle" ("price");
CREATE INDEX "vehicles_ve_created_3aff09_idx" ON "vehicles_vehicle" ("created_at");
CREATE INDEX "reservations_reservation_user_id_6ed5b1c9" ON "reservations_reservation" ("user_id");
CREATE INDEX "reservations_reservation_vehicle_id_3a7745ab" ON "reservations_reservation" ("vehicle_id");
CREATE INDEX "reservation_status_f1a03a_idx" ON "reservations_reservation" ("status");
CREATE INDEX "reservation_created_fddb5a_idx" ON "reservations_reservation" ("created_at");
CREATE INDEX "accounts_adminnote_author_id_c338e66e" ON "accounts_adminnote" ("author_id");
CREATE INDEX "payments_testimonial_user_id_3d915131" ON "payments_testimonial" ("user_id");
CREATE INDEX "payments_pa_status_7ad4af_idx" ON "payments_payment" ("status");
CREATE INDEX "payments_pa_created_b8a300_idx" ON "payments_payment" ("created_at");
DELETE FROM "sqlite_sequence";
INSERT INTO "sqlite_sequence" VALUES('django_migrations',56);
INSERT INTO "sqlite_sequence" VALUES('django_admin_log',50);
INSERT INTO "sqlite_sequence" VALUES('django_content_type',19);
INSERT INTO "sqlite_sequence" VALUES('auth_permission',76);
INSERT INTO "sqlite_sequence" VALUES('auth_group',0);
INSERT INTO "sqlite_sequence" VALUES('auth_user',1461);
INSERT INTO "sqlite_sequence" VALUES('vehicles_vehiclecategory',127);
INSERT INTO "sqlite_sequence" VALUES('payments_invoice',1192);
INSERT INTO "sqlite_sequence" VALUES('vehicles_vehicleimage',7361);
INSERT INTO "sqlite_sequence" VALUES('accounts_accountdeletionrequest',1);
INSERT INTO "sqlite_sequence" VALUES('contact_contactmessage',1390);
INSERT INTO "sqlite_sequence" VALUES('vehicles_favorite',10);
INSERT INTO "sqlite_sequence" VALUES('vehicles_vehicle',2061);
INSERT INTO "sqlite_sequence" VALUES('auth_user_user_permissions',48);
INSERT INTO "sqlite_sequence" VALUES('reservations_reservation',1859);
INSERT INTO "sqlite_sequence" VALUES('payments_testimonial',28);
INSERT INTO "sqlite_sequence" VALUES('accounts_accountstatus',213);
INSERT INTO "sqlite_sequence" VALUES('payments_payment',1332);
COMMIT;
