/* pcie__l1ss_enable @ 0x8d17a0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sparrow PCIe L1SS Support enabled
 * Зовут его: pcie__serdes_program_all
 * Зовёт сам: fw_log_emit0, hwd_pcie__is_ep_under_serdes
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__l1ss_enable
pcie__l1ss_enable:
	.global L_8d17a0
L_8d17a0:
	push_s blink
L_8d17a2:
	mov_s r1,0x101dbd0
L_8d17a8:
	bl.d L_8dcba8
L_8d17ac:
	mov_s r0,0x21
L_8d17ae:
	bl L_8d1470
L_8d17b2:
	mov_s r2,0x88b080
L_8d17b8:
	cmp_s r0,0x0
L_8d17ba:
	ld_s r0,[r2,0x38]
L_8d17bc:
	mov_s r1,0x88b000
L_8d17c2:
	bset.eq r0,r0,0xd
L_8d17c6:
	bset.eq r0,r0,0x14
L_8d17ca:
	bset.ne r0,r0,0x10
L_8d17ce:
	bset.ne r0,r0,0x17
L_8d17d2:
	st_s r0,[r2,0x38]
L_8d17d4:
	ld_s r0,[r1,0x60]
L_8d17d6:
	bclr_s r0,r0,0x0
L_8d17d8:
	st_s r0,[r1,0x60]
L_8d17da:
	ld_s r0,[r1,0x2c]
L_8d17dc:
	bclr_s r0,r0,0x0
L_8d17de:
	st_s r0,[r1,0x2c]
L_8d17e0:
	ld_s r0,[r2,0x30]
L_8d17e2:
	mov_s r1,0x882200
L_8d17e8:
	bclr_s r0,r0,0x0
L_8d17ea:
	st_s r0,[r2,0x30]
L_8d17ec:
	ld_s r0,[r1,0x40]
L_8d17ee:
	bset_s r0,r0,0x11
L_8d17f0:
	st_s r0,[r1,0x40]
L_8d17f2:
	pop_s blink
L_8d17f4:
	j_s [blink]
L_8d17f6:
	nop_s
