/* macq_hw__set_ctrl_bit @ 0x928e38, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mem__addr_of_slot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__set_ctrl_bit
macq_hw__set_ctrl_bit:
	.global L_928e38
L_928e38:
	asl_s r1,r0,0x3
L_928e3a:
	sub_s r1,r1,r0
L_928e3c:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_928e3e:
	add r0,r1,0x44099c3
L_928e46:
	lsr r3,r0,0x3
L_928e4a:
	bic r4,r3,0x3
L_928e4e:
	ld r2,[r4]
L_928e52:
	bmsk_s r0,r0,0x4
L_928e54:
	asl r1,0x1,r0
L_928e5c:
	bic_s r2,r2,r1
L_928e5e:
	or_s r1,r1,r2
L_928e60:
	st r1,[r4]
L_928e64:
	j_s [blink]
L_928e66:
	nop_s
