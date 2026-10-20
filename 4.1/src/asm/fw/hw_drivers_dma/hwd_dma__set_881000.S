/* hwd_dma__set_881000 @ 0x8cde50, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.hwd_dma__set_881000,"ax",@progbits
	.global hwd_dma__set_881000
hwd_dma__set_881000:
	.global L_8cde50
L_8cde50:
	push_s blink
L_8cde52:
	bl L_8c02c0
L_8cde56:
	mov_s r15,r0
L_8cde58:
	mov_s r14,r1
L_8cde5a:
	mov_s r13,r2
L_8cde5c:
	mov_s r0,0x881000
L_8cde62:
	st_s r1,[r0,0x2c]
L_8cde64:
	sync
L_8cde68:
	cmp_s r14,0x0
L_8cde6a:
	cmp.ne r13,0x0
L_8cde6e:
	beq_s L_8cdea6
L_8cde70:
	mul64 r15,0x380
L_8cde74:
	mov_s r3,0x0
L_8cde76:
	mov_s r15,0x0
L_8cde78:
	add r0,mlo,0x4409a20
L_8cde80:
	lsr r1,r0,0x3
L_8cde84:
	bmsk_s r0,r0,0x4
L_8cde86:
	add r14,r0,0x1f
L_8cde8a:
	bset r3,r3,r14
L_8cde8e:
	bic r2,r1,0x3
L_8cde92:
	ld_s r1,[r2]
L_8cde94:
	bset r15,r15,r0
L_8cde98:
	sub r14,r3,r15
L_8cde9c:
	or_s r3,r3,r14
L_8cde9e:
	asl_s r13,r13,r0
L_8cdea0:
	bic_s r1,r1,r3
L_8cdea2:
	or_s r13,r13,r1
L_8cdea4:
	st_s r13,[r2]
	.global L_8cdea6
L_8cdea6:
	b L_8c032c
L_8cdeaa:
	nop_s
