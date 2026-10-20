/* find_main_sm__stop @ 0x8f9ac8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::stop()  unlocking radio 0x%x
 *   FIND_SM:: free dband info when stop
 * Зовут его: find_main_sm__stop_searching
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, find_mngr__del_discovery_bcon, find_sm__stop_discovery, free_dband_info, fw_log_emit0, fw_log_emit1, llist__pop_front, radio_mgr__call_method_10
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_main_sm__stop
find_main_sm__stop:
	.global L_8f9ac8
L_8f9ac8:
	push_s blink
L_8f9aca:
	bl L_8c01e4
L_8f9ace:
	mov_s r13,r0
L_8f9ad0:
	mov_s r1,0x1017bcc
L_8f9ad6:
	mov_s r0,0x2c
L_8f9ad8:
	bl.d L_8dcc10
L_8f9adc:
	ld_s r2,[r13,0x14]
L_8f9ade:
	bl.d L_8ea800
L_8f9ae2:
	ld_s r0,[r13,0x14]
L_8f9ae4:
	mov_s r0,0x0
L_8f9ae6:
	st_s r0,[r13,0x14]
L_8f9ae8:
	b_s L_8f9b00
	.global L_8f9aea
L_8f9aea:
	mov_s r1,0x1017bf8
L_8f9af0:
	bl.d L_8dcba8
L_8f9af4:
	mov_s r0,0x1c
L_8f9af6:
	bl.d L_8e2674
L_8f9afa:
	mov_s r0,r14
L_8f9afc:
	bl L_8f31a0
	.global L_8f9b00
L_8f9b00:
	add r14,r13,0x18
L_8f9b04:
	ld_s r0,[r14]
L_8f9b06:
	sub.f r0,r0,0x0
L_8f9b0a:
	mov.ne r0,0x1
L_8f9b0e:
	extb.f 0x0,r0
L_8f9b12:
	bne_s L_8f9aea
L_8f9b14:
	bl.d L_8c8d6c
L_8f9b18:
	ld_s r0,[r13,0x10]
L_8f9b1a:
	bl.d L_8e80a4
L_8f9b1e:
	ld_s r0,[r13,0x10]
L_8f9b20:
	b L_8c0254
