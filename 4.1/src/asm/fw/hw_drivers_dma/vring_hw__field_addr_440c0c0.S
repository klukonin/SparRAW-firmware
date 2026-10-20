/* vring_hw__field_addr_440c0c0 @ 0x8cda9c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.vring_hw__field_addr_440c0c0,"ax",@progbits
	.global vring_hw__field_addr_440c0c0
vring_hw__field_addr_440c0c0:
	.global L_8cda9c
L_8cda9c:
	asl_s r0,r0,0x8
L_8cda9e:
	add_s r0,r0,0x440c0c0
L_8cdaa4:
	lsr_s r0,r0,0x3
L_8cdaa6:
	bic r0,r0,0x3
L_8cdaaa:
	ld_s r0,[r0]
L_8cdaac:
	j_s [blink]
L_8cdaae:
	nop_s
