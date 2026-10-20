/* dashboard__store_passphrase @ 0x8e5954, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_set_passphrase_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_fw
 */
	.section .text.dashboard__store_passphrase,"ax",@progbits
	.global dashboard__store_passphrase
dashboard__store_passphrase:
	.global L_8e5954
L_8e5954:
	push_s blink
L_8e5956:
	bl L_8c02c4
L_8e595a:
	mov_s r13,r0
L_8e595c:
	mov_s r14,r2
L_8e595e:
	add_s r0,r0,0x28
L_8e5960:
	bl.d L_8c0460
L_8e5964:
	ldw_s r2,[r13,0x26]
L_8e5966:
	b.d L_8c0334
L_8e596a:
	stw r14,[r13, 0x68]
L_8e596e:
	nop_s
