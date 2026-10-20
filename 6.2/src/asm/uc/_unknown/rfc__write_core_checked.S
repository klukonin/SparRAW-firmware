/* rfc__write_core_checked @ 0x92a5f8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rfc__restore_txrx_sets
 * Зовёт сам: hwd_rfc_write_core, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rfc__write_core_checked
rfc__write_core_checked:
	.global L_92a5f8
L_92a5f8:
	st.a r13,[sp,-0xc]
L_92a5fc:
	st blink,[sp, 0x4]
L_92a600:
	st_s r14,[sp,0x8]
L_92a602:
	mov_s r13,r1
L_92a604:
	cmp r1,0x7fff
L_92a60c:
	bhi.d L_92a630
L_92a610:
	mov r14,r2
	.global L_92a614
L_92a614:
	mov_s r0,0x0
L_92a616:
	mov_s r1,r0
L_92a618:
	mov r2,r13
L_92a61c:
	bl.d L_92a3d8
L_92a620:
	mov r3,r14
L_92a624:
	ld blink,[sp, 0x4]
L_92a628:
	ld_s r14,[sp,0x8]
L_92a62a:
	j_s.d [blink]
L_92a62c:
	ld.ab r13,[sp,0xc]
	.global L_92a630
L_92a630:
	mov_s r0,blink
L_92a632:
	mov_s r1,0x1142
L_92a638:
	bl L_926618
L_92a63c:
	b_s L_92a614
L_92a63e:
	nop_s
