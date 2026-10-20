/* hwd_abif__rgf_880800_926b00 @ 0x926b00, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: dma_mac_setup_step
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_abif__rgf_880800_926b00,"ax",@progbits
	.global hwd_abif__rgf_880800_926b00
hwd_abif__rgf_880800_926b00:
	.global L_926b00
L_926b00:
	st.a r13,[sp,-0x8]
L_926b04:
	st_s r14,[sp,0x4]
L_926b06:
	mov_s r14,blink
L_926b08:
	mov.f r13,r0
L_926b0c:
	cmp.ne r13,0x1
L_926b10:
	cmp.ne r13,0x2
L_926b14:
	beq L_926b20
L_926b18:
	breq r13,0x3,L_926b44
L_926b1c:
	brne r13,0x4,L_926b44
	.global L_926b20
L_926b20:
	asl_s r2,r13,0x4
L_926b22:
	mov_s r3,0x880800
L_926b28:
	ld.as r1,[r3,0xfc]
L_926b2c:
	or_s r2,r2,r13
L_926b2e:
	bic r1,r1,0xff
L_926b32:
	extb_s r2,r2
L_926b34:
	or_s r1,r1,r2
L_926b36:
	st.as r1,[r3,0xfc]
L_926b3a:
	mov_s blink,r14
L_926b3c:
	ld_s r14,[sp,0x4]
L_926b3e:
	j_s.d [blink]
L_926b40:
	ld.ab r13,[sp,0x8]
	.global L_926b44
L_926b44:
	mov_s r0,blink
L_926b46:
	mov_s r2,0x10039c8
L_926b4c:
	mov r1,0x12d7
L_926b54:
	bl.d L_925548
L_926b58:
	mov r3,0x75b
L_926b5c:
	b_s L_926b20
L_926b5e:
	nop_s
