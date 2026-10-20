/* ut_hw_drivers_cmd_0x507 @ 0x8d0770, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_rfc.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_rfc_write_core
 */
	.section .text.ut_hw_drivers_cmd_0x507,"ax",@progbits
	.global ut_hw_drivers_cmd_0x507
ut_hw_drivers_cmd_0x507:
	.global L_8d0770
L_8d0770:
	push_s blink
L_8d0772:
	bl L_8c02bc
L_8d0776:
	mov_s r16,r0
L_8d0778:
	cmp_s r1,0x7f
L_8d077a:
	mov_s r13,r1
L_8d077c:
	mov_s r14,r2
L_8d077e:
	bgt_s L_8d079a
	.global L_8d0780
L_8d0780:
	brge r14,0x10,L_8d07b0
	.global L_8d0784
L_8d0784:
	bmsk_s r14,r14,0x3
L_8d0786:
	asl_s r2,r14,0x7
L_8d0788:
	bmsk_s r13,r13,0x6
L_8d078a:
	mov_s r0,r16
L_8d078c:
	mov_s r1,0x9
L_8d078e:
	or_s r2,r2,r13
L_8d0790:
	bl.d L_8d0f80
L_8d0794:
	mov_s r3,0x0
L_8d0796:
	b L_8c0324
	.global L_8d079a
L_8d079a:
	mov_s r0,blink
L_8d079c:
	mov_s r2,0x1018f58
L_8d07a2:
	mov_s r1,0x1151
L_8d07a8:
	bl.d L_8c82c0
L_8d07ac:
	mov_s r3,0xd4
L_8d07ae:
	b_s L_8d0780
	.global L_8d07b0
L_8d07b0:
	mov_s r0,blink
L_8d07b2:
	mov_s r2,0x1018f58
L_8d07b8:
	mov_s r1,0x1155
L_8d07be:
	bl.d L_8c82c0
L_8d07c2:
	mov_s r3,0xd5
L_8d07c4:
	b_s L_8d0784
L_8d07c6:
	nop_s
