/* ba_sm__action_8c3154 @ 0x8c3154, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   addba_rsp_handler.
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8c3154
ba_sm__action_8c3154:
	.global L_8c3154
L_8c3154:
	push_s blink
L_8c3156:
	bl L_8c01e4
L_8c315a:
	mov_s r13,r0
L_8c315c:
	mov_s r14,r1
L_8c315e:
	mov_s r1,0x1013540
L_8c3164:
	bl.d L_8dcba8
L_8c3168:
	mov_s r0,0x2b
L_8c316a:
	add r0,r13,0x8
L_8c316e:
	mov_s r1,0x7
L_8c3170:
	mov_s r2,r14
L_8c3172:
	mov_s r3,0x0
L_8c3174:
	bl.d L_8d9b6c
L_8c3178:
	mov_s r4,r3
L_8c317a:
	b L_8c0254
L_8c317e:
	nop_s
