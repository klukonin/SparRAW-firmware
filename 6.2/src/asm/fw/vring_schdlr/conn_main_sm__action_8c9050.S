/* conn_main_sm__action_8c9050 @ 0x8c9050, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   m_connect_devid = %d, devid = %d
 * Зовут его: wmi_disconnect
 * Зовёт сам: __ld_r15_to_r13_ret, __ld_r17_to_r13_ret, __st_r15_to_r13, __st_r17_to_r13, assoc_ready_check_trig, conn_main_sm__action_step, fw_log_emit2, fw_sysassert_fatal, lmac_if_discovery_mode_cfg_handler, power_mngr__check_mode, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_8c9050
conn_main_sm__action_8c9050:
	.global L_8c9050
L_8c9050:
	push_s blink
L_8c9052:
	bl L_8c01e0
L_8c9056:
	mov_s r13,r0
L_8c9058:
	mov_s r14,r1
L_8c905a:
	ld_s r0,[r0,0x8]
L_8c905c:
	asl r15,r2,0x10
L_8c9060:
	bl.d L_8c3db0
L_8c9064:
	ld_s r0,[r0,0x18]
L_8c9066:
	mov_s r0,L_8f25c8-0x8c0000
L_8c906c:
	ld_s r1,[r13,0x8]
L_8c906e:
	or r2,r15,r14
L_8c9072:
	bl.d L_8c3248
L_8c9076:
	mov_s r3,0x1
L_8c9078:
	ld_s r0,[r13,0x8]
L_8c907a:
	ld_s r1,[r0,0x18]
L_8c907c:
	ld_s r1,[r1,0x50]
L_8c907e:
	mov_s r0,0x0
L_8c9080:
	cmp_s r1,0x2
L_8c9082:
	cmp.ne r1,0x3
L_8c9086:
	mov.eq r0,0x1
L_8c908a:
	extb.f 0x0,r0
L_8c908e:
	bl.eq.d L_8e24e0
L_8c9092:
	mov.eq r0,0x0
L_8c9096:
	b L_8c024c
L_8c909a:
	nop_s
	.global L_8c909c
L_8c909c:
	push_s blink
L_8c909e:
	bl L_8c01d8
L_8c90a2:
	mov_s r13,r0
L_8c90a4:
	mov_s r17,r1
L_8c90a6:
	mov_s r16,r2
L_8c90a8:
	mov_s r14,0x1
L_8c90aa:
	mov_s r0,r14
L_8c90ac:
	bl.d L_8db724
L_8c90b0:
	mov_s r1,0x3
L_8c90b2:
	ld_s r0,[gp,-0x30]
L_8c90b4:
	brne r0,0x1,L_8c90e0
L_8c90b8:
	ld.as r2,[gp,-0x33]
L_8c90bc:
	st.as r14,[gp,-0x1c]
L_8c90c0:
	breq r13,r2,L_8c90ea
L_8c90c4:
	mov_s r1,0x100d634
L_8c90ca:
	mov_s r0,0xb
L_8c90cc:
	bl.d L_8dcc80
L_8c90d0:
	mov_s r3,r13
L_8c90d2:
	mov_s r0,blink
L_8c90d4:
	mov_s r1,0x11d2
L_8c90da:
	bl L_8c9b28
L_8c90de:
	b_s L_8c90ea
	.global L_8c90e0
L_8c90e0:
	mov_s r0,r13
L_8c90e2:
	mov_s r1,r17
L_8c90e4:
	bl.d L_8c9300
L_8c90e8:
	mov_s r2,r16
	.global L_8c90ea
L_8c90ea:
	b L_8c023c
L_8c90ee:
	nop_s
