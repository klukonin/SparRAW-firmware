/* vendor_ie__write_at_282 @ 0x8e7098, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: build_vendor_ie
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcpy_fw
 */
	.section .text.vendor_ie__write_at_282,"ax",@progbits
	.global vendor_ie__write_at_282
vendor_ie__write_at_282:
	.global L_8e7098
L_8e7098:
	push_s blink
L_8e709a:
	bl L_8c02c0
L_8e709e:
	mov_s r13,r4
L_8e70a0:
	mov_s r14,r0
L_8e70a2:
	add r14,r14,0x11a
L_8e70a6:
	add_s r14,r14,r1
L_8e70a8:
	stb_s r2,[r14]
L_8e70aa:
	lsr_s r2,r2,0x8
L_8e70ac:
	stb_s r2,[r14,0x1]
L_8e70ae:
	mov_s r2,r4
L_8e70b0:
	stb_s r2,[r14,0x2]
L_8e70b2:
	lsr_s r2,r2,0x8
L_8e70b4:
	stb_s r2,[r14,0x3]
L_8e70b6:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8e70b8:
	add r0,r0,0x100
L_8e70bc:
	add_s r0,r0,r1
L_8e70be:
	add_s r0,r0,0x1a
L_8e70c0:
	mov_s r1,r3
L_8e70c2:
	bl.d L_8c0460
L_8e70c6:
	mov_s r2,r4
L_8e70c8:
	add_s r0,r13,0x4
L_8e70ca:
	b.d L_8c032c
L_8e70ce:
	extw_s r0,r0
