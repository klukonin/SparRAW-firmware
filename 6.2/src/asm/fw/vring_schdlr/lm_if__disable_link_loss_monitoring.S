/* lm_if__disable_link_loss_monitoring @ 0x8c8f90, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if::disable_link_loss_monitoring: cid=%d, is_enabled=%d
 * Зовут его: conn__abort, conn__disconnect
 * Зовёт сам: __ld_r13_to_r13_ret, conn__get_cid, fw_log_emit2, lm_if__stop_link_loss_monitoring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_if__disable_link_loss_monitoring
lm_if__disable_link_loss_monitoring:
	.global L_8c8f90
L_8c8f90:
	push_s blink
L_8c8f92:
	push_s r13
L_8c8f94:
	bl.d L_8cbed0
L_8c8f98:
	mov_s r13,r0
L_8c8f9a:
	mov_s r2,r0
L_8c8f9c:
	ld_s r3,[r13,0x7c]
L_8c8f9e:
	mov_s r1,0x10142fc
L_8c8fa4:
	sub.f r3,r3,0x0
L_8c8fa8:
	mov.ne r3,0x1
L_8c8fac:
	bl.d L_8dcc80
L_8c8fb0:
	mov_s r0,0x2b
L_8c8fb2:
	bl.d L_8e7fbc
L_8c8fb6:
	mov_s r0,r13
L_8c8fb8:
	mov_s r0,0x0
L_8c8fba:
	b.d L_8c025c
L_8c8fbe:
	st_s r0,[r13,0x7c]
