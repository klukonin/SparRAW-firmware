/* pcie__apply_880a80_mode @ 0x8ce384, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__apply_mode_flags
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, get_reg8825bc_bit3_inv, hwd_pcie__rgf_880a80_8ce50c, hwd_pcie__rgf_880a80_8cecd0, hwd_pcie__rgf_880a80_8ced78, rgf_reg_880a80_8cee18
 */
	.section .text.pcie__apply_880a80_mode,"ax",@progbits
	.global pcie__apply_880a80_mode
pcie__apply_880a80_mode:
	.global L_8ce384
L_8ce384:
	push_s blink
L_8ce386:
	bl L_8c02c4
L_8ce38a:
	bl.d L_8ce774
L_8ce38e:
	mov_s r13,r0
L_8ce390:
	mov_s r1,0x882580
L_8ce396:
	ld_s r14,[r1,0x40]
L_8ce398:
	brne_s r0,0,L_8ce3cc
L_8ce39a:
	mov_s r0,0x0
L_8ce39c:
	btst_s r14,0x2
L_8ce39e:
	btst.eq r14,0x3
L_8ce3a2:
	mov.ne r0,0x1
L_8ce3a6:
	extb_s r0,r0
L_8ce3a8:
	bl.d L_8cee18
L_8ce3ac:
	and_s r0,r0,r13
L_8ce3ae:
	bmsk r0,r14,0x0
L_8ce3b2:
	bl.d L_8cecd0
L_8ce3b6:
	and_s r0,r0,r13
L_8ce3b8:
	lsr_s r14,r14
L_8ce3ba:
	bmsk_s r14,r14,0x0
L_8ce3bc:
	bl.d L_8ced78
L_8ce3c0:
	and r0,r14,r13
L_8ce3c4:
	bl.d L_8ce50c
L_8ce3c8:
	and r0,r14,r13
	.global L_8ce3cc
L_8ce3cc:
	b L_8c0334
