/* vendor_ie__write_at_282 @ 0x8ebcd4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vendor_ie__build_wilocity
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vendor_ie__write_at_282
vendor_ie__write_at_282:
	.global L_8ebcd4
L_8ebcd4:
	push_s blink
L_8ebcd6:
	bl L_8c01e0
L_8ebcda:
	mov_s r13,r4
L_8ebcdc:
	mov_s r14,r0
L_8ebcde:
	add r14,r14,0x11a
L_8ebce2:
	add_s r14,r14,r1
L_8ebce4:
	stb_s r2,[r14]
L_8ebce6:
	lsr_s r2,r2,0x8
L_8ebce8:
	stb_s r2,[r14,0x1]
L_8ebcea:
	mov_s r2,r4
L_8ebcec:
	stb_s r2,[r14,0x2]
L_8ebcee:
	lsr_s r2,r2,0x8
L_8ebcf0:
	stb_s r2,[r14,0x3]
L_8ebcf2:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8ebcf4:
	add r0,r0,0x100
L_8ebcf8:
	add_s r0,r0,r1
L_8ebcfa:
	add_s r0,r0,0x1a
L_8ebcfc:
	mov_s r1,r3
L_8ebcfe:
	bl.d L_8c0380
L_8ebd02:
	mov_s r2,r4
L_8ebd04:
	add_s r0,r13,0x4
L_8ebd06:
	b.d L_8c024c
L_8ebd0a:
	extw_s r0,r0
