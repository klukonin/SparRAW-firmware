/* find_main_sm__first_detection @ 0x8f2ee0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::first_detection()
 * Зовут его: find_mngr__detect_discovery_bcon
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, find_main_sm__bcon_step, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_main_sm__first_detection
find_main_sm__first_detection:
	.global L_8f2ee0
L_8f2ee0:
	push_s blink
L_8f2ee2:
	bl L_8c01e4
L_8f2ee6:
	mov_s r13,r0
L_8f2ee8:
	mov_s r14,r1
L_8f2eea:
	mov_s r1,0x1017b50
L_8f2ef0:
	bl.d L_8dcba8
L_8f2ef4:
	mov_s r0,0x2c
L_8f2ef6:
	add r0,r13,0x18
L_8f2efa:
	bl.d L_8f8574
L_8f2efe:
	mov_s r1,r14
L_8f2f00:
	cmp_s r0,0x0
L_8f2f02:
	mov_s r0,0x1
L_8f2f04:
	b.d L_8c0254
L_8f2f08:
	sub_s.ne r0,r0,r0
L_8f2f0a:
	nop_s
