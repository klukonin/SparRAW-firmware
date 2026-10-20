/* regd__allow_if_not_jp_b @ 0x8d749c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__config_mcs_en_vec
 * Глобалы (через gp): 0x8001fc
 */
	.section .text.regd__allow_if_not_jp_b,"ax",@progbits
	.global regd__allow_if_not_jp_b
regd__allow_if_not_jp_b:
	.global L_8d749c
L_8d749c:
	ld_s r0,[gp,-0xb4]
L_8d749e:
	mov_s r1,0x0
L_8d74a0:
	brne_s r0,0,L_8d74ac
L_8d74a2:
	ldw_s r0,[gp,0x8c]
L_8d74a4:
	brne r0,0x4a50,L_8d74b0
	.global L_8d74ac
L_8d74ac:
	mov_s r0,r1
L_8d74ae:
	b_s L_8d74b2
	.global L_8d74b0
L_8d74b0:
	mov_s r0,0x1
	.global L_8d74b2
L_8d74b2:
	j_s.d [blink]
L_8d74b4:
	extb_s r0,r0
L_8d74b6:
	nop_s
