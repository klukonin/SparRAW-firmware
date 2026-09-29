/* vring_hw__field_addr_440c100 @ 0x8d085c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_hw__field_addr_440c100
vring_hw__field_addr_440c100:
	.global L_8d085c
L_8d085c:
	asl_s r0,r0,0x8
L_8d085e:
	add_s r0,r0,0x440c100
L_8d0864:
	lsr_s r0,r0,0x3
L_8d0866:
	bic r0,r0,0x3
L_8d086a:
	ld_s r0,[r0]
L_8d086c:
	j_s [blink]
L_8d086e:
	nop_s
