/* vring_hw__set_ready_bit @ 0x8cd70c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_rgf_block_program, vring_schd__move_to_ready
 */
	.section .text.vring_hw__set_ready_bit,"ax",@progbits
	.global vring_hw__set_ready_bit
vring_hw__set_ready_bit:
	.global L_8cd70c
L_8cd70c:
	mul64 r0,0x380
L_8cd710:
	add r0,mlo,0x44099c3
L_8cd718:
	lsr r1,r0,0x3
L_8cd71c:
	bic r3,r1,0x3
L_8cd720:
	mov_s r1,0x0
L_8cd722:
	ld_s r2,[r3]
L_8cd724:
	bmsk_s r0,r0,0x4
L_8cd726:
	bset r1,r1,r0
L_8cd72a:
	bic_s r2,r2,r1
L_8cd72c:
	or_s r1,r1,r2
L_8cd72e:
	st_s r1,[r3]
L_8cd730:
	j_s [blink]
L_8cd732:
	nop_s
