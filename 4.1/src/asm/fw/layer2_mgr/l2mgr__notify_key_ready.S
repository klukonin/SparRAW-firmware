/* l2mgr__notify_key_ready @ 0x8ed5d4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__key_evt, low_sme__send_evt2sw
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, mid__conn_state_ne_1, stream_mgr__foreach_pring_of_owner
 */
	.section .text.l2mgr__notify_key_ready,"ax",@progbits
	.global l2mgr__notify_key_ready
l2mgr__notify_key_ready:
	.global L_8ed5d4
L_8ed5d4:
	push_s blink
L_8ed5d6:
	push_s r13
L_8ed5d8:
	mov_s r13,r0
L_8ed5da:
	add r0,r0,0xfc
L_8ed5de:
	mov_s r1,0x7
L_8ed5e0:
	mov_s r2,0x0
L_8ed5e2:
	mov_s r3,r2
L_8ed5e4:
	bl.d L_8d6a1c
L_8ed5e8:
	mov_s r4,r2
L_8ed5ea:
	bl.d L_8ed820
L_8ed5ee:
	mov_s r0,r13
L_8ed5f0:
	mov_s r1,r0
L_8ed5f2:
	bl.d L_8e5484
L_8ed5f6:
	mov_s r0,r13
L_8ed5f8:
	b L_8c033c
