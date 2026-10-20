/* tx_desc__build_b @ 0x8e4b54, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_dma_if__push_desc
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bf_w_s16_w5, memset0_words
 */
	.section .text.tx_desc__build_b,"ax",@progbits
	.global tx_desc__build_b
tx_desc__build_b:
	.global L_8e4b54
L_8e4b54:
	push_s blink
L_8e4b56:
	bl L_8c02b4
L_8e4b5a:
	mov_s r14,r0
L_8e4b5c:
	mov_s r13,r1
L_8e4b5e:
	mov_s r15,r2
L_8e4b60:
	mov_s r16,r3
L_8e4b62:
	mov r17,r4
L_8e4b66:
	mov r18,r5
L_8e4b6a:
	bl.d L_8c1a78
L_8e4b6e:
	mov_s r1,0x20
L_8e4b70:
	stw r17,[r14, 0x1e]
L_8e4b74:
	ld_s r0,[r14,0x10]
L_8e4b76:
	stb r18,[r14, 0x8]
L_8e4b7a:
	bic r0,r0,0x700
L_8e4b7e:
	or r0,r0,0x300
L_8e4b82:
	bmsk_s r15,r15,0x0
L_8e4b84:
	asl_s r15,r15,0xa
L_8e4b86:
	or_s r15,r15,r0
L_8e4b88:
	bmsk r1,r13,0x4
L_8e4b8c:
	add r0,r14,0x10
L_8e4b90:
	bl.d L_8e83d8
L_8e4b94:
	st_s r15,[r14,0x10]
L_8e4b96:
	bmsk r0,r16,0x11
L_8e4b9a:
	b.d L_8c0314
L_8e4b9e:
	st_s r0,[r14,0x14]
