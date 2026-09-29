/* lm_if__stop_link_loss_monitoring @ 0x8e2ed0, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if::stop_link_loss_monitoring: cid=%d, is_enabled=%d
 * Зовут его: conn__stop_link_loss_monitoring, lm_if__disable_link_loss_monitoring
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ageing_detector__rearm, bad_beacons_detector__stop_monitoring, fw_log__emit2, ka_detector__rearm, lm_if__get_cid
 */
	.section .text.lm_if__stop_link_loss_monitoring,"ax",@progbits
	.global lm_if__stop_link_loss_monitoring
lm_if__stop_link_loss_monitoring:
	.global L_8e2ed0
L_8e2ed0:
	push_s blink
L_8e2ed2:
	bl L_8c02c4
L_8e2ed6:
	bl.d L_8c9d8c
L_8e2eda:
	mov_s r13,r0
L_8e2edc:
	mov_s r3,r0
L_8e2ede:
	ld_s r14,[r13,0x48]
L_8e2ee0:
	mov_s r2,0x1010ea4
L_8e2ee6:
	sub.f r4,r14,0x0
L_8e2eea:
	mov_s r0,0xb
L_8e2eec:
	mov.ne r4,0x1
L_8e2ef0:
	bl.d L_8edff8
L_8e2ef4:
	mov_s r1,0x2
L_8e2ef6:
	ld_s r0,[r13,0x48]
L_8e2ef8:
	cmp_s r0,0x0
L_8e2efa:
	bl.ne L_8e2fa8
L_8e2efe:
	ld_s r0,[r13,0x48]
L_8e2f00:
	cmp_s r0,0x0
L_8e2f02:
	bl.ne.d L_8e2f8c
L_8e2f06:
	add2.ne r0,r0,0x15
L_8e2f0a:
	ld_s r0,[r13,0x48]
L_8e2f0c:
	cmp_s r0,0x0
L_8e2f0e:
	bl.ne.d L_8e2f70
L_8e2f12:
	add3.ne r0,r0,0x13
L_8e2f16:
	.byte 0x21,0x04
