/* radio_mgr__enqueue_request @ 0x8ddc28, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_manager__lock_primary, radio_manager__lock_secondary
 * Зовёт сам: __ld_r13_ret, llist__insert, radio_mgr__inject_evt3
 */
	.section .text.radio_mgr__enqueue_request,"ax",@progbits
	.global radio_mgr__enqueue_request
radio_mgr__enqueue_request:
	.global L_8ddc28
L_8ddc28:
	push_s blink
L_8ddc2a:
	push_s r13
L_8ddc2c:
	bl.d L_8c1fc4
L_8ddc30:
	mov_s r13,r0
L_8ddc32:
	bl.d L_8dd0a4
L_8ddc36:
	ld_s r0,[r13,0xc]
L_8ddc38:
	b L_8c033c
