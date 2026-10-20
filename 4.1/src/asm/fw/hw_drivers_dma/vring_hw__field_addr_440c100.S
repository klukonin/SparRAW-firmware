/* vring_hw__field_addr_440c100 @ 0x8cdab0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.vring_hw__field_addr_440c100,"ax",@progbits
	.global vring_hw__field_addr_440c100
vring_hw__field_addr_440c100:
	.global L_8cdab0
L_8cdab0:
	asl_s r0,r0,0x8
L_8cdab2:
	add_s r0,r0,0x440c100
L_8cdab8:
	lsr_s r0,r0,0x3
L_8cdaba:
	bic r0,r0,0x3
L_8cdabe:
	ld_s r0,[r0]
L_8cdac0:
	j_s [blink]
L_8cdac2:
	nop_s
