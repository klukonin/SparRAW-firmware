/* hwf_vga_dc__measure @ 0x8d6ad4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_vga_dc__calibrate
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_phy__rx_cal_corr, hwd_phy__rx_cal_corr_config
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_vga_dc__measure
hwf_vga_dc__measure:
	.global L_8d6ad4
L_8d6ad4:
	push_s blink
L_8d6ad6:
	bl.d L_8c01e4
L_8d6ada:
	mov_s r2,0x0
L_8d6adc:
	sub_s sp,sp,0x8
L_8d6ade:
	mov_s r14,r0
L_8d6ae0:
	mov_s r13,r1
L_8d6ae2:
	mov_s r0,0x0
L_8d6ae4:
	bset r0,r0,r1
L_8d6ae8:
	bl.d L_8d2418
L_8d6aec:
	mov_s r1,0x1
L_8d6aee:
	bl.d L_8d23a0
L_8d6af2:
	mov_s r0,sp
L_8d6af4:
	breq_s r14,0,L_8d6afa
L_8d6af6:
	ld_s r1,[sp,0x4]
L_8d6af8:
	b_s L_8d6afc
	.global L_8d6afa
L_8d6afa:
	ld_s r1,[sp,0x0]
	.global L_8d6afc
L_8d6afc:
	sub_s r2,r13,0x1
L_8d6afe:
	mov_s r0,0x0
L_8d6b00:
	bset r0,r0,r2
L_8d6b04:
	cmp_s r1,0x0
L_8d6b06:
	add.ge r0,r0,r1
L_8d6b0a:
	asr.ge r0,r0,r13
L_8d6b0e:
	bge_s L_8d6b16
L_8d6b10:
	sub_s r0,r0,r1
L_8d6b12:
	asr_s r0,r0,r13
L_8d6b14:
	neg_s r0,r0
	.global L_8d6b16
L_8d6b16:
	sexb_s r0,r0
L_8d6b18:
	b.d L_8c0254
L_8d6b1c:
	add_s sp,sp,0x8
L_8d6b1e:
	nop_s
