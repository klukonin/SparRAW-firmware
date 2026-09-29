/* direct_tx__build_desc @ 0x92bf38, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: direct_tx_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx__build_desc
direct_tx__build_desc:
	.global L_92bf38
L_92bf38:
	mov r4,0x0
L_92bf3c:
	stw r4,[r1]
L_92bf40:
	ld r8,[r1]
L_92bf44:
	mov_s r2,r4
L_92bf46:
	bic r8,r8,0x3
L_92bf4a:
	ror r8,r8,0x2
L_92bf4e:
	bic r8,r8,0x3
L_92bf52:
	bset r8,r8,0x0
L_92bf56:
	ror r8,r8,0x2
L_92bf5a:
	bic r8,r8,0xf
L_92bf5e:
	or r8,r8,0x6
L_92bf62:
	ror r8,r8,0x4
L_92bf66:
	bic r8,r8,0xf
L_92bf6a:
	or r8,r8,0x9
L_92bf6e:
	ror r8,r8,0x18
L_92bf72:
	st r8,[r1]
L_92bf76:
	ldb r9,[r0, 0x8]
L_92bf7a:
	ldb r7,[r0, 0x9]
L_92bf7e:
	asl r9,r9,0x6
L_92bf82:
	or r7,r7,r9
L_92bf86:
	stb r7,[r1, 0x10]
L_92bf8a:
	ld_s r3,[r0,0x4]
L_92bf8c:
	stb r4,[r1, 0x12]
L_92bf90:
	stb_s r2,[r1,0x13]
L_92bf92:
	lsr_s r2,r2,0x8
L_92bf94:
	stb_s r2,[r1,0x14]
L_92bf96:
	lsr_s r2,r2,0x8
L_92bf98:
	stb_s r2,[r1,0x15]
L_92bf9a:
	lsr_s r2,r2,0x8
L_92bf9c:
	stb_s r2,[r1,0x16]
L_92bf9e:
	stb_s r3,[r1,0x11]
L_92bfa0:
	stb r4,[r1, 0x17]
L_92bfa4:
	ldw r4,[r0, 0x12]
L_92bfa8:
	stw r4,[r1, 0x4]
L_92bfac:
	ldw r5,[r0, 0x14]
L_92bfb0:
	stw r5,[r1, 0x6]
L_92bfb4:
	ldw r6,[r0, 0x16]
L_92bfb8:
	j.d [blink]
L_92bfbc:
	stw r6,[r1, 0x8]
