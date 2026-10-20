/* ucode_cmd__rx_on @ 0x935068, 416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_api_cmd_handler.c
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, grant_detect_step, mac__program_rf_mode, mac__set_rf_chain_state, perform_shallow_sleep, rfc_ctrl__switch, rx__set_enable_mask, set_g_80058c, sxd_hal__read_backoff_status, txrx_api_cmd_step, uc_read_tsf_lo
 * Глобалы (через gp): 0x80053c, 0x8005d6
 */
	.section .text.ucode_cmd__rx_on,"ax",@progbits
	.global ucode_cmd__rx_on
ucode_cmd__rx_on:
	.global L_935068
L_935068:
	push_s blink
L_93506a:
	bl L_920210
L_93506e:
	mov_s r14,r0
L_935070:
	ld_s r0,[gp,-0x44]
L_935072:
	and r0,r0,0xffff0fff
L_93507a:
	bset r1,r0,0xd
L_93507e:
	bset_s r1,r1,0xf
L_935080:
	or r0,r0,0x1d00a000
L_935088:
	st.as r1,[gp,-0x11]
L_93508c:
	mov_s r32,r0
L_93508e:
	st.ab r0,[r25,0x4]
L_935092:
	bclr r25,r25,0xa
L_935096:
	nop_s
L_935098:
	nop_s
L_93509a:
	nop_s
L_93509c:
	lsr r15,r40,0x8
L_9350a0:
	bmsk_s r15,r15,0x5
L_9350a2:
	lsr r13,r40,0x10
L_9350a6:
	bmsk_s r13,r13,0x5
L_9350a8:
	mov_s r32,r13
L_9350aa:
	st.ab r13,[r25,0x4]
L_9350ae:
	bclr r25,r25,0xa
L_9350b2:
	mov_s r32,r15
L_9350b4:
	st.ab r15,[r25,0x4]
L_9350b8:
	bclr r25,r25,0xa
L_9350bc:
	brne r15,r13,L_9350f6
	.global L_9350c0
L_9350c0:
	ldw_s r0,[gp,0xae]
L_9350c2:
	brne_s r0,0,L_9350da
L_9350c4:
	bl L_9315e8
L_9350c8:
	ld.as r1,[gp,0x5]
L_9350cc:
	mov_s r2,0x80090c
L_9350d2:
	sub_s r0,r0,r1
L_9350d4:
	ld_s r1,[r2,0x38]
L_9350d6:
	add_s r0,r0,r1
L_9350d8:
	st_s r0,[r2,0x38]
	.global L_9350da
L_9350da:
	ld_s r0,[r14,0x20]
L_9350dc:
	breq_s r0,0,L_93510a
L_9350de:
	breq r0,0x1,L_935134
L_9350e2:
	mov_s r0,blink
L_9350e4:
	mov_s r2,0x1001830
L_9350ea:
	mov_s r1,0x7e
L_9350ec:
	bl.d L_925548
L_9350f0:
	mov r3,0x146
L_9350f4:
	b_s L_935168
	.global L_9350f6
L_9350f6:
	mov_s r0,blink
L_9350f8:
	mov_s r2,0x1001830
L_9350fe:
	mov_s r1,0x7d
L_935100:
	bl.d L_925548
L_935104:
	mov r3,0x11c
L_935108:
	b_s L_9350c0
	.global L_93510a
L_93510a:
	mov_s r0,0x3
L_93510c:
	bl.d L_92b9d0
L_935110:
	mov_s r1,0xff
L_935112:
	mov_s r0,0x0
L_935114:
	st.as r0,[gp,-0x36]
L_935118:
	mov_s r0,0x0
L_93511a:
	bset_s r0,r0,0x1b
L_93511c:
	mov_s r32,r0
L_93511e:
	st.ab r0,[r25,0x4]
L_935122:
	bclr r25,r25,0xa
L_935126:
	mov_s r13,0x1
L_935128:
	bl.d L_9296c8
L_93512c:
	mov_s r0,r13
L_93512e:
	stw.as r13,[gp,0x57]
L_935132:
	b_s L_935168
	.global L_935134
L_935134:
	mov_s r0,0x3
L_935136:
	bl.d L_92b9d0
L_93513a:
	mov_s r1,0xff
L_93513c:
	bl.d L_9296c8
L_935140:
	mov_s r0,0x1
L_935142:
	mov_s r1,0x80087c
L_935148:
	mov_s r0,0x1
L_93514a:
	bl.d L_92b934
L_93514e:
	ld_s r1,[r1]
L_935150:
	st.as 0x924f00,[gp,-0x36]
L_935158:
	mov_s r0,0x0
L_93515a:
	mov_s r1,0x1
L_93515c:
	bl.d L_92a558
L_935160:
	mov_s r2,0x1
L_935162:
	mov_s r0,0x2
L_935164:
	stw.as r0,[gp,0x57]
	.global L_935168
L_935168:
	bl.d L_931ce8
L_93516c:
	mov_s r0,r14
L_93516e:
	mov_s r0,0x8009cc
L_935174:
	ld_s r0,[r0,0x1c]
L_935176:
	brne_s r0,0,L_93518e
L_935178:
	mov_s r0,0x800fcc
L_93517e:
	ldb r0,[r0, 0x68]
L_935182:
	cmp_s r0,0x0
L_935184:
	mov.eq r0,0x20c0011
L_93518c:
	beq_s L_935194
	.global L_93518e
L_93518e:
	mov_s r0,0x20c0001
	.global L_935194
L_935194:
	mov_s r32,r0
L_935196:
	st.ab r0,[r25,0x4]
L_93519a:
	bclr r25,r25,0xa
L_93519e:
	mov_s r0,0x886d00
L_9351a4:
	st 0xc0010,[r0, 0x38]
L_9351ac:
	mov_s r0,0x1ffffff
L_9351b2:
	mov_s r32,r0
L_9351b4:
	st.ab r0,[r25,0x4]
L_9351b8:
	bclr r25,r25,0xa
L_9351bc:
	bl.d L_936d40
L_9351c0:
	mov_s r14,0x0
L_9351c2:
	mov_s r0,0x1
L_9351c4:
	bl.d L_925da8
L_9351c8:
	mov_s r1,r14
L_9351ca:
	bl.d L_921f84
L_9351ce:
	mov_s r0,r14
L_9351d0:
	bl L_9377bc
L_9351d4:
	mov_s r0,0x800fcc
L_9351da:
	ldb r0,[r0, 0x68]
L_9351de:
	mov_s r13,0x800660
L_9351e4:
	breq_s r0,0,L_935200
L_9351e6:
	ld_s r0,[r13]
L_9351e8:
	brne r0,0x1,L_935200
L_9351ec:
	mov_s r0,0x801ed0
L_9351f2:
	mov_s r1,0x1
L_9351f4:
	mov_s r2,r14
L_9351f6:
	mov_s r3,0x1
L_9351f8:
	bl.d L_92af4c
L_9351fc:
	mov r4,0x1
	.global L_935200
L_935200:
	b.d L_92027c
L_935204:
	st_s r14,[r13]
L_935206:
	nop_s
