/* pcie_boot_step_b @ 0x8f1a00, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.pcie_boot_step_b,"ax",@progbits
	.global pcie_boot_step_b
pcie_boot_step_b:
	.global L_8f1a00
L_8f1a00:
	push_s blink
L_8f1a02:
	bl.d L_8c02bc
L_8f1a06:
	mov_s r3,0x18
L_8f1a08:
	mov_s r0,0x855958
L_8f1a0e:
	mov_s r14,0x855800
L_8f1a14:
	st_s r0,[r14,0x50]
L_8f1a16:
	mov_s r0,0x3c
L_8f1a18:
	st_s r0,[r14,0x4c]
L_8f1a1a:
	mov_s r0,0x856498
L_8f1a20:
	st_s r0,[r14,0x60]
L_8f1a22:
	mov_s r0,0x24
L_8f1a24:
	st_s r0,[r14,0x5c]
L_8f1a26:
	mov_s r0,0x856918
L_8f1a2c:
	st_s r0,[r14,0x70]
L_8f1a2e:
	st_s r3,[r14,0x6c]
L_8f1a30:
	mov_s r2,0x856d98
L_8f1a36:
	mov_s r0,r2
L_8f1a38:
	mov_s r1,0x855880
L_8f1a3e:
	st_s r0,[r1]
L_8f1a40:
	mov_s r0,0x14
L_8f1a42:
	st_s r0,[r14,0x7c]
L_8f1a44:
	add r0,r2,0x28
L_8f1a48:
	st_s r0,[r1,0x10]
L_8f1a4a:
	st_s r3,[r1,0xc]
L_8f1a4c:
	mov_s r13,0x0
L_8f1a4e:
	mov_s r15,0x5
	.global L_8f1a50
L_8f1a50:
	asl r16,r13,0x4
L_8f1a54:
	add r0,r14,r16
L_8f1a58:
	mov_s r1,0x8008e8
L_8f1a5e:
	ldb_s r2,[r1,r13]
L_8f1a60:
	st_s r13,[r0,0x48]
L_8f1a62:
	st_s r2,[r0,0x54]
L_8f1a64:
	ld_s r1,[r0,0x4c]
L_8f1a66:
	add r16,r16,r14
L_8f1a6a:
	mulu64 r1,r2
L_8f1a6e:
	mov_s r1,mlo
L_8f1a70:
	bl.d L_8c1a78
L_8f1a74:
	ld_s r0,[r0,0x50]
L_8f1a76:
	mov_s r0,0x855900
L_8f1a7c:
	sub r0,r0,0x100
L_8f1a80:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8f1a82:
	ld r1,[r16, 0x50]
L_8f1a86:
	add2_s r0,r0,r13
L_8f1a88:
	st.as r1,[r0,0x4e]
L_8f1a8c:
	/* brhs.d r15,0x1,0x008f1a50 */
	.byte 0xc5,0x0f,0x75,0x90
L_8f1a90:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f1a92:
	b L_8c0324
L_8f1a96:
	nop_s
L_8f1a98:
	j_s [blink]
L_8f1a9a:
	nop_s
