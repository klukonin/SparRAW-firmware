/* hwd_abif__tx_table_config_lo_leak_gain @ 0x8cfdbc, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_silent_rssi_sparrow__correction_alg
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_config_lo_leak_gain
hwd_abif__tx_table_config_lo_leak_gain:
	.global L_8cfdbc
L_8cfdbc:
	push_s blink
L_8cfdbe:
	bl L_8c01e0
L_8cfdc2:
	mov_s r13,r0
L_8cfdc4:
	mov_s r14,r1
L_8cfdc6:
	brge.d r0,0x20,L_8cfdda
L_8cfdca:
	mov_s r15,r2
	.global L_8cfdcc
L_8cfdcc:
	brge r14,0x2,L_8cfde8
	.global L_8cfdd0
L_8cfdd0:
	brge r15,0x4,L_8cfdf6
	.global L_8cfdd4
L_8cfdd4:
	breq_s r14,0,L_8cfe04
L_8cfdd6:
	mov_s r1,0x1c
L_8cfdd8:
	b_s L_8cfe06
	.global L_8cfdda
L_8cfdda:
	mov_s r0,blink
L_8cfddc:
	mov_s r1,0x1106
L_8cfde2:
	bl L_8c9b28
L_8cfde6:
	b_s L_8cfdcc
	.global L_8cfde8
L_8cfde8:
	mov_s r0,blink
L_8cfdea:
	mov_s r1,0x110b
L_8cfdf0:
	bl L_8c9b28
L_8cfdf4:
	b_s L_8cfdd0
	.global L_8cfdf6
L_8cfdf6:
	mov_s r0,blink
L_8cfdf8:
	mov_s r1,0x110c
L_8cfdfe:
	bl L_8c9b28
L_8cfe02:
	b_s L_8cfdd4
	.global L_8cfe04
L_8cfe04:
	mov_s r1,0x13
	.global L_8cfe06
L_8cfe06:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cfe08:
	/* add_s r13,0x2 */
	.byte 0x02,0xe5
L_8cfe0a:
	mov_s r0,0x88a004
L_8cfe10:
	add2_s r0,r0,r13
L_8cfe12:
	ld_s r3,[r0]
L_8cfe14:
	mov_s r2,0x3
L_8cfe16:
	asl_s r2,r2,r1
L_8cfe18:
	bic_s r3,r3,r2
L_8cfe1a:
	asl_s r15,r15,r1
L_8cfe1c:
	or_s r3,r3,r15
L_8cfe1e:
	st_s r3,[r0]
L_8cfe20:
	b L_8c024c
