/* sysassert__dump_ucode_stack @ 0x8c9ad0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UCODE Stack dump beginning at 0x%x:
 *     %08x: %08x
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sysassert__dump_ucode_stack
sysassert__dump_ucode_stack:
	.global L_8c9ad0
L_8c9ad0:
	push_s blink
L_8c9ad2:
	bl L_8c01e4
L_8c9ad6:
	mov_s r0,0x886f00
L_8c9adc:
	ld_s r13,[r0,0x4c]
L_8c9ade:
	mov_s r14,0x944000
L_8c9ae4:
	add_s r13,r13,0x130000
L_8c9aea:
	add_s r13,r13,0x10000
L_8c9af0:
	mov_s r1,0x100141c
L_8c9af6:
	mov_s r0,0x20
L_8c9af8:
	bl.d L_8dcc10
L_8c9afc:
	mov_s r2,r13
L_8c9afe:
	b_s L_8c9b20
	.global L_8c9b00
L_8c9b00:
	ld_s r3,[r13]
L_8c9b02:
	cmp r3,0x160
L_8c9b06:
	blo_s L_8c9b1e
L_8c9b08:
	brlo 0x20000,r3,L_8c9b1e
L_8c9b10:
	mov_s r1,0x100140c
L_8c9b16:
	mov_s r0,0x20
L_8c9b18:
	bl.d L_8dcc80
L_8c9b1c:
	mov_s r2,r13
	.global L_8c9b1e
L_8c9b1e:
	/* add_s r13,0x4 */
	.byte 0x04,0xe5
	.global L_8c9b20
L_8c9b20:
	brlo r13,r14,L_8c9b00
L_8c9b24:
	b L_8c0254
