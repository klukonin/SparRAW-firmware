/* info_flow__run @ 0x8d5374, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Information flow - MID[%d] CID[%d] .
 *   Information flow, Not PCP AP
 * Зовут его: info_flow__start_periodic, l2mgr__send_data_port_open_evt
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit1, mid__state_is_2_or_3, u_schd__schedule
 */
	.section .text.info_flow__run,"ax",@progbits
	.global info_flow__run
info_flow__run:
	.global L_8d5374
L_8d5374:
	push_s blink
L_8d5376:
	push_s r13
L_8d5378:
	mov_s r13,r0
L_8d537a:
	mov_s r2,0x100ea30
L_8d5380:
	mov_s r0,0xb
L_8d5382:
	mov_s r1,0x2
L_8d5384:
	bl.d L_8edfcc
L_8d5388:
	mov_s r3,r13
L_8d538a:
	bl.d L_8d73c4
L_8d538e:
	mov_s r0,r13
L_8d5390:
	breq_s r0,0,L_8d53c4
L_8d5392:
	ld_s r0,[gp,-0x84]
L_8d5394:
	brne_s r0,0,L_8d53d2
L_8d5396:
	mov_s r1,0x80345c
L_8d539c:
	ld_s r0,[r1,0xc]
L_8d539e:
	breq_s r0,0,L_8d53a6
L_8d53a0:
	ld r4,[r1, 0x1c]
L_8d53a4:
	b_s L_8d53aa
	.global L_8d53a6
L_8d53a6:
	ld.as r4,[gp,-0x46]
	.global L_8d53aa
L_8d53aa:
	mov_s r0,0x1c75c
L_8d53b0:
	mov_s r1,r13
L_8d53b2:
	mov_s r2,0x0
L_8d53b4:
	mov_s r3,r2
L_8d53b6:
	mov_s r5,r2
L_8d53b8:
	bl.d L_8dc92c
L_8d53bc:
	mov_s r6,r2
L_8d53be:
	st.as r0,[gp,-0x21]
L_8d53c2:
	b_s L_8d53d2
	.global L_8d53c4
L_8d53c4:
	mov_s r2,0x100ea58
L_8d53ca:
	mov_s r0,0xb
L_8d53cc:
	bl.d L_8edfb0
L_8d53d0:
	mov_s r1,0x2
	.global L_8d53d2
L_8d53d2:
	b L_8c033c
L_8d53d6:
	nop_s
