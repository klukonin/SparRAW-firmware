/* set_reg_886f00_928d78 @ 0x928d78, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_pending__clear_bit
 * Зовёт сам: mac__publish_masks
 */
	.section .text.set_reg_886f00_928d78,"ax",@progbits
	.global set_reg_886f00_928d78
set_reg_886f00_928d78:
	.global L_928d78
L_928d78:
	ld_s r0,[gp,-0x74]
L_928d7a:
	mov_s r1,0x886f00
L_928d80:
	bclr_s r0,r0,0x7
L_928d82:
	st.as r0,[gp,-0x1d]
L_928d86:
	ld_s r0,[gp,-0x58]
L_928d88:
	bmsk_s r0,r0,0x1e
L_928d8a:
	st.as r0,[gp,-0x16]
L_928d8e:
	st_s r0,[r1,0x5c]
L_928d90:
	b L_9373b0
