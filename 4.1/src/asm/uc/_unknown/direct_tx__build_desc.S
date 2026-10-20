/* direct_tx__build_desc @ 0x92902c, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: direct_tx_step
 */
	.section .text.direct_tx__build_desc,"ax",@progbits
	.global direct_tx__build_desc
direct_tx__build_desc:
	.global L_92902c
L_92902c:
	mov r4,0x0
L_929030:
	stw r4,[r1]
L_929034:
	ld r8,[r1]
L_929038:
	mov_s r2,r4
L_92903a:
	bic r8,r8,0x3
L_92903e:
	ror r8,r8,0x2
L_929042:
	bic r8,r8,0x3
L_929046:
	bset r8,r8,0x0
L_92904a:
	ror r8,r8,0x2
L_92904e:
	bic r8,r8,0xf
L_929052:
	or r8,r8,0x6
L_929056:
	ror r8,r8,0x4
L_92905a:
	bic r8,r8,0xf
L_92905e:
	or r8,r8,0x9
L_929062:
	ror r8,r8,0x18
L_929066:
	st r8,[r1]
L_92906a:
	ldb r9,[r0, 0x8]
L_92906e:
	ldb r7,[r0, 0x9]
L_929072:
	asl r9,r9,0x6
L_929076:
	or r7,r7,r9
L_92907a:
	stb r7,[r1, 0x10]
L_92907e:
	ld_s r3,[r0,0x4]
L_929080:
	stb r4,[r1, 0x12]
L_929084:
	stb_s r2,[r1,0x13]
L_929086:
	lsr_s r2,r2,0x8
L_929088:
	stb_s r2,[r1,0x14]
L_92908a:
	lsr_s r2,r2,0x8
L_92908c:
	stb_s r2,[r1,0x15]
L_92908e:
	lsr_s r2,r2,0x8
L_929090:
	stb_s r2,[r1,0x16]
L_929092:
	stb_s r3,[r1,0x11]
L_929094:
	stb r4,[r1, 0x17]
L_929098:
	ldw r4,[r0, 0x12]
L_92909c:
	stw r4,[r1, 0x4]
L_9290a0:
	ldw r5,[r0, 0x14]
L_9290a4:
	stw r5,[r1, 0x6]
L_9290a8:
	ldw r6,[r0, 0x16]
L_9290ac:
	j.d [blink]
L_9290b0:
	stw r6,[r1, 0x8]
