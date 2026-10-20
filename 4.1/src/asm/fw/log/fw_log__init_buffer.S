/* fw_log__init_buffer @ 0x8edf58, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   log.c
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, memset0_words
 */
	.section .text.fw_log__init_buffer,"ax",@progbits
	.global fw_log__init_buffer
fw_log__init_buffer:
	.global L_8edf58
L_8edf58:
	push_s blink
L_8edf5a:
	bl.d L_8c02c4
L_8edf5e:
	mov_s r0,0x0
L_8edf60:
	mov_s r13,0x843900
L_8edf66:
	st_s r0,[r13]
L_8edf68:
	mov_s r0,0x8008a8
L_8edf6e:
	ld_s r0,[r0]
L_8edf70:
	add_s r14,r13,0x4
L_8edf72:
	breq_s r0,0,L_8edf9e
	.global L_8edf74
L_8edf74:
	mov lp_count,0x10
L_8edf78:
	mov_s r1,0x0
L_8edf7a:
	lp L_8edf86
L_8edf7e:
	mov_s r0,0x7
L_8edf80:
	add_s r12,r14,r1
L_8edf82:
	stb_s r0,[r12]
L_8edf84:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8edf86
L_8edf86:
	add r0,r13,0x14
L_8edf8a:
	mov_s r1,0x0
L_8edf8c:
	bl.d L_8c1a78
L_8edf90:
	bset_s r1,r1,0xc
L_8edf92:
	mov_s r1,r13
L_8edf94:
	mov_s r0,0x11
L_8edf96:
	asl_s r0,r0,0x13
L_8edf98:
	st_s r1,[r0,0x4]
L_8edf9a:
	b L_8c0334
	.global L_8edf9e
L_8edf9e:
	mov_s r0,blink
L_8edfa0:
	mov_s r2,0x1000b2c
L_8edfa6:
	mov_s r1,0xf8
L_8edfa8:
	bl.d L_8c82c0
L_8edfac:
	mov_s r3,0x4c
L_8edfae:
	b_s L_8edf74
