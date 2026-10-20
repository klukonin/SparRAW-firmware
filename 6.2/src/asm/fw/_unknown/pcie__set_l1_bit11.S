/* pcie__set_l1_bit11 @ 0x8f8f50, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__l1_latency_wa
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__set_l1_bit11
pcie__set_l1_bit11:
	.global L_8f8f50
L_8f8f50:
	ld_s r1,[r0]
L_8f8f52:
	bclr_s r1,r1,0xa
L_8f8f54:
	bclr_s r1,r1,0xb
L_8f8f56:
	bclr_s r1,r1,0x12
L_8f8f58:
	bset_s r1,r1,0xb
L_8f8f5a:
	j_s.d [blink]
L_8f8f5c:
	st_s r1,[r0]
L_8f8f5e:
	nop_s
