/* txss__init_sweep_b @ 0x9363dc, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beamforming_flows_txss.c
 * Зовут его: txss_flow_step_b
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_substate__set, mac__select_sector_and_wait_b, rx_flow__run, sxd_hal__wait_slot2_busy2, uc_sysassert
 * Глобалы (через gp): 0x8005d8, 0x800608
 */
	.section .text.txss__init_sweep_b,"ax",@progbits
	.global txss__init_sweep_b
txss__init_sweep_b:
	.global L_9363dc
L_9363dc:
	push_s blink
L_9363de:
	bl L_920214
L_9363e2:
	mov_s r13,r0
L_9363e4:
	st.as 0x800000,[gp,0x38]
L_9363ec:
	bl.d L_931664
L_9363f0:
	mov_s r0,0x5
L_9363f2:
	b_s L_936406
	.global L_9363f4
L_9363f4:
	mov_s r0,blink
L_9363f6:
	mov_s r2,0x10009b4
L_9363fc:
	mov_s r1,0xe
L_9363fe:
	bl.d L_925548
L_936402:
	mov r3,0x210
	.global L_936406
L_936406:
	bl.d L_931dcc
L_93640a:
	ldw_s r0,[gp,-0x24]
L_93640c:
	ldw.as r1,[gp,0x58]
L_936410:
	mov_s r14,r0
L_936412:
	mov_s r0,0x801a08
L_936418:
	ldw_s r0,[r0]
L_93641a:
	breq r1,r0,L_936446
L_93641e:
	stw.as r0,[gp,0x58]
L_936422:
	or r0,r0,0x1730000
L_93642a:
	mov_s r1,0x886d00
L_936430:
	st_s r0,[r1]
L_936432:
	sync
L_936436:
	mov_s r0,0x38000200
L_93643c:
	mov_s r32,r0
L_93643e:
	st.ab r0,[r25,0x4]
L_936442:
	bclr r25,r25,0xa
	.global L_936446
L_936446:
	mov_s r0,0x0
L_936448:
	cmp_s r14,0x0
L_93644a:
	st.as r0,[gp,-0x7]
L_93644e:
	bl.ne L_92ce9c
L_936452:
	mov_s r0,0x801038
L_936458:
	ld_s r0,[r0]
L_93645a:
	bbit1 r0,0x0,L_936472
L_93645e:
	bbit1 r0,0x3,L_9363f4
L_936462:
	bbit1 r0,0x2,L_93647a
L_936466:
	mov_s r0,r54
L_936468:
	bbit0 r0,0x6,L_936406
L_93646c:
	mov_s r0,r13
L_93646e:
	mov_s r1,0xa
L_936470:
	b_s L_936476
	.global L_936472
L_936472:
	mov_s r0,r13
L_936474:
	mov_s r1,0xb
	.global L_936476
L_936476:
	bl L_930dc4
	.global L_93647a
L_93647a:
	mov_s r0,0x801038
L_936480:
	ld_s r0,[r0]
L_936482:
	lsr_s r0,r0,0x2
L_936484:
	b.d L_920284
L_936488:
	bmsk_s r0,r0,0x0
L_93648a:
	nop_s
