/* lmac_if_send_cmd_0x22 @ 0x8d8e68, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__psc_complete
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x22,"ax",@progbits
	.global lmac_if_send_cmd_0x22
lmac_if_send_cmd_0x22:
	.global L_8d8e68
L_8d8e68:
	push_s blink
L_8d8e6a:
	bl L_8c02c0
L_8d8e6e:
	mov_s r14,r0
L_8d8e70:
	mov_s r15,r1
L_8d8e72:
	bl.d L_8c2b0c
L_8d8e76:
	mov_s r13,r2
L_8d8e78:
	stb_s r14,[r0]
L_8d8e7a:
	stb_s r15,[r0,0x1]
L_8d8e7c:
	ld_s r1,[r13]
L_8d8e7e:
	mov_s r2,0xc
L_8d8e80:
	st_s r1,[r0,0x4]
L_8d8e82:
	ldw_s r1,[r13,0x6]
L_8d8e84:
	stw_s r1,[r0,0xa]
L_8d8e86:
	ldw_s r1,[r13,0x4]
L_8d8e88:
	stw_s r1,[r0,0x8]
L_8d8e8a:
	mov_s r1,0x22
L_8d8e8c:
	bl.d L_8e0694
L_8d8e90:
	mov_s r3,0x0
L_8d8e92:
	b L_8c032c
L_8d8e96:
	nop_s
