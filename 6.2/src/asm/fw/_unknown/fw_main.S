/* fw_main @ 0x8f00dc, 872 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MAIN() BOOT STARTS
 *   MAIN() set MAC_SXD_ERRORS_ISR interrupt to level 1
 *   MAIN() Running Full FW
 *   MAIN() FW Boot occur before HW Boot ended
 *   MAIN() HW statemachine WA
 *   MAIN() RUNNING IN FPGA MODE !!!!!!
 *   BUG_5382_WA - hwd_pcie_perst_deassert_int_clear()
 *   hwd_pcie_perst_deassert_int_en()
 * Зовут его: crt0__clear_bss_and_main
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, arc_action_point__install_default, baseband__identify, boot__force_production_mode, boot__init_subsystems, boot__install_diag_magic, boot__load_from_flash, boot__publish_ids, boot__read_strap_bit, boot_fill_addr_tables, calib_engine__init_all
 * Глобалы (через gp): 0x8002d8, 0x800378, 0x80042c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_main
fw_main:
	.global L_8f00dc
L_8f00dc:
	push_s blink
L_8f00de:
	bl L_8c01e4
L_8f00e2:
	mov_s r0,0x803b80
L_8f00e8:
	bl L_8f519c
L_8f00ec:
	mov lp_count,0xd
L_8f00f0:
	mov_s r1,0x0
L_8f00f2:
	lp L_8f010a
L_8f00f6:
	mov_s r0,0x803908
L_8f00fc:
	ldb_s r2,[r0,r1]
L_8f00fe:
	mov_s r0,0x8891b4
L_8f0104:
	add2_s r0,r0,r1
L_8f0106:
	st_s r2,[r0]
L_8f0108:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8f010a
L_8f010a:
	mov r1,-0x3
L_8f010e:
	mov_s r0,0x857700
L_8f0114:
	st_s r1,[r0,0x30]
L_8f0116:
	mov_s r13,0x0
L_8f0118:
	mov_s r1,0x880a3c
L_8f011e:
	ld_s r0,[r1,0x28]
L_8f0120:
	st_s r13,[r1,0x40]
L_8f0122:
	bclr_s r0,r0,0x0
L_8f0124:
	st_s r0,[r1,0x28]
L_8f0126:
	ld_s r0,[r1,0x58]
L_8f0128:
	st_s r13,[r1,0x3c]
L_8f012a:
	bclr_s r0,r0,0x0
L_8f012c:
	bl.d L_8d8ec0
L_8f0130:
	st_s r0,[r1,0x58]
L_8f0132:
	bl L_8f538c
L_8f0136:
	bl L_8dcb1c
L_8f013a:
	mov_s r1,0x1000760
L_8f0140:
	bl.d L_8dcba8
L_8f0144:
	mov_s r0,0x20
L_8f0146:
	mov_s r0,0x6
L_8f0148:
	bl.d L_8c3bd8
L_8f014c:
	mov_s r1,r13
L_8f014e:
	mov_s r1,0x1000774
L_8f0154:
	bl.d L_8dcba8
L_8f0158:
	mov_s r0,0x20
L_8f015a:
	mov_s r1,0x10007a8
L_8f0160:
	bl.d L_8dcba8
L_8f0164:
	mov_s r0,0x20
L_8f0166:
	ld_s r0,[gp,0x154]
L_8f0168:
	brne r0,0x11111111,L_8f017a
L_8f0170:
	st.as 0x22222222,[gp,0x55]
L_8f0178:
	b_s L_8f0192
	.global L_8f017a
L_8f017a:
	mov_s r1,0x10007c0
L_8f0180:
	bl.d L_8dcba8
L_8f0184:
	mov_s r0,0x20
L_8f0186:
	mov_s r0,blink
L_8f0188:
	mov_s r1,0x11b1
L_8f018e:
	bl L_8c9b28
	.global L_8f0192
L_8f0192:
	bl L_8f4c9c
L_8f0196:
	bl L_8ea694
L_8f019a:
	bl L_8d9b58
L_8f019e:
	bl L_8f5678
L_8f01a2:
	bl L_8d9f9c
L_8f01a6:
	bl L_8f53dc
L_8f01aa:
	mov_s r1,0x10007ec
L_8f01b0:
	bl.d L_8dcba8
L_8f01b4:
	mov_s r0,0x20
	.global L_8f01b6
L_8f01b6:
	nop_s
L_8f01b8:
	nop_s
L_8f01ba:
	nop_s
L_8f01bc:
	nop_s
L_8f01be:
	nop_s
L_8f01c0:
	nop_s
L_8f01c2:
	nop_s
L_8f01c4:
	nop_s
L_8f01c6:
	nop_s
L_8f01c8:
	nop_s
L_8f01ca:
	nop_s
L_8f01cc:
	nop_s
L_8f01ce:
	nop_s
L_8f01d0:
	nop_s
L_8f01d2:
	nop_s
L_8f01d4:
	nop_s
L_8f01d6:
	mov_s r0,0x11
L_8f01d8:
	asl_s r0,r0,0x13
L_8f01da:
	ld.as r0,[r0,0x80]
L_8f01de:
	bbit0 r0,0x6,L_8f01b6
L_8f01e2:
	mov_s r1,0x880180
L_8f01e8:
	st 0x80000000,[r1, 0x58]
L_8f01f0:
	ld_s r0,[r1,0x58]
L_8f01f2:
	bmsk_s r0,r0,0x4
L_8f01f4:
	brne r0,0x15,L_8f0200
L_8f01f8:
	st 0x40000000,[r1, 0x58]
	.global L_8f0200
L_8f0200:
	bl L_8da2c8
L_8f0204:
	breq_s r0,0,L_8f0212
L_8f0206:
	mov_s r1,0x1000808
L_8f020c:
	bl.d L_8dcba8
L_8f0210:
	mov_s r0,0x20
	.global L_8f0212
L_8f0212:
	bl L_8f2f9c
L_8f0216:
	bl L_8f8384
L_8f021a:
	bl L_8d1a78
L_8f021e:
	bl L_8da2f0
L_8f0222:
	breq_s r0,0,L_8f0234
L_8f0224:
	mov_s r1,0x1000634
L_8f022a:
	bl.d L_8dcba8
L_8f022e:
	mov_s r0,0x20
L_8f0230:
	bl L_8d198c
	.global L_8f0234
L_8f0234:
	mov_s r1,0x1000668
L_8f023a:
	bl.d L_8dcba8
L_8f023e:
	mov_s r0,0x20
L_8f0240:
	bl L_8d1998
L_8f0244:
	ld_s r0,[gp,0x1f4]
L_8f0246:
	breq_s r0,0,L_8f0258
L_8f0248:
	mov_s r1,0x100068c
L_8f024e:
	bl.d L_8dcba8
L_8f0252:
	mov_s r0,0x20
L_8f0254:
	bl L_8d1980
	.global L_8f0258
L_8f0258:
	mov_s r1,0x10006ac
L_8f025e:
	bl.d L_8dcba8
L_8f0262:
	mov_s r0,0x20
L_8f0264:
	bl L_8d1240
L_8f0268:
	mov_s r1,0x10006c8
L_8f026e:
	bl.d L_8dcba8
L_8f0272:
	mov_s r0,0x20
L_8f0274:
	bl L_8d11a8
L_8f0278:
	mov_s r1,0x10006e0
L_8f027e:
	bl.d L_8dcba8
L_8f0282:
	mov_s r0,0x20
L_8f0284:
	mov_s r32,r13
L_8f0286:
	mov_s r1,0x10006f8
L_8f028c:
	bl.d L_8dcba8
L_8f0290:
	mov_s r0,0x20
L_8f0292:
	bl L_8f6e08
L_8f0296:
	mov_s r1,0x100082c
L_8f029c:
	bl.d L_8dcba8
L_8f02a0:
	mov_s r0,0x20
L_8f02a2:
	bl L_8c02a4
L_8f02a6:
	mov_s r1,0x100084c
L_8f02ac:
	bl.d L_8dcba8
L_8f02b0:
	mov_s r0,0x20
L_8f02b2:
	bl L_8f6584
L_8f02b6:
	bl L_8f6424
L_8f02ba:
	mov_s r1,0x100086c
L_8f02c0:
	bl.d L_8dcba8
L_8f02c4:
	mov_s r0,0x20
L_8f02c6:
	bl L_8f56b8
L_8f02ca:
	bl L_8da61c
L_8f02ce:
	breq_s r0,0,L_8f02e0
L_8f02d0:
	mov_s r1,0x1000888
L_8f02d6:
	bl.d L_8dcba8
L_8f02da:
	mov_s r0,0x20
L_8f02dc:
	bl L_8d7760
	.global L_8f02e0
L_8f02e0:
	mov_s r1,0x10008ac
L_8f02e6:
	bl.d L_8dcba8
L_8f02ea:
	mov_s r0,0x20
L_8f02ec:
	bl.d L_8da81c
L_8f02f0:
	mov_s r0,0x3
L_8f02f2:
	mov_s r13,0x0
L_8f02f4:
	bl.d L_8da84c
L_8f02f8:
	mov_s r0,r13
L_8f02fa:
	bl L_8da61c
L_8f02fe:
	breq_s r0,0,L_8f0310
L_8f0300:
	mov_s r1,0x10008c4
L_8f0306:
	bl.d L_8dcba8
L_8f030a:
	mov_s r0,0x20
L_8f030c:
	bl L_8d1ccc
	.global L_8f0310
L_8f0310:
	bl L_8da61c
L_8f0314:
	brne_s r0,0,L_8f031c
L_8f0316:
	bl L_8da2c8
L_8f031a:
	breq_s r0,0,L_8f0372
	.global L_8f031c
L_8f031c:
	mov_s r1,0x10008e0
L_8f0322:
	bl.d L_8dcba8
L_8f0326:
	mov_s r0,0x20
L_8f0328:
	mov_s r14,0x8042c8
L_8f032e:
	bl.d L_8f590c
L_8f0332:
	mov_s r0,r14
L_8f0334:
	bl.d L_8f4d3c
L_8f0338:
	mov_s r0,r14
L_8f033a:
	mov_s r1,0x10008f8
L_8f0340:
	bl.d L_8dcba8
L_8f0344:
	mov_s r0,0x20
L_8f0346:
	bl.d L_8e2e88
L_8f034a:
	mov_s r0,r14
L_8f034c:
	brne r0,0x2,L_8f0362
L_8f0350:
	bl.d L_8e2fa8
L_8f0354:
	mov_s r0,r14
L_8f0356:
	mov_s r0,blink
L_8f0358:
	mov_s r1,0x1186
L_8f035e:
	bl L_8c9b28
	.global L_8f0362
L_8f0362:
	mov_s r1,0x100092c
L_8f0368:
	bl.d L_8dcba8
L_8f036c:
	mov_s r0,0x10
L_8f036e:
	bl L_8d2d10
	.global L_8f0372
L_8f0372:
	ld_s r0,[gp,0x2a8]
L_8f0374:
	breq_s r0,0,L_8f0386
L_8f0376:
	mov_s r1,0x1000968
L_8f037c:
	bl.d L_8dcba8
L_8f0380:
	mov_s r0,0x20
L_8f0382:
	bl L_8cadec
	.global L_8f0386
L_8f0386:
	mov_s r1,0x10009a4
L_8f038c:
	bl.d L_8dcba8
L_8f0390:
	mov_s r0,0x20
L_8f0392:
	bl L_8da8f4
L_8f0396:
	mov_s r0,0x880a3c
L_8f039c:
	st_s r13,[r0,0x24]
L_8f039e:
	st_s r13,[r0,0x1c]
L_8f03a0:
	st_s r13,[r0,0x20]
L_8f03a2:
	mov_s r1,0x10009c4
L_8f03a8:
	bl.d L_8dcba8
L_8f03ac:
	mov_s r0,0x20
L_8f03ae:
	bl L_8d0760
L_8f03b2:
	mov_s r1,0x1000a1c
L_8f03b8:
	bl.d L_8dcba8
L_8f03bc:
	mov_s r0,0x20
L_8f03be:
	mov_s r32,r13
L_8f03c0:
	mov_s r1,0x1000a3c
L_8f03c6:
	bl.d L_8dcba8
L_8f03ca:
	mov_s r0,0x20
L_8f03cc:
	mov_s r0,0x3ffff
L_8f03d2:
	bl L_8c3b68
L_8f03d6:
	bl L_8f90ac
L_8f03da:
	mov_s r1,0x1000718
L_8f03e0:
	bl.d L_8dcba8
L_8f03e4:
	mov_s r0,0x20
L_8f03e6:
	bl L_8d9390
L_8f03ea:
	mov_s r1,0x1000730
L_8f03f0:
	bl.d L_8dcba8
L_8f03f4:
	mov_s r0,0x20
L_8f03f6:
	bl L_8f50c8
L_8f03fa:
	mov_s r1,0x1000748
L_8f0400:
	bl.d L_8dcba8
L_8f0404:
	mov_s r0,0x20
L_8f0406:
	bl L_8f5138
L_8f040a:
	bl L_8f5fd8
L_8f040e:
	bl.d L_8e8634
L_8f0412:
	mov_s r0,0x4
L_8f0414:
	mov_s r1,0x1000a74
L_8f041a:
	bl.d L_8dcba8
L_8f041e:
	mov_s r0,0x20
L_8f0420:
	bl L_8e8578
L_8f0424:
	bl L_8da61c
L_8f0428:
	cmp_s r0,0x0
L_8f042a:
	bl.ne L_8f6cb0
L_8f042e:
	mov_s r1,0x1000ab4
L_8f0434:
	bl.d L_8dcba8
L_8f0438:
	mov_s r0,0x20
L_8f043a:
	bl L_8ea698
L_8f043e:
	b L_8c0254
L_8f0442:
	nop_s
