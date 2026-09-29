/* hwd_rfc__program_clocks @ 0x8d0394, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_rfc.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__program_rf_clocks, marlon_r_if_class__init_board_file_inteface
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 * Глобалы (через gp): 0x800216
 */
	.section .text.hwd_rfc__program_clocks,"ax",@progbits
	.global hwd_rfc__program_clocks
hwd_rfc__program_clocks:
	.global L_8d0394
L_8d0394:
	push_s blink
L_8d0396:
	mov_s r3,0x889400
L_8d039c:
	mov_s r2,0x889100
L_8d03a2:
	mov_s r1,0x889380
L_8d03a8:
	push_s r13
L_8d03aa:
	brne r0,0x1,L_8d0414
L_8d03ae:
	ld_s r0,[r3,0x1c]
L_8d03b0:
	mov_s r13,0x889480
L_8d03b6:
	bclr_s r0,r0,0x3
L_8d03b8:
	st_s r0,[r3,0x1c]
L_8d03ba:
	ld_s r0,[r2,0x54]
L_8d03bc:
	bset_s r0,r0,0xb
L_8d03be:
	bset_s r0,r0,0x10
L_8d03c0:
	st_s r0,[r2,0x54]
L_8d03c2:
	ld_s r0,[r1,0x14]
L_8d03c4:
	bset_s r0,r0,0x0
L_8d03c6:
	st_s r0,[r1,0x14]
L_8d03c8:
	ld_s r0,[r13,0x20]
L_8d03ca:
	bic r0,r0,0x1e0
L_8d03ce:
	or r0,r0,0xc0
L_8d03d2:
	st_s r0,[r13,0x20]
L_8d03d4:
	ld_s r0,[r13,0x20]
L_8d03d6:
	and r0,r0,0xffffe1ff
L_8d03de:
	bset_s r0,r0,0xa
L_8d03e0:
	bset_s r0,r0,0xb
L_8d03e2:
	bset_s r0,r0,0xc
L_8d03e4:
	st_s r0,[r13,0x20]
L_8d03e6:
	ldb_s r0,[gp,0xa6]
L_8d03e8:
	bic.f r0,r0,0xf
L_8d03ec:
	bne_s L_8d0402
	.global L_8d03ee
L_8d03ee:
	ld_s r1,[r13,0x20]
L_8d03f0:
	ldb_s r0,[gp,0xa6]
L_8d03f2:
	and r1,r1,0xffe1ffff
L_8d03fa:
	asl_s r0,r0,0x11
L_8d03fc:
	or_s r0,r0,r1
L_8d03fe:
	st_s r0,[r13,0x20]
L_8d0400:
	b_s L_8d0428
	.global L_8d0402
L_8d0402:
	mov_s r0,blink
L_8d0404:
	mov_s r2,0x1018f58
L_8d040a:
	mov_s r1,0xac
L_8d040c:
	bl.d L_8c82c0
L_8d0410:
	mov_s r3,0x6b
L_8d0412:
	b_s L_8d03ee
	.global L_8d0414
L_8d0414:
	ld_s r0,[r2,0x54]
L_8d0416:
	bclr_s r0,r0,0xb
L_8d0418:
	bclr_s r0,r0,0x10
L_8d041a:
	st_s r0,[r2,0x54]
L_8d041c:
	ld_s r0,[r1,0x14]
L_8d041e:
	bclr_s r0,r0,0x0
L_8d0420:
	st_s r0,[r1,0x14]
L_8d0422:
	ld_s r0,[r3,0x1c]
L_8d0424:
	bset_s r0,r0,0x3
L_8d0426:
	st_s r0,[r3,0x1c]
	.global L_8d0428
L_8d0428:
	b L_8c033c
