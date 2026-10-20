/* hwd_abif__tx_table_config_lo_leak_ctrl @ 0x8cfd50, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_silent_rssi_sparrow__correction_alg, hwf__set_agc_index_1c
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_config_lo_leak_ctrl
hwd_abif__tx_table_config_lo_leak_ctrl:
	.global L_8cfd50
L_8cfd50:
	push_s blink
L_8cfd52:
	bl L_8c01e0
L_8cfd56:
	mov_s r13,r0
L_8cfd58:
	mov_s r14,r1
L_8cfd5a:
	brge.d r0,0x20,L_8cfd70
L_8cfd5e:
	mov_s r15,r2
	.global L_8cfd60
L_8cfd60:
	brge r14,0x2,L_8cfd7e
	.global L_8cfd64
L_8cfd64:
	cmp r15,0x80
L_8cfd68:
	bge_s L_8cfd8c
	.global L_8cfd6a
L_8cfd6a:
	breq_s r14,0,L_8cfd9a
L_8cfd6c:
	mov_s r1,0x15
L_8cfd6e:
	b_s L_8cfd9c
	.global L_8cfd70
L_8cfd70:
	mov_s r0,blink
L_8cfd72:
	mov_s r1,0x1116
L_8cfd78:
	bl L_8c9b28
L_8cfd7c:
	b_s L_8cfd60
	.global L_8cfd7e
L_8cfd7e:
	mov_s r0,blink
L_8cfd80:
	mov_s r1,0x1117
L_8cfd86:
	bl L_8c9b28
L_8cfd8a:
	b_s L_8cfd64
	.global L_8cfd8c
L_8cfd8c:
	mov_s r0,blink
L_8cfd8e:
	mov_s r1,0x111c
L_8cfd94:
	bl L_8c9b28
L_8cfd98:
	b_s L_8cfd6a
	.global L_8cfd9a
L_8cfd9a:
	mov_s r1,0xc
	.global L_8cfd9c
L_8cfd9c:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cfd9e:
	/* add_s r13,0x2 */
	.byte 0x02,0xe5
L_8cfda0:
	mov_s r0,0x88a004
L_8cfda6:
	add2_s r0,r0,r13
L_8cfda8:
	ld_s r3,[r0]
L_8cfdaa:
	mov_s r2,0x7f
L_8cfdac:
	asl_s r2,r2,r1
L_8cfdae:
	bic_s r3,r3,r2
L_8cfdb0:
	asl_s r15,r15,r1
L_8cfdb2:
	or_s r3,r3,r15
L_8cfdb4:
	st_s r3,[r0]
L_8cfdb6:
	b L_8c024c
L_8cfdba:
	nop_s
