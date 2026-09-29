/* uc_read_tsf64 @ 0x930cb0, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__tsf_delta64, bi_timing_snapshot_b, bi_window_timing_update, get_selected_rf_sector_index_cmd_handler, perform_shallow_sleep, set_g_80058c, uc_pm__enter_idle, uc_send_event
 */
	.section .text.uc_read_tsf64,"ax",@progbits
	.global uc_read_tsf64
uc_read_tsf64:
	.global L_930cb0
L_930cb0:
	st.a r13,[sp,-0x8]
L_930cb4:
	st_s r14,[sp,0x4]
L_930cb6:
	mov_s r14,blink
L_930cb8:
	ld.as r1,[gp,-0x11]
L_930cbc:
	mov_s r13,r0
L_930cbe:
	and r1,r1,0xffff0fff
L_930cc6:
	or r0,r1,0x5000
L_930cce:
	st.as r0,[gp,-0x11]
L_930cd2:
	or r1,r1,0x1d005000
L_930cda:
	mov_s r32,r1
L_930cdc:
	st.ab r1,[r25,0x4]
L_930ce0:
	bclr r25,r25,0xa
L_930ce4:
	nop_s
L_930ce6:
	nop_s
L_930ce8:
	nop_s
L_930cea:
	st r40,[r13]
L_930cee:
	ld.as r3,[gp,-0x11]
L_930cf2:
	and r3,r3,0xffff0fff
L_930cfa:
	or r2,r3,0x6000
L_930d02:
	or r3,r3,0x1d006000
L_930d0a:
	st.as r2,[gp,-0x11]
L_930d0e:
	mov_s r32,r3
L_930d10:
	st.ab r3,[r25,0x4]
L_930d14:
	bclr r25,r25,0xa
L_930d18:
	nop_s
L_930d1a:
	nop_s
L_930d1c:
	nop_s
L_930d1e:
	st r40,[r13, 0x4]
L_930d22:
	mov_s blink,r14
L_930d24:
	ld_s r14,[sp,0x4]
L_930d26:
	j_s.d [blink]
L_930d28:
	ld.ab r13,[sp,0x8]
