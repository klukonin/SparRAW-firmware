/* sw_vring__ba_agreed @ 0x8c4120, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sw_vring::ba_agreed. win_size:%d, msdu_max_size: %d macq:%d
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, ba_sm__build_addba_params, conn__sec_mode_not_1, fw_log_emit3, hwd_dma__set_ring_field_99e0, rx_chain__configure, rx_chain__get_cfg_mode, rx_chain__get_cfg_word, rx_macq__entry_addr, send_ba_status_report, sw_vring__ba_params
 * Глобалы (через gp): 0x8002a8, 0x800424
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sw_vring__ba_agreed
sw_vring__ba_agreed:
	.global L_8c4120
L_8c4120:
	j_s.d [blink]
L_8c4122:
	ld_s r0,[gp,0x2a0]
L_8c4124:
	push_s blink
L_8c4126:
	bl L_8c01d4
L_8c412a:
	mov_s r13,r0
L_8c412c:
	mov_s r16,r1
L_8c412e:
	mov_s r18,r2
L_8c4130:
	mov_s r15,r3
L_8c4132:
	bl.d L_8ccfd8
L_8c4136:
	ldb_s r0,[r0,0x5]
L_8c4138:
	bl.d L_8eabc8
L_8c413c:
	mov_s r14,r0
L_8c413e:
	mov_s r1,0x1010fb0
L_8c4144:
	ldb r4,[r13, 0x5]
L_8c4148:
	mov_s r0,0x27
L_8c414a:
	mov_s r2,r16
L_8c414c:
	bl.d L_8dcd00
L_8c4150:
	ldw_s r3,[r14,0x6]
L_8c4152:
	mov_s r0,0x0
L_8c4154:
	bl.d L_8d0a80
L_8c4158:
	asr r1,r16,0x3
L_8c415c:
	ld_s r0,[r13]
L_8c415e:
	bl.d L_8da5f8
L_8c4162:
	ldb r17,[r0, 0x8]
L_8c4166:
	mov_s r5,r0
L_8c4168:
	mov_s r0,r14
L_8c416a:
	mov_s r1,0x6
L_8c416c:
	ldb_s r2,[r13,0x4]
L_8c416e:
	mov_s r3,r16
L_8c4170:
	bl.d L_8ea62c
L_8c4174:
	mov r4,r17
L_8c4178:
	bl L_8cd080
L_8c417c:
	ld_s r1,[r0]
L_8c417e:
	ld_s r2,[r1,0x18]
L_8c4180:
	jl_s.d [r2]
L_8c4182:
	ldb_s r1,[r13,0x7]
L_8c4184:
	extb r5,r15
L_8c4188:
	mov_s r0,r13
L_8c418a:
	ldb_s r1,[r13,0x7]
L_8c418c:
	mov_s r2,0x0
L_8c418e:
	mov_s r3,r16
L_8c4190:
	bl.d L_8e5174
L_8c4194:
	mov r4,r18
L_8c4198:
	ld_s r0,[gp,0x124]
L_8c419a:
	brne_s r0,0,L_8c41c8
L_8c419c:
	bl.d L_8ccb68
L_8c41a0:
	mov_s r0,0x2
L_8c41a2:
	bl.d L_8ccec4
L_8c41a6:
	mov_s r16,r0
L_8c41a8:
	bl.d L_8cceb4
L_8c41ac:
	mov_s r15,r0
L_8c41ae:
	mov_s r14,r0
L_8c41b0:
	extw r4,r0
L_8c41b4:
	ldb_s r1,[r13,0x4]
L_8c41b6:
	extb_s r3,r15
L_8c41b8:
	mov_s r0,r16
L_8c41ba:
	bl.d L_8c44bc
L_8c41be:
	mov_s r2,0x0
L_8c41c0:
	mov_s r0,0x2
L_8c41c2:
	bl.d L_8e4094
L_8c41c6:
	mov_s r1,r14
	.global L_8c41c8
L_8c41c8:
	b L_8c0234
