/* hwd_mac__set_886d80_8ce2bc @ 0x8ce2bc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__set_loopback
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_mac__set_886d80_8ce2bc,"ax",@progbits
	.global hwd_mac__set_886d80_8ce2bc
hwd_mac__set_886d80_8ce2bc:
	.global L_8ce2bc
L_8ce2bc:
	push_s blink
L_8ce2be:
	push_s r13
L_8ce2c0:
	brge.d r0,0x20,L_8ce2ec
L_8ce2c4:
	mov_s r13,r0
	.global L_8ce2c6
L_8ce2c6:
	mov_s r0,0x886d80
L_8ce2cc:
	st 0x3d000100,[r0, 0x48]
L_8ce2d4:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8ce2d6:
	or r13,r13,0x3e000000
L_8ce2de:
	st_s r13,[r0,0x48]
L_8ce2e0:
	st 0x3d001000,[r0, 0x48]
L_8ce2e8:
	b L_8c033c
	.global L_8ce2ec
L_8ce2ec:
	mov_s r0,blink
L_8ce2ee:
	mov_s r2,0x1019e38
L_8ce2f4:
	mov_s r1,0xd9
L_8ce2f6:
	bset_s r1,r1,0xc
L_8ce2f8:
	bl.d L_8c82c0
L_8ce2fc:
	mov_s r3,0x4a
L_8ce2fe:
	b_s L_8ce2c6
