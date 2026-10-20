/* uc_sta_trace__push_record @ 0x931ef8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__reset_rx_counters, internal_tx_step, rate_search__reset_sta, rate_search__step, rx_funcs__rx_flow, rx_nav_bi_step, tx_initiator_step
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc
 * Глобалы (через gp): 0x800560
 */
	.section .text.uc_sta_trace__push_record,"ax",@progbits
	.global uc_sta_trace__push_record
uc_sta_trace__push_record:
	.global L_931ef8
L_931ef8:
	push_s blink
L_931efa:
	bl L_920210
L_931efe:
	mov_s r13,0x855800
L_931f04:
	mov_s r1,0x855900
L_931f0a:
	ld.as r2,[gp,0xe]
L_931f0e:
	add2_s r1,r1,r0
L_931f10:
	add2 r3,r13,r0
L_931f14:
	ld_s r14,[r1,0x38]
L_931f16:
	bbit0 r2,r0,L_931f4e
L_931f1a:
	mov_s r2,0x886e80
L_931f20:
	ld_s r2,[r2,0x38]
L_931f22:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_931f24:
	st_s r2,[r14,0x4]
L_931f26:
	ld_s r2,[r3,0x4]
L_931f28:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_931f2a:
	st_s r2,[r14,0x8]
L_931f2c:
	add_s r14,r13,r0
L_931f2e:
	ld_s r15,[r14,0x4c]
L_931f30:
	ld_s r2,[r1,0x38]
L_931f32:
	ld_s r14,[r14,0x54]
L_931f34:
	add_s r2,r2,r15
L_931f36:
	add_s r13,r13,r0
L_931f38:
	ld_s r13,[r13,0x50]
L_931f3a:
	mul64_s r14,r15
L_931f3c:
	add r0,r13,mlo
L_931f40:
	st_s r2,[r1,0x38]
L_931f42:
	brne r2,r0,L_931f48
L_931f46:
	st_s r13,[r1,0x38]
	.global L_931f48
L_931f48:
	ld_s r0,[r3,0x4]
L_931f4a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_931f4c:
	st_s r0,[r3,0x4]
	.global L_931f4e
L_931f4e:
	b L_92027c
L_931f52:
	nop_s
