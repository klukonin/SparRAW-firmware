/* check_rf_boardfile @ 0x8f19b8, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *         Identify RF Platform is wrong : UNKOWN !!
 *         Identify RF Platform is OK:    Board file & HW are MR.
 *         Identify RF Platform is wrong : Board file is MR and RF HW is FR !!
 *   check_rf_boardfile : Mismatch !!! (RF_ERROR)
 *         Identify RF Platform is OK:    Board file & HW are FR.
 *         Identify RF Platform is wrong : Board file is FR and RF HW is MR !!
 * Зовут его: rf__identify_type
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_sysassert_fatal, rf__type_is_marlon, rf__type_is_sparrow_r, rf_boardfile__read_platform_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global check_rf_boardfile
check_rf_boardfile:
	.global L_8f19b8
L_8f19b8:
	push_s blink
L_8f19ba:
	bl L_8c01e4
L_8f19be:
	sub_s sp,sp,0x4
L_8f19c0:
	mov_s r14,r0
L_8f19c2:
	mov_s r1,sp
L_8f19c4:
	mov_s r13,0x0
L_8f19c6:
	mov_s r2,r13
L_8f19c8:
	bl.d L_8f3478
L_8f19cc:
	mov_s r3,r13
L_8f19ce:
	ld_s r0,[r14,0x58]
L_8f19d0:
	breq_s r0,0,L_8f1a02
L_8f19d2:
	ld_s r0,[sp,0x0]
L_8f19d4:
	breq_s r0,0,L_8f19e2
L_8f19d6:
	breq r0,0x1,L_8f1a30
L_8f19da:
	mov_s r1,0x100502c
L_8f19e0:
	b_s L_8f19fc
	.global L_8f19e2
L_8f19e2:
	bl L_8da594
L_8f19e6:
	breq_s r0,0,L_8f19f6
L_8f19e8:
	mov_s r1,0x100505c
	.global L_8f19ee
L_8f19ee:
	bl.d L_8dcba8
L_8f19f2:
	mov_s r0,0x20
L_8f19f4:
	b_s L_8f1a04
	.global L_8f19f6
L_8f19f6:
	mov_s r1,0x100509c
	.global L_8f19fc
L_8f19fc:
	bl.d L_8dcba8
L_8f1a00:
	mov_s r0,r13
	.global L_8f1a02
L_8f1a02:
	mov_s r13,0x1
	.global L_8f1a04
L_8f1a04:
	breq_s r13,0,L_8f1a2a
L_8f1a06:
	mov_s r1,0x2
L_8f1a08:
	mov_s r0,0x880a3c
L_8f1a0e:
	st_s r1,[r0,0x2c]
L_8f1a10:
	mov_s r0,0xa
L_8f1a12:
	stb_s r0,[r14]
L_8f1a14:
	mov_s r1,0x10050e8
L_8f1a1a:
	bl.d L_8dcba8
L_8f1a1e:
	mov_s r0,0x0
L_8f1a20:
	mov_s r0,blink
L_8f1a22:
	mov_s r1,0x48
L_8f1a24:
	bl.d L_8c9b28
L_8f1a28:
	bset_s r1,r1,0xc
	.global L_8f1a2a
L_8f1a2a:
	b.d L_8c0254
L_8f1a2e:
	add_s sp,sp,0x4
	.global L_8f1a30
L_8f1a30:
	bl L_8da584
L_8f1a34:
	breq_s r0,0,L_8f1a3e
L_8f1a36:
	mov_s r1,0x1005118
L_8f1a3c:
	b_s L_8f19ee
	.global L_8f1a3e
L_8f1a3e:
	mov_s r1,0x1005158
L_8f1a44:
	b_s L_8f19fc
L_8f1a46:
	nop_s
