/* hwd_dma__get_8812d8 @ 0x8d08a4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_fixed_sched__apply
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__get_8812d8
hwd_dma__get_8812d8:
	.global L_8d08a4
L_8d08a4:
	mov_s r1,r0
L_8d08a6:
	mov_s r0,0x8812d8
L_8d08ac:
	ld_s r2,[r0]
L_8d08ae:
	lsr r0,r2,0x4
L_8d08b2:
	bbit0 r2,0x4,L_8d08bc
L_8d08b6:
	lsr_s r2,r2,0x10
L_8d08b8:
	bmsk_s r2,r2,0x4
L_8d08ba:
	st_s r2,[r1]
	.global L_8d08bc
L_8d08bc:
	j_s.d [blink]
L_8d08be:
	bmsk_s r0,r0,0x0
