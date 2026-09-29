/* fw_sysassert__stack_dump @ 0x8c9a88, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Stack dump %08x-%08x
 *     %08x: %08x
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysassert__stack_dump
fw_sysassert__stack_dump:
	.global L_8c9a88
L_8c9a88:
	push_s blink
L_8c9a8a:
	bl.d L_8c01e4
L_8c9a8e:
	mov_s r0,0x20
L_8c9a90:
	mov_s r14,0x807ffc
L_8c9a96:
	mov_s r1,0x10013f4
L_8c9a9c:
	mov_s r2,sp
L_8c9a9e:
	bl.d L_8dcc80
L_8c9aa2:
	mov_s r3,r14
L_8c9aa4:
	mov_s r13,sp
L_8c9aa6:
	b_s L_8c9ac8
	.global L_8c9aa8
L_8c9aa8:
	ld_s r3,[r13]
L_8c9aaa:
	cmp r3,0x160
L_8c9aae:
	blo_s L_8c9ac6
L_8c9ab0:
	brlo 0x40000,r3,L_8c9ac6
L_8c9ab8:
	mov_s r1,0x100140c
L_8c9abe:
	mov_s r0,0x20
L_8c9ac0:
	bl.d L_8dcc80
L_8c9ac4:
	mov_s r2,r13
	.global L_8c9ac6
L_8c9ac6:
	/* add_s r13,0x4 */
	.byte 0x04,0xe5
	.global L_8c9ac8
L_8c9ac8:
	brlo r13,r14,L_8c9aa8
L_8c9acc:
	b L_8c0254
