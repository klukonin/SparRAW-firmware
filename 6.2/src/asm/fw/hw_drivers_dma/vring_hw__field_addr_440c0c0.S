/* vring_hw__field_addr_440c0c0 @ 0x8d0848, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_hw__field_addr_440c0c0
vring_hw__field_addr_440c0c0:
	.global L_8d0848
L_8d0848:
	asl_s r0,r0,0x8
L_8d084a:
	add_s r0,r0,0x440c0c0
L_8d0850:
	lsr_s r0,r0,0x3
L_8d0852:
	bic r0,r0,0x3
L_8d0856:
	ld_s r0,[r0]
L_8d0858:
	j_s [blink]
L_8d085a:
	nop_s
