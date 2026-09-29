/* lm_if__start_link_loss_monitoring @ 0x8e7a7c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if::start_link_loss_monitoring: cid=%d, is_enabled=%d
 * Зовут его: conn_mgr__set_link_maintain_cfg, conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r13_to_r13_ret, bad_beacons_detector__arm, conn__get_cid, fw_log_emit2, ka_necessity_detector__start_monitoring, tx_ppdu_ageing_timeout_detector__start_monitoring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_if__start_link_loss_monitoring
lm_if__start_link_loss_monitoring:
	.global L_8e7a7c
L_8e7a7c:
	b.d L_8e7a84
L_8e7a80:
	add_s r0,r0,0x70
L_8e7a82:
	nop_s
	.global L_8e7a84
L_8e7a84:
	push_s blink
L_8e7a86:
	push_s r13
L_8e7a88:
	bl.d L_8cbed0
L_8e7a8c:
	mov_s r13,r0
L_8e7a8e:
	mov_s r2,r0
L_8e7a90:
	ld_s r3,[r13,0x7c]
L_8e7a92:
	mov_s r1,0x1014338
L_8e7a98:
	sub.f r3,r3,0x0
L_8e7a9c:
	mov.ne r3,0x1
L_8e7aa0:
	bl.d L_8dcc80
L_8e7aa4:
	mov_s r0,0x2b
L_8e7aa6:
	ld_s r0,[r13,0x7c]
L_8e7aa8:
	cmp_s r0,0x0
L_8e7aaa:
	bl.ne L_8e7bc4
L_8e7aae:
	ld_s r0,[r13,0x7c]
L_8e7ab0:
	cmp_s r0,0x0
L_8e7ab2:
	bl.ne.d L_8e7af0
L_8e7ab6:
	add2.ne r0,r0,0x15
L_8e7aba:
	ld_s r0,[r13,0x7c]
L_8e7abc:
	cmp_s r0,0x0
L_8e7abe:
	bl.ne.d L_8e7adc
L_8e7ac2:
	add3.ne r0,r0,0x13
L_8e7ac6:
	b L_8c025c
L_8e7aca:
	nop_s
