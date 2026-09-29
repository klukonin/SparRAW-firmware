/* lm_if__disable_link_loss_monitoring @ 0x8c7950, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if::disable_link_loss_monitoring: cid=%d, is_enabled=%d
 * Зовут его: conn__abort, conn__disconnect
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, lm_if__get_cid, lm_if__stop_link_loss_monitoring
 */
	.section .text.lm_if__disable_link_loss_monitoring,"ax",@progbits
	.global lm_if__disable_link_loss_monitoring
lm_if__disable_link_loss_monitoring:
	.global L_8c7950
L_8c7950:
	push_s blink
L_8c7952:
	bl L_8c02c4
L_8c7956:
	bl.d L_8c9d8c
L_8c795a:
	mov_s r13,r0
L_8c795c:
	mov_s r3,r0
L_8c795e:
	ld_s r14,[r13,0x48]
L_8c7960:
	mov_s r2,0x1010edc
L_8c7966:
	sub.f r4,r14,0x0
L_8c796a:
	mov_s r0,0xb
L_8c796c:
	mov.ne r4,0x1
L_8c7970:
	bl.d L_8edff8
L_8c7974:
	mov_s r1,0x2
L_8c7976:
	bl.d L_8e2ed0
L_8c797a:
	mov_s r0,r13
L_8c797c:
	mov_s r0,0x0
L_8c797e:
	b.d L_8c0334
L_8c7982:
	st_s r0,[r13,0x48]
