/* rgf_reg_881800 @ 0x926c54, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_initiator_step
 */
	.section .text.rgf_reg_881800,"ax",@progbits
	.global rgf_reg_881800
rgf_reg_881800:
	.global L_926c54
L_926c54:
	mov_s r1,0x881800
L_926c5a:
	ld.as r0,[r1,0xc9]
L_926c5e:
	bclr_s r0,r0,0x1
L_926c60:
	st.as r0,[r1,0xc9]
L_926c64:
	j_s [blink]
L_926c66:
	nop_s
