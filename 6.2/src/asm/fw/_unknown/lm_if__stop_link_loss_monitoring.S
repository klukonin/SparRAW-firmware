/* lm_if__stop_link_loss_monitoring @ 0x8e7fbc, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if::stop_link_loss_monitoring: cid=%d, is_enabled=%d
 * Зовут его: conn_mgr__stop_link_loss_monitoring, lm_if__disable_link_loss_monitoring
 * Зовёт сам: __ld_r13_to_r13_ret, bad_beacons_detector__stop_monitoring, conn__get_cid, fw_log_emit2, lm_if__stop_link_a, lm_if__stop_link_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_if__stop_link_loss_monitoring
lm_if__stop_link_loss_monitoring:
	.global L_8e7fbc
L_8e7fbc:
	push_s blink
L_8e7fbe:
	push_s r13
L_8e7fc0:
	bl.d L_8cbed0
L_8e7fc4:
	mov_s r13,r0
L_8e7fc6:
	mov_s r2,r0
L_8e7fc8:
	ld_s r3,[r13,0x7c]
L_8e7fca:
	mov_s r1,0x10142c4
L_8e7fd0:
	sub.f r3,r3,0x0
L_8e7fd4:
	mov.ne r3,0x1
L_8e7fd8:
	bl.d L_8dcc80
L_8e7fdc:
	mov_s r0,0x2b
L_8e7fde:
	ld_s r0,[r13,0x7c]
L_8e7fe0:
	cmp_s r0,0x0
L_8e7fe2:
	bl.ne L_8e8088
L_8e7fe6:
	ld_s r0,[r13,0x7c]
L_8e7fe8:
	cmp_s r0,0x0
L_8e7fea:
	bl.ne.d L_8e806c
L_8e7fee:
	add2.ne r0,r0,0x15
L_8e7ff2:
	ld_s r0,[r13,0x7c]
L_8e7ff4:
	cmp_s r0,0x0
L_8e7ff6:
	bl.ne.d L_8e8050
L_8e7ffa:
	add3.ne r0,r0,0x13
L_8e7ffe:
	b L_8c025c
L_8e8002:
	nop_s
