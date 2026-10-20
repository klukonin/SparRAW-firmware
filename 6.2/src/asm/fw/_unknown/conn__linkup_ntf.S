/* conn__linkup_ntf @ 0x8dae44, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn::linkup_ntf status=%d
 * Зовут его: lm__notify_linkup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__linkup_ntf
conn__linkup_ntf:
	.global L_8dae44
L_8dae44:
	push_s blink
L_8dae46:
	bl L_8c01e4
L_8dae4a:
	mov_s r14,r0
L_8dae4c:
	mov_s r13,r1
L_8dae4e:
	mov_s r1,0x1010348
L_8dae54:
	mov_s r0,0x2d
L_8dae56:
	bl.d L_8dcc10
L_8dae5a:
	mov_s r2,r13
L_8dae5c:
	mov_s r0,r14
L_8dae5e:
	add r0,r0,0x124
L_8dae62:
	mov_s r1,0x2
L_8dae64:
	mov_s r2,r13
L_8dae66:
	mov_s r3,0x0
L_8dae68:
	bl.d L_8d9b6c
L_8dae6c:
	mov_s r4,r3
L_8dae6e:
	b L_8c0254
L_8dae72:
	nop_s
