/* direct_tx__push_payload @ 0x924ef4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   direct_tx.c
 * Зовут его: abft__send_ssw_feedback, direct_tx__send_short_frame, direct_tx_rx_step, direct_tx_step, mac_mode__send_direct_frame, rx__send_response_frame, rx_funcs__send_direct_frame, txss_flow_step
 * Зовёт сам: uc_sysassert
 */
	.section .text.direct_tx__push_payload,"ax",@progbits
	.global direct_tx__push_payload
direct_tx__push_payload:
	.global L_924ef4
L_924ef4:
	st.a r13,[sp,-0xc]
L_924ef8:
	st blink,[sp, 0x4]
L_924efc:
	st_s r14,[sp,0x8]
L_924efe:
	bmsk r2,r0,0x1
L_924f02:
	rsub.f r2,r2,0x1
L_924f06:
	mov.cs r2,0x0
L_924f0a:
	mov_s r13,r0
L_924f0c:
	brne.d r2,0x1,L_924f64
L_924f10:
	mov r14,r1
	.global L_924f14
L_924f14:
	lsr.f r7,r14,0x2
L_924f18:
	bmsk r5,r14,0x1
L_924f1c:
	mov.ne lp_count,r7
L_924f20:
	mov 0x0,0x0
L_924f24:
	lpne L_924f30
L_924f28:
	ld.ab r33,[r13,0x4]
L_924f2c:
	mov 0x0,0x0
	.global L_924f30
L_924f30:
	breq r5,0x0,L_924f4c
L_924f34:
	breq r5,0x1,L_924f48
L_924f38:
	breq r5,0x2,L_924f44
L_924f3c:
	brne r5,0x3,L_924f4c
L_924f40:
	ldb.ab r34,[r13,0x1]
	.global L_924f44
L_924f44:
	ldb.ab r34,[r13,0x1]
	.global L_924f48
L_924f48:
	ldb r34,[r13]
	.global L_924f4c
L_924f4c:
	ld.as r1,[gp,-0x6]
L_924f50:
	ld blink,[sp, 0x4]
L_924f54:
	sub_s r1,r1,r14
L_924f56:
	st.as r1,[gp,-0x6]
L_924f5a:
	ld_s r14,[sp,0x8]
L_924f5c:
	j.d [blink]
L_924f60:
	ld.ab r13,[sp,0xc]
	.global L_924f64
L_924f64:
	mov_s r0,blink
L_924f66:
	mov_s r2,0x1000fb4
L_924f6c:
	mov r1,0x37
L_924f70:
	bl.d L_925548
L_924f74:
	mov r3,0x3f
L_924f78:
	b_s L_924f14
L_924f7a:
	nop_s
