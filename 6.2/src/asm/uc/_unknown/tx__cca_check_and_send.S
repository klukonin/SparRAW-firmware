/* tx__cca_check_and_send @ 0x924d00, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__handle_status_flags, tx_initiator_flow_fixed_scheduling, tx_mtp_queue_gate, tx_sta__flow_loop
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac__cmd_29000001, mac__program_rx_window, mac__select_all_sectors_and_wait, tx__send_and_await_rx_frame
 * Глобалы (через gp): 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx__cca_check_and_send
tx__cca_check_and_send:
	.global L_924d00
L_924d00:
	push_s blink
L_924d02:
	bl L_920230
L_924d06:
	mov_s r13,r0
L_924d08:
	mov_s r14,r1
L_924d0a:
	push_s r3
L_924d0c:
	ld_s r0,[gp,-0x44]
L_924d0e:
	mov_s r15,r2
L_924d10:
	and r0,r0,0xffff0fff
L_924d18:
	bset r1,r0,0xd
L_924d1c:
	bset_s r1,r1,0xf
L_924d1e:
	st.as r1,[gp,-0x11]
L_924d22:
	or r0,r0,0x1d00a000
L_924d2a:
	mov_s r32,r0
L_924d2c:
	st.ab r0,[r25,0x4]
L_924d30:
	bclr r25,r25,0xa
L_924d34:
	bl L_936870
L_924d38:
	bl L_936520
L_924d3c:
	mov_s r1,r40
L_924d3e:
	mov_s r0,r42
L_924d40:
	bbit1 r0,0xe,L_924d48
L_924d44:
	bbit1 r1,0x18,L_924d5a
	.global L_924d48
L_924d48:
	mov_s r0,0x29000002
L_924d4e:
	mov_s r32,r0
L_924d50:
	st.ab r0,[r25,0x4]
L_924d54:
	bclr r25,r25,0xa
L_924d58:
	b_s L_924d7c
	.global L_924d5a
L_924d5a:
	ld_s r3,[r13]
L_924d5c:
	mov_s r0,0x5
L_924d5e:
	/* asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_924d60:
	add2_s r3,r3,r3
L_924d62:
	add_s r3,r3,0x801104
L_924d68:
	ld_s r1,[r3,0x8]
L_924d6a:
	mov_s r2,r14
L_924d6c:
	bl.d L_92f798
L_924d70:
	ld_s r3,[r3,0x10]
L_924d72:
	mov_s r0,r13
L_924d74:
	mov_s r1,r15
L_924d76:
	bl.d L_9249b4
L_924d7a:
	ld_s r2,[sp,0x0]
	.global L_924d7c
L_924d7c:
	ld_s r0,[gp,0xd0]
L_924d7e:
	bset_s r0,r0,0x9
L_924d80:
	st.as r0,[gp,0x34]
L_924d84:
	b.d L_92029c
L_924d88:
	add_s sp,sp,0x4
L_924d8a:
	nop_s
