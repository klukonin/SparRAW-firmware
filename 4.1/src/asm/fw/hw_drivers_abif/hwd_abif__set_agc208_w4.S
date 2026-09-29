/* hwd_abif__set_agc208_w4 @ 0x8cc0c8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_if_gain__apply_agc_table
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__set_agc208_w4,"ax",@progbits
	.global hwd_abif__set_agc208_w4
hwd_abif__set_agc208_w4:
	.global L_8cc0c8
L_8cc0c8:
	push_s blink
L_8cc0ca:
	bl L_8c02bc
L_8cc0ce:
	mov_s r13,r0
L_8cc0d0:
	cmp_s r0,0x40
L_8cc0d2:
	mov_s r14,r1
L_8cc0d4:
	mov_s r15,r2
L_8cc0d6:
	bge_s L_8cc100
	.global L_8cc0d8
L_8cc0d8:
	mov r16,0x0
L_8cc0dc:
	breq r14,0x1,L_8cc116
L_8cc0e0:
	breq r14,0x2,L_8cc11a
L_8cc0e4:
	breq r14,0x3,L_8cc11e
L_8cc0e8:
	mov_s r0,blink
L_8cc0ea:
	mov_s r2,0x1019954
L_8cc0f0:
	mov_s r1,0xfe
L_8cc0f2:
	bset_s r1,r1,0xc
L_8cc0f4:
	bl.d L_8c82c0
L_8cc0f8:
	mov r3,0x603
L_8cc0fc:
	mov_s r1,r16
L_8cc0fe:
	b_s L_8cc120
	.global L_8cc100
L_8cc100:
	mov_s r0,blink
L_8cc102:
	mov_s r2,0x1019954
L_8cc108:
	mov_s r1,0xfd
L_8cc10a:
	bset_s r1,r1,0xc
L_8cc10c:
	bl.d L_8c82c0
L_8cc110:
	mov r3,0x5f4
L_8cc114:
	b_s L_8cc0d8
	.global L_8cc116
L_8cc116:
	mov_s r1,0x11
L_8cc118:
	b_s L_8cc120
	.global L_8cc11a
L_8cc11a:
	mov_s r1,0x15
L_8cc11c:
	b_s L_8cc120
	.global L_8cc11e
L_8cc11e:
	mov_s r1,0x19
	.global L_8cc120
L_8cc120:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cc122:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_8cc124:
	mov_s r0,0x88a208
L_8cc12a:
	add2_s r0,r0,r13
L_8cc12c:
	ld_s r3,[r0]
L_8cc12e:
	mov_s r2,0xf
L_8cc130:
	asl_s r2,r2,r1
L_8cc132:
	bic_s r3,r3,r2
L_8cc134:
	asl_s r15,r15,r1
L_8cc136:
	or_s r3,r3,r15
L_8cc138:
	st_s r3,[r0]
L_8cc13a:
	b L_8c0324
L_8cc13e:
	nop_s
