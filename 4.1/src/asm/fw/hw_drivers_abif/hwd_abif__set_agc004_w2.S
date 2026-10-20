/* hwd_abif__set_agc004_w2 @ 0x8cce38, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_mngr_step_b, hwf_calib_lo_leakage_res
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__set_agc004_w2,"ax",@progbits
	.global hwd_abif__set_agc004_w2
hwd_abif__set_agc004_w2:
	.global L_8cce38
L_8cce38:
	push_s blink
L_8cce3a:
	bl L_8c02c0
L_8cce3e:
	mov_s r13,r0
L_8cce40:
	mov_s r14,r1
L_8cce42:
	brge.d r0,0x20,L_8cce56
L_8cce46:
	mov_s r15,r2
	.global L_8cce48
L_8cce48:
	brge r14,0x2,L_8cce6e
	.global L_8cce4c
L_8cce4c:
	brge r15,0x4,L_8cce86
	.global L_8cce50
L_8cce50:
	breq_s r14,0,L_8cce9e
L_8cce52:
	mov_s r1,0x1c
L_8cce54:
	b_s L_8ccea0
	.global L_8cce56
L_8cce56:
	mov_s r0,blink
L_8cce58:
	mov_s r2,0x1019954
L_8cce5e:
	mov_s r1,0x1106
L_8cce64:
	bl.d L_8c82c0
L_8cce68:
	mov r3,0x662
L_8cce6c:
	b_s L_8cce48
	.global L_8cce6e
L_8cce6e:
	mov_s r0,blink
L_8cce70:
	mov_s r2,0x1019954
L_8cce76:
	mov_s r1,0x110b
L_8cce7c:
	bl.d L_8c82c0
L_8cce80:
	mov r3,0x663
L_8cce84:
	b_s L_8cce4c
	.global L_8cce86
L_8cce86:
	mov_s r0,blink
L_8cce88:
	mov_s r2,0x1019954
L_8cce8e:
	mov_s r1,0x110c
L_8cce94:
	bl.d L_8c82c0
L_8cce98:
	mov r3,0x664
L_8cce9c:
	b_s L_8cce50
	.global L_8cce9e
L_8cce9e:
	mov_s r1,0x13
	.global L_8ccea0
L_8ccea0:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8ccea2:
	/* add_s r13,0x2 */
	.byte 0x02,0xe5
L_8ccea4:
	mov_s r0,0x88a004
L_8cceaa:
	add2_s r0,r0,r13
L_8cceac:
	ld_s r3,[r0]
L_8cceae:
	mov_s r2,0x3
L_8cceb0:
	asl_s r2,r2,r1
L_8cceb2:
	bic_s r3,r3,r2
L_8cceb4:
	asl_s r15,r15,r1
L_8cceb6:
	or_s r3,r3,r15
L_8cceb8:
	st_s r3,[r0]
L_8cceba:
	b L_8c032c
L_8ccebe:
	nop_s
