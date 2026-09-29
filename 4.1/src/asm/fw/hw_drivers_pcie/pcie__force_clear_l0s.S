/* pcie__force_clear_l0s @ 0x8ce7d8, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE: EP under Serdes: LnkCtl: Chk L0s configuration(0x%x)!!!
 *   PCIE: EP under Serdes: LnkCtl: L0s is Enabled - ForceClear (0x%x)!!!
 * Зовут его: pcie__serdes_init
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, get_reg8825bc_bit3_inv, hwd_pcie_dbi_write, hwd_pcie_exit_l1, pcie_serdes_step
 */
	.section .text.pcie__force_clear_l0s,"ax",@progbits
	.global pcie__force_clear_l0s
pcie__force_clear_l0s:
	.global L_8ce7d8
L_8ce7d8:
	push_s blink
L_8ce7da:
	push_s r13
L_8ce7dc:
	mov_s r1,0x882000
L_8ce7e2:
	ld_s r0,[r1,0x28]
L_8ce7e4:
	sub_s sp,sp,0x8
L_8ce7e6:
	bset_s r0,r0,0x12
L_8ce7e8:
	st_s r0,[r1,0x28]
L_8ce7ea:
	bl.d L_8ce774
L_8ce7ee:
	mov_s r13,0x0
L_8ce7f0:
	breq_s r0,0,L_8ce856
L_8ce7f2:
	bl.d L_8ce578
L_8ce7f6:
	mov_s r0,0x1
L_8ce7f8:
	add r6,sp,0x4
L_8ce7fc:
	mov_s r0,0x80
L_8ce7fe:
	mov_s r1,r13
L_8ce800:
	mov_s r2,0x1
L_8ce802:
	mov_s r3,r13
L_8ce804:
	mov_s r4,r13
L_8ce806:
	bl.d L_8eaa64
L_8ce80a:
	mov r5,0x1
L_8ce80e:
	mov_s r2,0x1018a9c
L_8ce814:
	mov_s r0,0x1
L_8ce816:
	mov_s r1,0x2
L_8ce818:
	bl.d L_8edfcc
L_8ce81c:
	ld_s r3,[sp,0x4]
L_8ce81e:
	ld_s r3,[sp,0x4]
L_8ce820:
	bbit0 r3,0x0,L_8ce850
L_8ce824:
	mov_s r2,0x1018adc
L_8ce82a:
	mov_s r0,0x1
L_8ce82c:
	bl.d L_8edfcc
L_8ce830:
	mov_s r1,r13
L_8ce832:
	ld_s r1,[sp,0x4]
L_8ce834:
	st_s r13,[sp,0x0]
L_8ce836:
	bclr_s r1,r1,0x0
L_8ce838:
	st_s r1,[sp,0x4]
L_8ce83a:
	mov_s r0,0x80
L_8ce83c:
	mov_s r2,r13
L_8ce83e:
	mov_s r3,0x1
L_8ce840:
	mov_s r4,r13
L_8ce842:
	mov_s r5,r13
L_8ce844:
	mov r6,0x1
L_8ce848:
	bl.d L_8eab94
L_8ce84c:
	mov r7,0x1
	.global L_8ce850
L_8ce850:
	bl.d L_8ce578
L_8ce854:
	mov_s r0,0x0
	.global L_8ce856
L_8ce856:
	b.d L_8c033c
L_8ce85a:
	add_s sp,sp,0x8
