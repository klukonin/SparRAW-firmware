/* fsched__tx_ctrl_frame @ 0x934b14, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched_ap__start_slot
 * Зовёт сам: __ld_r13_to_r13_ret, direct_tx__send_ctrl_frame, fsched__get_cur_idx, get_mem_857744_x2_928308, gp0__arm_usec_b, mac__arm_events_0xc00, uc_spin_until_event, uc_wait_one_event
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__tx_ctrl_frame
fsched__tx_ctrl_frame:
	.global L_934b14
L_934b14:
	push_s blink
L_934b16:
	push_s r13
L_934b18:
	sub_s sp,sp,0xc
L_934b1a:
	bl.d L_928384
L_934b1e:
	mov_s r0,0x20
L_934b20:
	mov_s r13,0x801be8
L_934b26:
	bl.d L_928308
L_934b2a:
	mov_s r0,r13
L_934b2c:
	stw r0,[sp]
L_934b30:
	bl.d L_927d54
L_934b34:
	mov_s r0,r13
L_934b36:
	stb r0,[sp, 0x2]
L_934b3a:
	mov_s r0,0x1
L_934b3c:
	stb r0,[sp, 0x9]
L_934b40:
	st_s r0,[sp,0x4]
L_934b42:
	mov_s r13,0x0
L_934b44:
	stb_s r13,[sp,0x8]
L_934b46:
	bl.d L_9362b8
L_934b4a:
	mov_s r0,sp
L_934b4c:
	cmp_s r0,0x0
L_934b4e:
	mov.eq r0,r13
L_934b52:
	beq_s L_934b84
L_934b54:
	mov_s r0,0x0
L_934b56:
	bl.d L_9366dc
L_934b5a:
	bset_s r0,r0,0xf
L_934b5c:
	bl.d L_936588
L_934b60:
	mov_s r0,0x6
L_934b62:
	ld_s r0,[gp,0x178]
L_934b64:
	mov_s r1,0x802944
L_934b6a:
	bclr_s r0,r0,0x18
L_934b6c:
	ld_s r1,[r1]
L_934b6e:
	bclr_s r0,r0,0x19
L_934b70:
	asl_s r1,r1,0x18
L_934b72:
	or_s r0,r0,r1
L_934b74:
	st.as r0,[gp,0x5e]
L_934b78:
	mov_s r1,0x889480
L_934b7e:
	st_s r0,[r1,0x8]
L_934b80:
	bl L_93e084
	.global L_934b84
L_934b84:
	b.d L_9202ac
L_934b88:
	add_s sp,sp,0xc
L_934b8a:
	nop_s
