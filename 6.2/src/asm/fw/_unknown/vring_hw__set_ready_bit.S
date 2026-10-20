/* vring_hw__set_ready_bit @ 0x8d0598, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mem__write_slot, vring_schd__move_to_ready
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_hw__set_ready_bit
vring_hw__set_ready_bit:
	.global L_8d0598
L_8d0598:
	mul64 r0,0x380
L_8d059c:
	add r0,mlo,0x44099c3
L_8d05a4:
	lsr r1,r0,0x3
L_8d05a8:
	bic r3,r1,0x3
L_8d05ac:
	mov_s r1,0x0
L_8d05ae:
	ld_s r2,[r3]
L_8d05b0:
	bmsk_s r0,r0,0x4
L_8d05b2:
	bset r1,r1,r0
L_8d05b6:
	bic_s r2,r2,r1
L_8d05b8:
	or_s r1,r1,r2
L_8d05ba:
	st_s r1,[r3]
L_8d05bc:
	j_s [blink]
L_8d05be:
	nop_s
