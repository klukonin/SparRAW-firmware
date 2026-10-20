/* rf__identify_type @ 0x8f4d3c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *         Identify RF Type: device_id=%d val1=0x%X val2=0x%X
 *         Identify RF Type : Sparrow-R
 *         Identify RF Type : UNKNOWN !!!
 * Зовут его: fw_main
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, check_rf_boardfile, fw_log_emit0, fw_log_emit3, hwd_rfc_read_rgf, rf__type_is_known, rfc__read_or_dead
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__identify_type
rf__identify_type:
	.global L_8f4d3c
L_8f4d3c:
	push_s blink
L_8f4d3e:
	bl L_8c01dc
L_8f4d42:
	bl.d L_8cae70
L_8f4d46:
	mov_s r14,r0
L_8f4d48:
	mov_s r13,0x0
L_8f4d4a:
	mov_s r0,r13
L_8f4d4c:
	bl.d L_8d3588
L_8f4d50:
	mov r1,0x428
L_8f4d54:
	mov_s r15,r0
L_8f4d56:
	mov_s r0,r13
L_8f4d58:
	bl.d L_8d3588
L_8f4d5c:
	mov r1,0x428
L_8f4d60:
	mov_s r16,r0
L_8f4d62:
	mov_s r1,0x10051a4
L_8f4d68:
	mov_s r0,0x20
L_8f4d6a:
	mov_s r2,r13
L_8f4d6c:
	mov_s r3,r15
L_8f4d6e:
	bl.d L_8dcd00
L_8f4d72:
	mov r4,r16
L_8f4d76:
	mov_s r0,0x8004c0
L_8f4d7c:
	ld_s r0,[r0]
L_8f4d7e:
	breq_s r0,0,L_8f4d94
L_8f4d80:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8f4d82:
	brne r15,r16,L_8f4d94
L_8f4d86:
	mov_s r15,0x2
L_8f4d88:
	stb_s r13,[r14]
L_8f4d8a:
	mov_s r1,0x10051e0
L_8f4d90:
	mov_s r0,0x20
L_8f4d92:
	b_s L_8f4da4
	.global L_8f4d94
L_8f4d94:
	mov_s r13,0x1
L_8f4d96:
	mov_s r0,0x0
L_8f4d98:
	mov_s r1,0xa
L_8f4d9a:
	stb_s r1,[r14]
L_8f4d9c:
	mov_s r1,0x1005204
L_8f4da2:
	mov_s r15,r0
	.global L_8f4da4
L_8f4da4:
	bl L_8dcba8
L_8f4da8:
	mov_s r0,0x880a3c
L_8f4dae:
	st_s r13,[r0,0x2c]
L_8f4db0:
	bl.d L_8da5c4
L_8f4db4:
	stw r15,[r0, 0x52]
L_8f4db8:
	cmp_s r0,0x1
L_8f4dba:
	bl.eq.d L_8f19b8
L_8f4dbe:
	mov.eq r0,r14
L_8f4dc2:
	b L_8c0244
L_8f4dc6:
	nop_s
