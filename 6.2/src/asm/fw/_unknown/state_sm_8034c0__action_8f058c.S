/* state_sm_8034c0__action_8f058c @ 0x8f058c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] ftm_main_sm:: action_allocate_radio
 * Зовёт сам: __ld_r13_to_r13_ret, discovery__rx_start, fw_log_emit0, radio_mgr__request, u_schd__schedule
 * Глобалы (через gp): 0x800360, 0x800364
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8034c0__action_8f058c
state_sm_8034c0__action_8f058c:
	.global L_8f058c
L_8f058c:
	push_s blink
L_8f058e:
	push_s r13
L_8f0590:
	mov_s r13,r0
L_8f0592:
	mov_s r1,0x1019e04
L_8f0598:
	bl.d L_8dcba8
L_8f059c:
	mov_s r0,0x2b
L_8f059e:
	bl.d L_8f80b8
L_8f05a2:
	mov_s r0,0x1
L_8f05a4:
	mov_s r0,0x37f9c
L_8f05aa:
	mov_s r1,r13
L_8f05ac:
	mov_s r2,0x0
L_8f05ae:
	mov_s r3,0xffff
L_8f05b4:
	bl.d L_8dcaf4
L_8f05b8:
	mov_s r4,r2
L_8f05ba:
	st_s r0,[r13,0x8]
L_8f05bc:
	mov_s r0,L_8f32b4-0x8c0000
L_8f05c2:
	ld.as r4,[gp,0x77]
L_8f05c6:
	mov_s r1,r13
L_8f05c8:
	mov_s r2,0x0
L_8f05ca:
	mov_s r3,0x1
L_8f05cc:
	mov_s r5,r2
L_8f05ce:
	bl.d L_8e0c0c
L_8f05d2:
	mov_s r6,r2
L_8f05d4:
	st_s r0,[r13,0xc]
L_8f05d6:
	mov_s r0,0x332e4
L_8f05dc:
	ld.as r4,[gp,0x78]
L_8f05e0:
	mov_s r1,r13
L_8f05e2:
	mov_s r2,0x0
L_8f05e4:
	mov_s r3,0x1
L_8f05e6:
	mov_s r5,r2
L_8f05e8:
	bl.d L_8e0c0c
L_8f05ec:
	mov_s r6,r2
L_8f05ee:
	b.d L_8c025c
L_8f05f2:
	st_s r0,[r13,0x14]
