/* l2mgr__on_lmac_ready @ 0x8e78b8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt
 * Зовёт сам: l2mgr__init, rf_kill_sm__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__on_lmac_ready
l2mgr__on_lmac_ready:
	.global L_8e78b8
L_8e78b8:
	push_s blink
L_8e78ba:
	bl L_8f55b8
L_8e78be:
	mov_s r0,0x804c34
L_8e78c4:
	bl L_8d8bc0
L_8e78c8:
	pop_s blink
L_8e78ca:
	j_s [blink]
