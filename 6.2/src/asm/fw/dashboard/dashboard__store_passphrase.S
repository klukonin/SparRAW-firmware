/* dashboard__store_passphrase @ 0x8eac90, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_set_passphrase_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dashboard__store_passphrase
dashboard__store_passphrase:
	.global L_8eac90
L_8eac90:
	push_s blink
L_8eac92:
	bl L_8c01e4
L_8eac96:
	mov_s r13,r0
L_8eac98:
	mov_s r14,r2
L_8eac9a:
	add_s r0,r0,0x28
L_8eac9c:
	bl.d L_8c0380
L_8eaca0:
	ldw_s r2,[r13,0x26]
L_8eaca2:
	b.d L_8c0254
L_8eaca6:
	stw r14,[r13, 0x68]
L_8eacaa:
	nop_s
