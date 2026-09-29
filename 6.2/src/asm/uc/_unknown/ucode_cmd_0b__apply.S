/* ucode_cmd_0b__apply @ 0x92b198, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x0b_handler, ucode_cmd_0x0c_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcpy_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0b__apply
ucode_cmd_0b__apply:
	.global L_92b198
L_92b198:
	push_s blink
L_92b19a:
	bl L_920230
L_92b19e:
	mov_s r14,r0
L_92b1a0:
	ld_s r0,[r0]
L_92b1a2:
	mov_s r15,r1
L_92b1a4:
	breq r0,0x1,L_92b1d4
L_92b1a8:
	ld_s r0,[r14,0x4]
L_92b1aa:
	ldb r13,[r15, 0x48]
L_92b1ae:
	brne r0,0x1,L_92b1ba
L_92b1b2:
	ldb r0,[r14, 0x48]
L_92b1b6:
	min r13,r13,r0
	.global L_92b1ba
L_92b1ba:
	add r0,r14,0x8
L_92b1be:
	add r1,r15,0x8
L_92b1c2:
	bl.d L_920330
L_92b1c6:
	mov_s r2,0x40
L_92b1c8:
	ldb r0,[r15, 0x49]
L_92b1cc:
	stb r13,[r14, 0x48]
L_92b1d0:
	stb r0,[r14, 0x49]
	.global L_92b1d4
L_92b1d4:
	b L_92029c
