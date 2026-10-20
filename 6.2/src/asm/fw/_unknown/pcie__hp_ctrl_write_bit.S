/* pcie__hp_ctrl_write_bit @ 0x8f8094, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__hp_ctrl_write_bit
pcie__hp_ctrl_write_bit:
	.global L_8f8094
L_8f8094:
	push_s r13
L_8f8096:
	mov_s r2,0x882600
L_8f809c:
	ld_s r13,[r2,0x5c]
L_8f809e:
	asl_s r1,r1,r0
L_8f80a0:
	and r3,r13,0x2
L_8f80a4:
	lsr_s r3,r3
L_8f80a6:
	bclr r13,r13,r0
L_8f80aa:
	or r0,r1,r13
L_8f80ae:
	bclr_s r0,r0,0x0
L_8f80b0:
	or_s r3,r3,r0
L_8f80b2:
	st_s r3,[r2,0x5c]
L_8f80b4:
	j_s.d [blink]
L_8f80b6:
	pop_s r13
