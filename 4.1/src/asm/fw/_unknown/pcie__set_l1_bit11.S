/* pcie__set_l1_bit11 @ 0x8f0c30, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__l1_latency_wa
 */
	.section .text.pcie__set_l1_bit11,"ax",@progbits
	.global pcie__set_l1_bit11
pcie__set_l1_bit11:
	.global L_8f0c30
L_8f0c30:
	ld_s r1,[r0]
L_8f0c32:
	bclr_s r1,r1,0xa
L_8f0c34:
	bclr_s r1,r1,0xb
L_8f0c36:
	bclr_s r1,r1,0x12
L_8f0c38:
	bset_s r1,r1,0xb
L_8f0c3a:
	j_s.d [blink]
L_8f0c3c:
	st_s r1,[r0]
L_8f0c3e:
	nop_s
