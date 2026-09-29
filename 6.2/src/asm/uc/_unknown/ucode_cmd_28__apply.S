/* ucode_cmd_28__apply @ 0x935e30, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x28_handler, ucode_cmd_0x2a_handler, ucode_cmd_0x2e_handler, ucode_cmd_0x37_handler, ucode_cmd_0x3c_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, buf__fill_ff, mac__read_tsf64_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_28__apply
ucode_cmd_28__apply:
	.global L_935e30
L_935e30:
	push_s blink
L_935e32:
	bl L_920230
L_935e36:
	mov_s r14,r0
L_935e38:
	mov_s r13,r1
L_935e3a:
	ld_s r1,[r14,0x4]
L_935e3c:
	mov_s r0,0x0
L_935e3e:
	breq_s r1,0,L_935e48
L_935e40:
	ld_s r1,[r14,0x8]
L_935e42:
	cmp_s r1,0x0
L_935e44:
	mov.eq r0,0x1
	.global L_935e48
L_935e48:
	extb.f 0x0,r0
L_935e4c:
	mov_s r15,0x0
L_935e4e:
	mov.ne r0,r15
L_935e52:
	bne_s L_935e70
L_935e54:
	bl.d L_92ecc8
L_935e58:
	mov_s r0,r14
L_935e5a:
	st_s r13,[r14]
L_935e5c:
	mov_s r0,0x2
L_935e5e:
	st_s r0,[r14,0xc]
L_935e60:
	mov_s r13,0x1
L_935e62:
	st_s r13,[r14,0x4]
L_935e64:
	st_s r15,[r14,0x8]
L_935e66:
	bl.d L_9356cc
L_935e6a:
	add r0,r14,0x10
L_935e6e:
	mov_s r0,r13
	.global L_935e70
L_935e70:
	b L_92029c
