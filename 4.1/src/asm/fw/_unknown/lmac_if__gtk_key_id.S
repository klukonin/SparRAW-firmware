/* lmac_if__gtk_key_id @ 0x8cad54, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   GTK key_id: %d.
 * Зовут его: lmac_if__key_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, l2mgr__send_vring_en, mid_list__first_of_field8, ut_hw_cmd_0x008
 */
	.section .text.lmac_if__gtk_key_id,"ax",@progbits
	.global lmac_if__gtk_key_id
lmac_if__gtk_key_id:
	.global L_8cad54
L_8cad54:
	push_s blink
L_8cad56:
	bl L_8c02c0
L_8cad5a:
	mov_s r13,0x0
L_8cad5c:
	b_s L_8cad60
	.global L_8cad5e
L_8cad5e:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8cad60
L_8cad60:
	brhs r13,0xa,L_8cadb2
L_8cad64:
	mov_s r0,0x8485dc
L_8cad6a:
	sub3 r0,r0,0x100
L_8cad6e:
	add2_s r0,r0,r13
L_8cad70:
	ld r14,[r0,0x818]
L_8cad78:
	breq_s r14,0,L_8cad5e
L_8cad7a:
	ld_s r0,[r14,0xc]
L_8cad7c:
	breq_s r0,0,L_8cad5e
L_8cad7e:
	ldb_s r0,[r14,0x7]
L_8cad80:
	breq r0,0x9,L_8cad5e
L_8cad84:
	bl.d L_8ca1f0
L_8cad88:
	mov_s r0,r14
L_8cad8a:
	mov_s r15,r0
L_8cad8c:
	add r15,r15,0x2cc
L_8cad90:
	mov_s r0,r14
L_8cad92:
	mov_s r1,0x1
L_8cad94:
	bl.d L_8e59d8
L_8cad98:
	ldb_s r2,[r15,0x10]
L_8cad9a:
	mov_s r2,0x100e9a4
L_8cada0:
	mov_s r0,0xb
L_8cada2:
	mov_s r1,0x2
L_8cada4:
	bl.d L_8edfcc
L_8cada8:
	ldb_s r3,[r15,0x10]
L_8cadaa:
	mov_s r0,r13
L_8cadac:
	bl.d L_8ed5cc
L_8cadb0:
	ld_s r1,[r14,0x8]
	.global L_8cadb2
L_8cadb2:
	b L_8c032c
L_8cadb6:
	nop_s
