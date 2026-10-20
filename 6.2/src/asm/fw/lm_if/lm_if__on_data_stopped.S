/* lm_if__on_data_stopped @ 0x8e8014, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm_8027a0__action_8f9ca8
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_sysassert_fatal, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_if__on_data_stopped
lm_if__on_data_stopped:
	.global L_8e8014
L_8e8014:
	push_s blink
L_8e8016:
	bl L_8c01e4
L_8e801a:
	mov_s r13,r0
L_8e801c:
	ld_s r0,[r0]
L_8e801e:
	breq_s r0,0,L_8e8040
	.global L_8e8020
L_8e8020:
	ld_s r0,[r13,0x74]
L_8e8022:
	mov_s r14,0x0
L_8e8024:
	breq_s r0,0,L_8e802c
L_8e8026:
	bl L_8c8de0
L_8e802a:
	st_s r14,[r13,0x74]
	.global L_8e802c
L_8e802c:
	st_s r14,[r13,0x78]
L_8e802e:
	ld_s r0,[r13]
L_8e8030:
	mov_s r1,0x3
L_8e8032:
	mov_s r2,0x0
L_8e8034:
	mov_s r3,r2
L_8e8036:
	bl.d L_8d9b6c
L_8e803a:
	mov_s r4,r2
L_8e803c:
	b L_8c0254
	.global L_8e8040
L_8e8040:
	mov_s r0,blink
L_8e8042:
	mov_s r1,0x1261
L_8e8048:
	bl L_8c9b28
L_8e804c:
	b_s L_8e8020
L_8e804e:
	nop_s
