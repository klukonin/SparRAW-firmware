/* rx_macq__program_ba_win @ 0x8e37fc, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__setup
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, macq_desc__write, rx_macq__build_ba_desc
 * Глобалы (через gp): 0x8002a8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__program_ba_win
rx_macq__program_ba_win:
	.global L_8e37fc
L_8e37fc:
	push_s blink
L_8e37fe:
	bl L_8c01dc
L_8e3802:
	mov_s r14,r0
L_8e3804:
	mov_s r16,r1
L_8e3806:
	ldb_s r1,[r0]
L_8e3808:
	mov_s r13,r5
L_8e380a:
	st.a r1,[sp,-0xc]
L_8e380e:
	ld_s r0,[gp,0x124]
L_8e3810:
	stw r3,[sp, 0x6]
L_8e3814:
	stw r2,[sp, 0x4]
L_8e3818:
	stw r4,[sp, 0x8]
L_8e381c:
	breq_s r0,0,L_8e3822
L_8e381e:
	cmp_s r13,0x40
L_8e3820:
	bgt_s L_8e3854
	.global L_8e3822
L_8e3822:
	stw r13,[sp, 0xa]
L_8e3826:
	stw_s r13,[r14,0x2]
L_8e3828:
	mov_s r13,0x847fc8
L_8e382e:
	mov_s r2,sp
L_8e3830:
	mov_s r0,r13
L_8e3832:
	mov_s r1,r16
L_8e3834:
	bl.d L_8e4448
L_8e3838:
	ldb_s r3,[r14,0x1]
L_8e383a:
	mov_s r0,r13
L_8e383c:
	ldb_s r1,[r14]
L_8e383e:
	mov_s r2,0x1
L_8e3840:
	mov_s r3,0x0
L_8e3842:
	mov_s r4,r3
L_8e3844:
	mov_s r5,r3
L_8e3846:
	mov_s r6,r3
L_8e3848:
	bl.d L_8c5010
L_8e384c:
	mov_s r7,r2
L_8e384e:
	b.d L_8c0244
L_8e3852:
	add_s sp,sp,0xc
	.global L_8e3854
L_8e3854:
	mov_s r0,blink
L_8e3856:
	mov_s r1,0x1276
L_8e385c:
	bl L_8c9b28
L_8e3860:
	b_s L_8e3822
L_8e3862:
	nop_s
