/* rgf_reg_882600 @ 0x8efd50, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down, pcie__serdes_init
 */
	.section .text.rgf_reg_882600,"ax",@progbits
	.global rgf_reg_882600
rgf_reg_882600:
	.global L_8efd50
L_8efd50:
	push_s r13
L_8efd52:
	mov_s r2,0x882600
L_8efd58:
	ld_s r13,[r2,0x5c]
L_8efd5a:
	asl_s r1,r1,r0
L_8efd5c:
	and r3,r13,0x2
L_8efd60:
	lsr_s r3,r3
L_8efd62:
	bclr r13,r13,r0
L_8efd66:
	or r0,r1,r13
L_8efd6a:
	bclr_s r0,r0,0x0
L_8efd6c:
	or_s r3,r3,r0
L_8efd6e:
	st_s r3,[r2,0x5c]
L_8efd70:
	j_s.d [blink]
L_8efd72:
	pop_s r13
