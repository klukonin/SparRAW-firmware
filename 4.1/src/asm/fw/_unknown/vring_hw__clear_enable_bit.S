/* vring_hw__clear_enable_bit @ 0x8cdf50, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__state_step, vring_schd__disconnect_notify
 */
	.section .text.vring_hw__clear_enable_bit,"ax",@progbits
	.global vring_hw__clear_enable_bit
vring_hw__clear_enable_bit:
	.global L_8cdf50
L_8cdf50:
	mul64 r0,0x380
L_8cdf54:
	add r1,mlo,0x44099c0
L_8cdf5c:
	lsr r2,r1,0x3
L_8cdf60:
	bic r3,r2,0x3
L_8cdf64:
	ld_s r2,[r3]
L_8cdf66:
	bmsk_s r1,r1,0x4
L_8cdf68:
	bclr r2,r2,r1
L_8cdf6c:
	st_s r2,[r3]
L_8cdf6e:
	add r0,mlo,0x44096c4
L_8cdf76:
	lsr r1,r0,0x3
L_8cdf7a:
	bic r2,r1,0x3
L_8cdf7e:
	ld_s r1,[r2]
L_8cdf80:
	bmsk_s r0,r0,0x4
L_8cdf82:
	bclr r1,r1,r0
L_8cdf86:
	st_s r1,[r2]
L_8cdf88:
	j_s [blink]
L_8cdf8a:
	nop_s
