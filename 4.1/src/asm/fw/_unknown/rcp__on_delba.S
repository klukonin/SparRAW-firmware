/* rcp__on_delba @ 0x8ddd44, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rcp_delba.
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.rcp__on_delba,"ax",@progbits
	.global rcp__on_delba
rcp__on_delba:
L_8ddd44:
	mov_s r4,r3
	.global fwlog_rcp_delba
fwlog_rcp_delba:
L_8ddd46:
	nop_s
L_8ddd48:
	push_s blink
L_8ddd4a:
	bl L_8c02c4
L_8ddd4e:
	mov_s r13,r0
L_8ddd50:
	mov_s r14,r1
L_8ddd52:
	mov_s r2,0x10101b0
L_8ddd58:
	mov_s r0,0xb
L_8ddd5a:
	bl.d L_8edfb0
L_8ddd5e:
	mov_s r1,0x2
L_8ddd60:
	add2 r0,r13,0x1d
L_8ddd64:
	mov_s r1,0x3
L_8ddd66:
	mov_s r2,r14
L_8ddd68:
	mov_s r3,0x0
L_8ddd6a:
	bl.d L_8d6a1c
L_8ddd6e:
	mov_s r4,r3
L_8ddd70:
	b L_8c0334
