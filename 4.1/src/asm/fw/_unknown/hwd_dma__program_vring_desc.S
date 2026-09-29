/* hwd_dma__program_vring_desc @ 0x8cdfac, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__add_vring
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_dma__set_881c80
 */
	.section .text.hwd_dma__program_vring_desc,"ax",@progbits
	.global hwd_dma__program_vring_desc
hwd_dma__program_vring_desc:
	.global L_8cdfac
L_8cdfac:
	push_s blink
L_8cdfae:
	bl L_8c02c4
L_8cdfb2:
	mov_s r13,r3
L_8cdfb4:
	asl r14,r0,0x8
L_8cdfb8:
	add r0,r14,0x440c160
L_8cdfc0:
	lsr_s r0,r0,0x3
L_8cdfc2:
	bic r0,r0,0x3
L_8cdfc6:
	st_s r1,[r0]
L_8cdfc8:
	bl.d L_8c7e64
L_8cdfcc:
	mov_s r0,r2
L_8cdfce:
	add r4,r14,0x440c1a0
L_8cdfd6:
	lsr r4,r4,0x3
L_8cdfda:
	bic r0,r4,0x3
L_8cdfde:
	st_s r13,[r0]
L_8cdfe0:
	b L_8c0334
