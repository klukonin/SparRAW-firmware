/* l2mgr__on_lmac_ready @ 0x8e2668, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt
 * Зовёт сам: l2mgr__init, rf_kill_sm__init
 */
	.section .text.l2mgr__on_lmac_ready,"ax",@progbits
	.global l2mgr__on_lmac_ready
l2mgr__on_lmac_ready:
	.global L_8e2668
L_8e2668:
	push_s blink
L_8e266a:
	bl L_8ed398
L_8e266e:
	mov_s r0,0x8043d4
L_8e2674:
	bl L_8ecf84
L_8e2678:
	pop_s blink
L_8e267a:
	j_s [blink]
