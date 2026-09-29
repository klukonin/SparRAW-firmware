/* rfc__write_chain_field @ 0x8d3e58, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__configure_chain
 * Зовёт сам: __ld_r13_to_r13_ret, rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__write_chain_field
rfc__write_chain_field:
	.global L_8d3e58
L_8d3e58:
	push_s blink
L_8d3e5a:
	push_s r13
L_8d3e5c:
	bmsk_s r1,r1,0x0
L_8d3e5e:
	asl_s r2,r2
L_8d3e60:
	and r13,r2,0x2
L_8d3e64:
	bclr_s r1,r1,0x1
L_8d3e66:
	or_s r13,r13,r1
L_8d3e68:
	/* asl_s r3,r3,0x2 */
	.byte 0x02,0xbb
L_8d3e6a:
	and r2,r3,0x4
L_8d3e6e:
	bclr_s r13,r13,0x2
L_8d3e70:
	mov r1,0x4cc
L_8d3e74:
	bl.d L_8d4308
L_8d3e78:
	or_s r2,r2,r13
L_8d3e7a:
	b L_8c025c
L_8d3e7e:
	nop_s
