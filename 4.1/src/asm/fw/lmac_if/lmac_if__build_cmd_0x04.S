/* lmac_if__build_cmd_0x04 @ 0x8d8d30, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if.cpp
 * Зовут его: lmac_if_send_cmd_0x04
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.lmac_if__build_cmd_0x04,"ax",@progbits
	.global lmac_if__build_cmd_0x04
lmac_if__build_cmd_0x04:
	.global L_8d8d30
L_8d8d30:
	push_s blink
L_8d8d32:
	bl L_8c02c4
L_8d8d36:
	mov_s r14,r0
L_8d8d38:
	mov_s r13,0x0
L_8d8d3a:
	breq_s r1,0,L_8d8d5a
L_8d8d3c:
	breq r1,0x1,L_8d8d62
L_8d8d40:
	breq r1,0x2,L_8d8d6a
L_8d8d44:
	mov_s r0,blink
L_8d8d46:
	mov_s r2,0x1003e50
L_8d8d4c:
	mov_s r1,0xcd
L_8d8d4e:
	bset_s r1,r1,0xc
L_8d8d50:
	bl.d L_8c82c0
L_8d8d54:
	mov r3,0x47f
L_8d8d58:
	b_s L_8d8d70
	.global L_8d8d5a
L_8d8d5a:
	mov_s r13,0x800b1c
L_8d8d60:
	b_s L_8d8d70
	.global L_8d8d62
L_8d8d62:
	mov_s r13,0x800b20
L_8d8d68:
	b_s L_8d8d70
	.global L_8d8d6a
L_8d8d6a:
	mov_s r13,0x800b24
	.global L_8d8d70
L_8d8d70:
	mov_s r1,0x0
L_8d8d72:
	b_s L_8d8d9c
	.global L_8d8d74
L_8d8d74:
	asl_s r2,r1,0x2
L_8d8d76:
	add1_s r2,r2,r2
L_8d8d78:
	add_s r2,r2,r14
L_8d8d7a:
	st_s r1,[r2]
L_8d8d7c:
	ldw_s r0,[r13]
L_8d8d7e:
	brne_s r1,0,L_8d8d86
L_8d8d80:
	min r0,r0,0x4
L_8d8d84:
	extw_s r0,r0
	.global L_8d8d86
L_8d8d86:
	stw_s r0,[r2,0x4]
L_8d8d88:
	ld_s r3,[r2]
L_8d8d8a:
	ldw_s r0,[r13,0x2]
L_8d8d8c:
	brne_s r3,0,L_8d8d94
L_8d8d8e:
	min r0,r0,0x4
L_8d8d92:
	extw_s r0,r0
	.global L_8d8d94
L_8d8d94:
	stw_s r0,[r2,0x6]
L_8d8d96:
	mov_s r0,0x2
L_8d8d98:
	stw_s r0,[r2,0x8]
L_8d8d9a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d8d9c
L_8d8d9c:
	brlt r1,0x4,L_8d8d74
L_8d8da0:
	b L_8c0334
