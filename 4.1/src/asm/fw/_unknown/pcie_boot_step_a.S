/* pcie_boot_step_a @ 0x8f1964, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.pcie_boot_step_a,"ax",@progbits
	.global pcie_boot_step_a
pcie_boot_step_a:
	.global L_8f1964
L_8f1964:
	push_s blink
L_8f1966:
	bl.d L_8c02bc
L_8f196a:
	mov_s r0,0x8
L_8f196c:
	mov_s r14,0x855800
L_8f1972:
	st_s r0,[r14,0x44]
L_8f1974:
	mov_s r0,r14
L_8f1976:
	bl.d L_8c1a78
L_8f197a:
	mov_s r1,0x40
L_8f197c:
	st 0x3050813,[r14, 0x40]
L_8f1984:
	st 0x3050813,[r14]
L_8f198c:
	mov_s r2,0x856df0
L_8f1992:
	mov_s r0,r2
L_8f1994:
	mov_s r1,0x855880
L_8f199a:
	st_s r0,[r1,0x20]
L_8f199c:
	mov_s r0,0xc
L_8f199e:
	st_s r0,[r1,0x1c]
L_8f19a0:
	add r0,r2,0x18
L_8f19a4:
	st_s r0,[r1,0x30]
L_8f19a6:
	mov_s r0,0x14
L_8f19a8:
	st_s r0,[r1,0x2c]
L_8f19aa:
	add3 r0,r2,0x8
L_8f19ae:
	st_s r0,[r1,0x40]
L_8f19b0:
	mov_s r0,0x10
L_8f19b2:
	st_s r0,[r1,0x3c]
L_8f19b4:
	mov_s r13,0x5
L_8f19b6:
	mov_s r15,0x3
	.global L_8f19b8
L_8f19b8:
	asl r16,r13,0x4
L_8f19bc:
	add r0,r14,r16
L_8f19c0:
	mov_s r1,0x8008e8
L_8f19c6:
	ldb_s r2,[r1,r13]
L_8f19c8:
	st_s r13,[r0,0x48]
L_8f19ca:
	st_s r2,[r0,0x54]
L_8f19cc:
	ld_s r1,[r0,0x4c]
L_8f19ce:
	add r16,r16,r14
L_8f19d2:
	mulu64 r1,r2
L_8f19d6:
	mov_s r1,mlo
L_8f19d8:
	bl.d L_8c1a78
L_8f19dc:
	ld_s r0,[r0,0x50]
L_8f19de:
	mov_s r0,0x855900
L_8f19e4:
	sub r0,r0,0x100
L_8f19e8:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8f19ea:
	ld r1,[r16, 0x50]
L_8f19ee:
	add2_s r0,r0,r13
L_8f19f0:
	st.as r1,[r0,0x4e]
L_8f19f4:
	/* brhs.d r15,0x1,0x008f19b8 */
	.byte 0xc5,0x0f,0x75,0x90
L_8f19f8:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f19fa:
	b L_8c0324
L_8f19fe:
	nop_s
