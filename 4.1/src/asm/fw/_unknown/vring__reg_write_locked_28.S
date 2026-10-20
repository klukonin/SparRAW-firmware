/* vring__reg_write_locked_28 @ 0x8cd6ac, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pring__isr_dispatch, pring__on_inactivity, sm_pring__bind_vring, sm_pring__eop_evt, sm_pring__state_step, vring_schd__move_to_ready
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.vring__reg_write_locked_28,"ax",@progbits
	.global vring__reg_write_locked_28
vring__reg_write_locked_28:
	.global L_8cd6ac
L_8cd6ac:
	push_s blink
L_8cd6ae:
	push_s r13
L_8cd6b0:
	lr r13,[0xa]
L_8cd6b4:
	bclr r2,r13,0x1
L_8cd6b8:
	flag r2
L_8cd6bc:
	mov_s r2,0x881c00
L_8cd6c2:
	st_s r0,[r2,0x28]
L_8cd6c4:
	breq_s r1,0,L_8cd6ca
L_8cd6c6:
	sync
	.global L_8cd6ca
L_8cd6ca:
	lr r0,[0xa]
L_8cd6ce:
	bic r13,r13,-0x3
L_8cd6d2:
	or_s r13,r13,r0
L_8cd6d4:
	flag r13
L_8cd6d8:
	b L_8c033c
