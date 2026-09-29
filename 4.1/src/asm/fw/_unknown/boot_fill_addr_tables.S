/* boot_fill_addr_tables @ 0x8ee16c, 1376 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SYSTEM
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13
 */
	.section .text.boot_fill_addr_tables,"ax",@progbits
	.global boot_fill_addr_tables
boot_fill_addr_tables:
	.global L_8ee16c
L_8ee16c:
	push_s blink
L_8ee16e:
	bl.d L_8c0298
L_8ee172:
	mov_s r1,0x1
L_8ee174:
	mov_s r2,0x887800
L_8ee17a:
	st_s r1,[r2,0x44]
L_8ee17c:
	mov_s r0,0x887600
L_8ee182:
	st 0x80000,[r0, 0x44]
L_8ee18a:
	mov_s r3,0x4
L_8ee18c:
	st.a r3,[sp,-0x24]
L_8ee190:
	st_s r3,[r2,0x48]
L_8ee192:
	st 0x300000,[r0, 0x48]
L_8ee19a:
	mov_s r3,0x7
L_8ee19c:
	st_s r3,[sp,0x4]
L_8ee19e:
	st_s r3,[r2,0x4c]
L_8ee1a0:
	st 0x640000,[r0, 0x4c]
L_8ee1a8:
	mov_s r3,0x2
L_8ee1aa:
	st_s r3,[r2,0x50]
L_8ee1ac:
	st 0x880000,[r0, 0x50]
L_8ee1b4:
	mov_s r3,0x5
L_8ee1b6:
	st_s r3,[sp,0x8]
L_8ee1b8:
	st_s r3,[r2,0x54]
L_8ee1ba:
	st 0xb00000,[r0, 0x54]
L_8ee1c2:
	mov_s r3,0x8
L_8ee1c4:
	st_s r3,[r2,0x58]
L_8ee1c6:
	st 0xe40000,[r0, 0x58]
L_8ee1ce:
	mov_s r3,0x3
L_8ee1d0:
	st_s r3,[r2,0x5c]
L_8ee1d2:
	st 0x1080000,[r0, 0x5c]
L_8ee1da:
	mov_s r3,0x6
L_8ee1dc:
	st_s r3,[r2,0x60]
L_8ee1de:
	st 0x1300000,[r0, 0x60]
L_8ee1e6:
	mov_s r13,0x9
L_8ee1e8:
	st_s r13,[r2,0x64]
L_8ee1ea:
	st 0x1640000,[r0, 0x64]
L_8ee1f2:
	mov r21,0xa
L_8ee1f6:
	st r21,[r2, 0x68]
L_8ee1fa:
	st 0x1840000,[r0, 0x68]
L_8ee202:
	mov r20,0xb
L_8ee206:
	st r20,[r2, 0x6c]
L_8ee20a:
	st 0x1a40000,[r0, 0x6c]
L_8ee212:
	mov r19,0xc
L_8ee216:
	st r19,[r2, 0x70]
L_8ee21a:
	st 0x1c40000,[r0, 0x70]
L_8ee222:
	mov r18,0xd
L_8ee226:
	st r18,[r2, 0x74]
L_8ee22a:
	st 0x1e40000,[r0, 0x74]
L_8ee232:
	mov r17,0xe
L_8ee236:
	st r17,[r2, 0x78]
L_8ee23a:
	st 0x2040000,[r0, 0x78]
L_8ee242:
	mov r16,0xf
L_8ee246:
	st r16,[r2, 0x7c]
L_8ee24a:
	st 0x2240000,[r0, 0x7c]
L_8ee252:
	mov r24,0x10
L_8ee256:
	mov_s r2,0x887880
L_8ee25c:
	st r24,[r2]
L_8ee260:
	mov_s r3,0x887680
L_8ee266:
	st 0x2480000,[r3]
L_8ee26e:
	mov r25,0x11
L_8ee272:
	st r25,[r2, 0x4]
L_8ee276:
	st 0x2680000,[r3, 0x4]
L_8ee27e:
	mov_s r14,0x12
L_8ee280:
	st_s r14,[r2,0x8]
L_8ee282:
	st 0x2880000,[r3, 0x8]
L_8ee28a:
	st 0x20013,[r2, 0xc]
L_8ee292:
	st 0x2a40200,[r3, 0xc]
L_8ee29a:
	mov r22,0x14
L_8ee29e:
	st r22,[r2, 0x10]
L_8ee2a2:
	st 0x2c40000,[r3, 0x10]
L_8ee2aa:
	mov r23,0x15
L_8ee2ae:
	st r23,[r2, 0x14]
L_8ee2b2:
	st 0x2e40000,[r3, 0x14]
L_8ee2ba:
	mov_s r15,0x16
L_8ee2bc:
	st_s r15,[r2,0x18]
L_8ee2be:
	st 0x3040000,[r3, 0x18]
L_8ee2c6:
	mov r11,0x17
L_8ee2ca:
	st r11,[r2, 0x1c]
L_8ee2ce:
	st 0x3240000,[r3, 0x1c]
L_8ee2d6:
	mov r10,0x18
L_8ee2da:
	st r10,[r2, 0x20]
L_8ee2de:
	st 0x3440000,[r3, 0x20]
L_8ee2e6:
	mov r6,0x19
L_8ee2ea:
	st r6,[r2, 0x24]
L_8ee2ee:
	st 0x3640000,[r3, 0x24]
L_8ee2f6:
	mov r5,0x1a
L_8ee2fa:
	st r5,[r2, 0x28]
L_8ee2fe:
	st 0x3840000,[r3, 0x28]
L_8ee306:
	mov r4,0x1b
L_8ee30a:
	st r4,[r2, 0x2c]
L_8ee30e:
	st 0x3a40000,[r3, 0x2c]
L_8ee316:
	mov r7,0x1c
L_8ee31a:
	st r7,[r2, 0x30]
L_8ee31e:
	st 0x3c40000,[r3, 0x30]
L_8ee326:
	mov r8,0x1d
L_8ee32a:
	st r8,[r2, 0x34]
L_8ee32e:
	st 0x3e40000,[r3, 0x34]
L_8ee336:
	mov r9,0x1e
L_8ee33a:
	st r9,[sp, 0x20]
L_8ee33e:
	st r9,[r2, 0x38]
L_8ee342:
	st 0x4040000,[r3, 0x38]
L_8ee34a:
	mov r9,0x1f
L_8ee34e:
	st r9,[sp, 0xc]
L_8ee352:
	st r9,[r2, 0x3c]
L_8ee356:
	st 0x4240000,[r3, 0x3c]
L_8ee35e:
	st 0x11820,[r2, 0x40]
L_8ee366:
	st 0x4480002,[r3, 0x40]
L_8ee36e:
	mov r9,0x21
L_8ee372:
	st r9,[sp, 0x10]
L_8ee376:
	st r9,[r2, 0x44]
L_8ee37a:
	st 0x4640000,[r3, 0x44]
L_8ee382:
	mov r9,0x22
L_8ee386:
	st r9,[sp, 0x14]
L_8ee38a:
	st r9,[r2, 0x48]
L_8ee38e:
	st 0x4840000,[r3, 0x48]
L_8ee396:
	mov r9,0x23
L_8ee39a:
	st r9,[sp, 0x18]
L_8ee39e:
	st r9,[r2, 0x4c]
L_8ee3a2:
	st 0x4a40000,[r3, 0x4c]
L_8ee3aa:
	mov r9,0x24
L_8ee3ae:
	st r9,[sp, 0x1c]
L_8ee3b2:
	st r9,[r2, 0x50]
L_8ee3b6:
	st 0x4c40000,[r3, 0x50]
L_8ee3be:
	mov_s r0,0x25
L_8ee3c0:
	st_s r0,[r2,0x54]
L_8ee3c2:
	st 0x4e40000,[r3, 0x54]
L_8ee3ca:
	mov_s r0,0x26
L_8ee3cc:
	st_s r0,[r2,0x58]
L_8ee3ce:
	st 0x5040000,[r3, 0x58]
L_8ee3d6:
	mov_s r0,0x27
L_8ee3d8:
	st_s r0,[r2,0x5c]
L_8ee3da:
	st 0x5240000,[r3, 0x5c]
L_8ee3e2:
	st 0x20028,[r2, 0x60]
L_8ee3ea:
	st 0x5441200,[r3, 0x60]
L_8ee3f2:
	st 0x20029,[r2, 0x64]
L_8ee3fa:
	st 0x5642200,[r3, 0x64]
L_8ee402:
	st 0x2002a,[r2, 0x68]
L_8ee40a:
	st 0x5843200,[r3, 0x68]
L_8ee412:
	st 0x2002b,[r2, 0x6c]
L_8ee41a:
	st 0x5a44200,[r3, 0x6c]
L_8ee422:
	mov_s r0,0x887380
L_8ee428:
	st_s r1,[r0,0x44]
L_8ee42a:
	mov_s r1,0x887100
L_8ee430:
	st 0x40000,[r1, 0x44]
L_8ee438:
	ld r9,[sp]
L_8ee43c:
	mov_s r2,0x13
L_8ee43e:
	st r9,[r0, 0x48]
L_8ee442:
	st 0x240000,[r1, 0x48]
L_8ee44a:
	ld r9,[sp, 0x8]
L_8ee44e:
	st r9,[r0, 0x4c]
L_8ee452:
	st 0x440000,[r1, 0x4c]
L_8ee45a:
	ld r9,[sp, 0x4]
L_8ee45e:
	st r9,[r0, 0x50]
L_8ee462:
	st 0x640000,[r1, 0x50]
L_8ee46a:
	st_s r13,[r0,0x54]
L_8ee46c:
	st 0x840000,[r1, 0x54]
L_8ee474:
	st r21,[r0, 0x58]
L_8ee478:
	st 0xa40000,[r1, 0x58]
L_8ee480:
	st r20,[r0, 0x5c]
L_8ee484:
	st 0xc40000,[r1, 0x5c]
L_8ee48c:
	st r19,[r0, 0x60]
L_8ee490:
	st 0xe40000,[r1, 0x60]
L_8ee498:
	st r18,[r0, 0x64]
L_8ee49c:
	st 0x1040000,[r1, 0x64]
L_8ee4a4:
	st r17,[r0, 0x68]
L_8ee4a8:
	st 0x1240000,[r1, 0x68]
L_8ee4b0:
	st r16,[r0, 0x6c]
L_8ee4b4:
	st 0x1440000,[r1, 0x6c]
L_8ee4bc:
	st r24,[r0, 0x70]
L_8ee4c0:
	st 0x1640000,[r1, 0x70]
L_8ee4c8:
	st r25,[r0, 0x74]
L_8ee4cc:
	st 0x1840000,[r1, 0x74]
L_8ee4d4:
	st_s r14,[r0,0x78]
L_8ee4d6:
	st 0x1a40000,[r1, 0x78]
L_8ee4de:
	st_s r2,[r0,0x7c]
L_8ee4e0:
	st 0x1c40000,[r1, 0x7c]
L_8ee4e8:
	mov_s r1,0x887400
L_8ee4ee:
	st r22,[r1]
L_8ee4f2:
	mov_s r0,0x887180
L_8ee4f8:
	st 0x1e40000,[r0]
L_8ee500:
	st r23,[r1, 0x4]
L_8ee504:
	st 0x2040000,[r0, 0x4]
L_8ee50c:
	st_s r15,[r1,0x8]
L_8ee50e:
	st 0x2240000,[r0, 0x8]
L_8ee516:
	st r11,[r1, 0xc]
L_8ee51a:
	st 0x2440000,[r0, 0xc]
L_8ee522:
	st r10,[r1, 0x10]
L_8ee526:
	st 0x2640000,[r0, 0x10]
L_8ee52e:
	st r6,[r1, 0x14]
L_8ee532:
	st 0x2840000,[r0, 0x14]
L_8ee53a:
	st r5,[r1, 0x18]
L_8ee53e:
	st 0x2a40000,[r0, 0x18]
L_8ee546:
	st r4,[r1, 0x1c]
L_8ee54a:
	st 0x2c40000,[r0, 0x1c]
L_8ee552:
	st r7,[r1, 0x20]
L_8ee556:
	st 0x2e40000,[r0, 0x20]
L_8ee55e:
	st r8,[r1, 0x24]
L_8ee562:
	st 0x3040000,[r0, 0x24]
L_8ee56a:
	ld_s r2,[sp,0x20]
L_8ee56c:
	st_s r2,[r1,0x28]
L_8ee56e:
	st 0x3240000,[r0, 0x28]
L_8ee576:
	ld_s r2,[sp,0xc]
L_8ee578:
	st_s r2,[r1,0x2c]
L_8ee57a:
	st 0x3440000,[r0, 0x2c]
L_8ee582:
	mov_s r2,0x20
L_8ee584:
	st_s r2,[r1,0x30]
L_8ee586:
	st 0x3640000,[r0, 0x30]
L_8ee58e:
	ld_s r2,[sp,0x10]
L_8ee590:
	st_s r2,[r1,0x34]
L_8ee592:
	st 0x3840000,[r0, 0x34]
L_8ee59a:
	ld_s r2,[sp,0x14]
L_8ee59c:
	st_s r2,[r1,0x38]
L_8ee59e:
	st 0x3a40000,[r0, 0x38]
L_8ee5a6:
	ld_s r2,[sp,0x18]
L_8ee5a8:
	st_s r2,[r1,0x3c]
L_8ee5aa:
	st 0x3c40000,[r0, 0x3c]
L_8ee5b2:
	ld_s r2,[sp,0x1c]
L_8ee5b4:
	st_s r2,[r1,0x40]
L_8ee5b6:
	st 0x3e40000,[r0, 0x40]
L_8ee5be:
	mov_s r2,0x2a
L_8ee5c0:
	st_s r2,[r1,0x44]
L_8ee5c2:
	st 0x4040000,[r0, 0x44]
L_8ee5ca:
	mov_s r2,0x2b
L_8ee5cc:
	st_s r2,[r1,0x48]
L_8ee5ce:
	st 0x4240000,[r0, 0x48]
L_8ee5d6:
	mov_s r2,0x2c
L_8ee5d8:
	st_s r2,[r1,0x4c]
L_8ee5da:
	st 0x4440000,[r0, 0x4c]
L_8ee5e2:
	mov_s r2,0x2d
L_8ee5e4:
	st_s r2,[r1,0x50]
L_8ee5e6:
	st 0x4640000,[r0, 0x50]
L_8ee5ee:
	mov_s r2,0x2e
L_8ee5f0:
	st_s r2,[r1,0x54]
L_8ee5f2:
	st 0x4840000,[r0, 0x54]
L_8ee5fa:
	mov_s r2,0x2f
L_8ee5fc:
	st_s r2,[r1,0x58]
L_8ee5fe:
	st 0x4a40000,[r0, 0x58]
L_8ee606:
	mov_s r2,0x30
L_8ee608:
	st_s r2,[r1,0x5c]
L_8ee60a:
	st 0x4c40000,[r0, 0x5c]
L_8ee612:
	mov_s r2,0x32
L_8ee614:
	st_s r2,[r1,0x60]
L_8ee616:
	st 0x4e40000,[r0, 0x60]
L_8ee61e:
	mov_s r2,0x33
L_8ee620:
	st_s r2,[r1,0x64]
L_8ee622:
	st 0x5040000,[r0, 0x64]
L_8ee62a:
	mov_s r2,0x34
L_8ee62c:
	st_s r2,[r1,0x68]
L_8ee62e:
	st 0x52c0000,[r0, 0x68]
L_8ee636:
	mov_s r2,0x36
L_8ee638:
	st_s r2,[r1,0x6c]
L_8ee63a:
	st 0x5640000,[r0, 0x6c]
L_8ee642:
	mov_s r2,0x37
L_8ee644:
	st_s r2,[r1,0x70]
L_8ee646:
	st 0x5840000,[r0, 0x70]
L_8ee64e:
	mov_s r2,0x39
L_8ee650:
	st_s r2,[r1,0x74]
L_8ee652:
	st 0x5a40000,[r0, 0x74]
L_8ee65a:
	mov_s r2,0x3a
L_8ee65c:
	st_s r2,[r1,0x78]
L_8ee65e:
	st 0x5c40000,[r0, 0x78]
L_8ee666:
	mov_s r2,0x3b
L_8ee668:
	st_s r2,[r1,0x7c]
L_8ee66a:
	st 0x5ec0000,[r0, 0x7c]
L_8ee672:
	mov_s r0,0x3d
L_8ee674:
	mov_s r1,0x887480
L_8ee67a:
	st_s r0,[r1]
L_8ee67c:
	mov_s r0,0x887200
L_8ee682:
	st 0x6240000,[r0]
L_8ee68a:
	mov_s r2,0x3e
L_8ee68c:
	st_s r2,[r1,0x4]
L_8ee68e:
	st 0x6440000,[r0, 0x4]
L_8ee696:
	mov_s r2,0x40
L_8ee698:
	st_s r2,[r1,0x8]
L_8ee69a:
	st 0x6640000,[r0, 0x8]
L_8ee6a2:
	mov_s r2,0x41
L_8ee6a4:
	st_s r2,[r1,0xc]
L_8ee6a6:
	st 0x6840000,[r0, 0xc]
L_8ee6ae:
	mov_s r2,0x42
L_8ee6b0:
	st_s r2,[r1,0x10]
L_8ee6b2:
	st 0x6a40000,[r0, 0x10]
L_8ee6ba:
	mov_s r2,0x45
L_8ee6bc:
	st_s r2,[r1,0x14]
L_8ee6be:
	st 0x6c40000,[r0, 0x14]
L_8ee6c6:
	b.d L_8c02dc
L_8ee6ca:
	add_s sp,sp,0x24
