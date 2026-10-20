/* pcie__program_880a80_seq @ 0x8ce3d0, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, get_reg8825bc_bit3_inv, hwd_pcie__rgf_880a80_8ce50c, hwd_pcie__rgf_880a80_8cecd0, hwd_pcie__rgf_880a80_8ced78, rgf_reg_880a80_8cee18
 */
	.section .text.pcie__program_880a80_seq,"ax",@progbits
	.global pcie__program_880a80_seq
pcie__program_880a80_seq:
	.global L_8ce3d0
L_8ce3d0:
	push_s blink
L_8ce3d2:
	bl L_8c02c4
L_8ce3d6:
	bl.d L_8ce774
L_8ce3da:
	mov_s r14,r0
L_8ce3dc:
	mov_s r1,0x882580
L_8ce3e2:
	ld_s r13,[r1,0x40]
L_8ce3e4:
	breq_s r0,0,L_8ce3fa
L_8ce3e6:
	bl.d L_8cecd0
L_8ce3ea:
	mov_s r0,r14
L_8ce3ec:
	bl.d L_8ced78
L_8ce3f0:
	mov_s r0,r14
L_8ce3f2:
	bl.d L_8cee18
L_8ce3f6:
	mov_s r0,r14
L_8ce3f8:
	b_s L_8ce432
	.global L_8ce3fa
L_8ce3fa:
	mov_s r0,0x0
L_8ce3fc:
	btst_s r13,0x2
L_8ce3fe:
	btst.eq r13,0x3
L_8ce402:
	mov.eq r0,0x1
L_8ce406:
	extb_s r0,r0
L_8ce408:
	bl.d L_8cee18
L_8ce40c:
	and_s r0,r0,r14
L_8ce40e:
	bxor r0,r13,0x0
L_8ce412:
	bmsk_s r0,r0,0x0
L_8ce414:
	bl.d L_8cecd0
L_8ce418:
	and_s r0,r0,r14
L_8ce41a:
	lsr_s r13,r13
L_8ce41c:
	bxor r13,r13,0x0
L_8ce420:
	bmsk_s r13,r13,0x0
L_8ce422:
	bl.d L_8ced78
L_8ce426:
	and r0,r13,r14
L_8ce42a:
	bl.d L_8ce50c
L_8ce42e:
	and r0,r13,r14
	.global L_8ce432
L_8ce432:
	b L_8c0334
L_8ce436:
	nop_s
