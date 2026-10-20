/* hwd_rfc__read_xpm_with_delay @ 0x8d06b0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: xpm_read_cnt
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_rfc__write_xpm_cmd, hwd_rfc_read_rgf
 */
	.section .text.hwd_rfc__read_xpm_with_delay,"ax",@progbits
	.global hwd_rfc__read_xpm_with_delay
hwd_rfc__read_xpm_with_delay:
	.global L_8d06b0
L_8d06b0:
	push_s blink
L_8d06b2:
	bl L_8c02bc
L_8d06b6:
	mov_s r13,r0
L_8d06b8:
	bl.d L_8d0438
L_8d06bc:
	mov_s r16,r2
L_8d06be:
	mov r0,0x140
L_8d06c2:
	mov lp_count,r0
L_8d06c6:
	nop_s
L_8d06c8:
	lp L_8d06d0
L_8d06cc:
	nop_s
L_8d06ce:
	nop_s
	.global L_8d06d0
L_8d06d0:
	extb_s r0,r13
L_8d06d2:
	bl.d L_8d04fc
L_8d06d6:
	mov r1,0x3d0
L_8d06da:
	mov_s r1,r0
L_8d06dc:
	bic r1,r1,-0x401
L_8d06e0:
	cmp_s r1,0x0
L_8d06e2:
	mov_s r1,0x1
L_8d06e4:
	sub_s.ne r1,r1,r1
L_8d06e6:
	extb.f 0x0,r1
L_8d06ea:
	extb_s r1,r0
L_8d06ec:
	st r1,[r16]
L_8d06f0:
	mov_s r1,0x0
L_8d06f2:
	btst.ne r0,0x8
L_8d06f6:
	mov.eq r0,r1
L_8d06fa:
	mov.ne r0,0x1
L_8d06fe:
	b.d L_8c0324
L_8d0702:
	extb_s r0,r0
