/* sysassert__dump_ucode_stack @ 0x8c8264, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UCODE Stack dump beginning at 0x%x:
 *   				0x%08x
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1
 */
	.section .text.sysassert__dump_ucode_stack,"ax",@progbits
	.global sysassert__dump_ucode_stack
sysassert__dump_ucode_stack:
	.global L_8c8264
L_8c8264:
	push_s blink
L_8c8266:
	bl.d L_8c02c0
L_8c826a:
	mov_s r1,0x2
L_8c826c:
	mov_s r0,0x886f00
L_8c8272:
	ld_s r13,[r0,0x4c]
L_8c8274:
	mov_s r15,0x944000
L_8c827a:
	add_s r13,r13,0x130000
L_8c8280:
	add_s r13,r13,0x10000
L_8c8286:
	mov_s r2,0x100142c
L_8c828c:
	mov_s r14,0x0
L_8c828e:
	mov_s r0,r14
L_8c8290:
	bl.d L_8edfcc
L_8c8294:
	mov_s r3,r13
L_8c8296:
	b_s L_8c82ac
	.global L_8c8298
L_8c8298:
	ld.ab r3,[r13,0x4]
L_8c829c:
	mov_s r2,0x1001420
L_8c82a2:
	mov_s r0,0x0
L_8c82a4:
	bl.d L_8edfcc
L_8c82a8:
	mov_s r1,0x2
L_8c82aa:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8c82ac
L_8c82ac:
	mov_s r0,0x800474
L_8c82b2:
	ld_s r0,[r0]
L_8c82b4:
	brhs r14,r0,L_8c82bc
L_8c82b8:
	brlo r13,r15,L_8c8298
	.global L_8c82bc
L_8c82bc:
	b L_8c032c
