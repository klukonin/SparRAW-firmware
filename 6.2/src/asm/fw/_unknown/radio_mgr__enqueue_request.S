/* radio_mgr__enqueue_request @ 0x8e1f70, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_lock_radio, rm_main_sm__lock_primary
 * Зовёт сам: __ld_r13_to_r13_ret, list__find_entry_d, vring_schd__prohibit_cids
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__enqueue_request
radio_mgr__enqueue_request:
	.global L_8e1f70
L_8e1f70:
	push_s blink
L_8e1f72:
	push_s r13
L_8e1f74:
	bl.d L_8c25f4
L_8e1f78:
	mov_s r13,r0
L_8e1f7a:
	bl.d L_8e1218
L_8e1f7e:
	ld_s r0,[r13,0xc]
L_8e1f80:
	b L_8c025c
