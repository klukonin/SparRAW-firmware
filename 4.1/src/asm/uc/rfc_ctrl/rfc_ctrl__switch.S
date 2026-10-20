/* rfc_ctrl__switch @ 0x92b9d0, 252 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rfc_ctrl.c
 * Зовут его: bi_tx_initiator_wrap, cf_end__tx_flow, rx_flow__handle_frame, rx_flow__run, rx_funcs__rx_flow, rx_rfc_step, shallow_sleep_rfc_step, ucode_cmd__rx_on, ucode_pm__rx_off_step
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, hwd_phy__rgf_883000_92749c, hwd_phy__set_883000_92748c, rate_search__current_mcs_b, rfc__issue_cmd_20, uc_sysassert
 * Глобалы (через gp): 0x800540, 0x800550, 0x8005c0
 */
	.section .text.rfc_ctrl__switch,"ax",@progbits
	.global rfc_ctrl__switch
rfc_ctrl__switch:
	.global L_92b9d0
L_92b9d0:
	push_s blink
L_92b9d2:
	bl L_920210
L_92b9d6:
	sub_s sp,sp,0x4
L_92b9d8:
	mov_s r14,r1
L_92b9da:
	mov_s r13,0x801660
L_92b9e0:
	mov_s r1,0x8016c0
L_92b9e6:
	ldb_s r3,[r1,0x14]
L_92b9e8:
	sub3 r2,r1,0xc
L_92b9ec:
	add_s r12,r2,r3
L_92b9ee:
	stb r0,[r12, 0x64]
L_92b9f2:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_92b9f4:
	bmsk_s r3,r3,0x3
L_92b9f6:
	stb_s r3,[r1,0x14]
L_92b9f8:
	mov_s r1,0xff
L_92b9fa:
	add_s r2,r2,r3
L_92b9fc:
	stb r1,[r2, 0x64]
L_92ba00:
	mov_s r15,0x0
L_92ba02:
	cmp_s r0,0x2
L_92ba04:
	cmp.ne r0,0x3
L_92ba08:
	mov.eq r15,0x1
L_92ba0c:
	ld_s r0,[r13,0x54]
L_92ba0e:
	bl.d L_92748c
L_92ba12:
	ld_s r1,[r13,0x58]
L_92ba14:
	ld_s r1,[r13,0x54]
L_92ba16:
	ldb_s r0,[gp,0x28]
L_92ba18:
	extb_s r15,r15
L_92ba1a:
	add_s r0,r0,r1
L_92ba1c:
	cmp_s r0,0x3f
L_92ba1e:
	bl.d L_92749c
L_92ba22:
	mov.cc r0,0x3f
L_92ba26:
	breq_s r15,0,L_92ba60
L_92ba28:
	mov_s r0,0x800a50
L_92ba2e:
	ldb.x r15,[r0, 0x1e]
L_92ba32:
	mov_s r0,0x857280
L_92ba38:
	ld_s r13,[r0,0x14]
L_92ba3a:
	ld_s r0,[gp,0x18]
L_92ba3c:
	mov_s r14,0x80087c
L_92ba42:
	or r0,r0,0x3
L_92ba46:
	st.as r0,[gp,0x6]
L_92ba4a:
	ld_s r0,[r14]
L_92ba4c:
	lsr r1,r0,0x8
L_92ba50:
	bmsk_s r1,r1,0xe
L_92ba52:
	bl.d L_92bc40
L_92ba56:
	bmsk_s r0,r0,0x3
L_92ba58:
	ld_s r0,[r14]
L_92ba5a:
	st.as r0,[gp,-0xc]
L_92ba5e:
	b_s L_92baba
	.global L_92ba60
L_92ba60:
	brhs r14,0x8,L_92ba7c
	.global L_92ba64
L_92ba64:
	mov_s r0,0x800a6f
L_92ba6a:
	ldb.x r15,[r0,r14]
L_92ba6e:
	bl.d L_92c1c8
L_92ba72:
	mov_s r0,r14
L_92ba74:
	brlt r0,0x9,L_92ba92
L_92ba78:
	mov_s r13,0x0
L_92ba7a:
	b_s L_92ba9a
	.global L_92ba7c
L_92ba7c:
	mov_s r0,blink
L_92ba7e:
	mov_s r2,0x10015c4
L_92ba84:
	mov_s r1,0x12f0
L_92ba8a:
	bl.d L_925548
L_92ba8e:
	mov_s r3,0xad
L_92ba90:
	b_s L_92ba64
	.global L_92ba92
L_92ba92:
	mov_s r0,0x857280
L_92ba98:
	ld_s r13,[r0,0x14]
	.global L_92ba9a
L_92ba9a:
	ld_s r0,[gp,0x18]
L_92ba9c:
	/* asl_s r14,r14,0x3 */
	.byte 0x03,0xbe
L_92ba9e:
	bic r0,r0,0x3
L_92baa2:
	st.as r0,[gp,0x6]
L_92baa6:
	mov_s r0,0x801194
L_92baac:
	add3_s r14,r14,r14
L_92baae:
	ld_s r1,[r0,r14]
L_92bab0:
	mov_s r0,0x801a18
L_92bab6:
	ld_s r0,[r0,0x60]
L_92bab8:
	st_s r1,[r0,0x28]
	.global L_92baba
L_92baba:
	ld.as r2,[gp,0x26]
L_92babe:
	mov_s r0,r15
L_92bac0:
	jl_s.d [r2]
L_92bac2:
	mov_s r1,r13
L_92bac4:
	b.d L_92027c
L_92bac8:
	add_s sp,sp,0x4
L_92baca:
	nop_s
