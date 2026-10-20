/* info_flow__run @ 0x8d86f0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Information flow - MID[%d] CID[%d] .
 *   Information flow, Not PCP AP
 * Зовут его: l2mgr__send_data_port_open_evt, perform_first_measurement_operations
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit1, mid__state_is_2_or_3, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global info_flow__run
info_flow__run:
	.global L_8d86f0
L_8d86f0:
	push_s blink
L_8d86f2:
	push_s r13
L_8d86f4:
	mov_s r13,r0
L_8d86f6:
	mov_s r1,0x1010d24
L_8d86fc:
	mov_s r0,0x2b
L_8d86fe:
	bl.d L_8dcc10
L_8d8702:
	mov_s r2,r13
L_8d8704:
	bl.d L_8da488
L_8d8708:
	mov_s r0,r13
L_8d870a:
	breq_s r0,0,L_8d873e
L_8d870c:
	ld_s r0,[gp,-0x98]
L_8d870e:
	brne_s r0,0,L_8d874a
L_8d8710:
	mov_s r1,0x803c00
L_8d8716:
	ld_s r0,[r1,0xc]
L_8d8718:
	breq_s r0,0,L_8d8720
L_8d871a:
	ld r4,[r1, 0x24]
L_8d871e:
	b_s L_8d8724
	.global L_8d8720
L_8d8720:
	ld.as r4,[gp,-0x4c]
	.global L_8d8724
L_8d8724:
	mov_s r0,0x209b0
L_8d872a:
	mov_s r1,r13
L_8d872c:
	mov_s r2,0x0
L_8d872e:
	mov_s r3,r2
L_8d8730:
	mov_s r5,r2
L_8d8732:
	bl.d L_8e0c0c
L_8d8736:
	mov_s r6,r2
L_8d8738:
	st.as r0,[gp,-0x26]
L_8d873c:
	b_s L_8d874a
	.global L_8d873e
L_8d873e:
	mov_s r1,0x1010d4c
L_8d8744:
	bl.d L_8dcba8
L_8d8748:
	mov_s r0,0x2b
	.global L_8d874a
L_8d874a:
	b L_8c025c
L_8d874e:
	nop_s
