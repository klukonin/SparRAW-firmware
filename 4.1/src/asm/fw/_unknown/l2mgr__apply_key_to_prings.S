/* l2mgr__apply_key_to_prings @ 0x8f28b4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__key_evt
 * Зовёт сам: __ld_r13_ret, conn_sm__inject_event, stream_mgr__foreach_pring_of_owner
 */
	.section .text.l2mgr__apply_key_to_prings,"ax",@progbits
	.global l2mgr__apply_key_to_prings
l2mgr__apply_key_to_prings:
	.global L_8f28b4
L_8f28b4:
	push_s blink
L_8f28b6:
	push_s r13
L_8f28b8:
	mov_s r13,r0
L_8f28ba:
	bl.d L_8e5484
L_8f28be:
	mov_s r1,0x0
L_8f28c0:
	mov_s r0,r13
L_8f28c2:
	mov_s r1,0x5
L_8f28c4:
	mov_s r2,0x0
L_8f28c6:
	mov_s r3,0x0
L_8f28c8:
	bl.d L_8d6b78
L_8f28cc:
	mov r4,0x0
L_8f28d0:
	b L_8c033c
