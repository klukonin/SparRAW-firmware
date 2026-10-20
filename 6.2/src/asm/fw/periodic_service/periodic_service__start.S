/* periodic_service__start @ 0x8e77c4, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__start_detect_a, conn__start_detect_b, ka_necessity_detector__start_monitoring, phy_monitor__on_system_state, tx_ppdu_ageing_timeout_detector__start_monitoring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, periodic_service__tick, timer_task__cancel, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global periodic_service__start
periodic_service__start:
	.global L_8e77c4
L_8e77c4:
	push_s blink
L_8e77c6:
	bl L_8c01e0
L_8e77ca:
	mov_s r13,r0
L_8e77cc:
	mov_s r14,r1
L_8e77ce:
	bl.d L_8e9524
L_8e77d2:
	mov_s r15,0x0
L_8e77d4:
	bl.d L_8c8e74
L_8e77d8:
	mov_s r0,r13
L_8e77da:
	st_s r15,[r13,0x28]
L_8e77dc:
	breq_s r14,0,L_8e77f8
L_8e77de:
	breq r14,0x1,L_8e7802
L_8e77e2:
	breq r14,0x2,L_8e780c
L_8e77e6:
	breq r14,0x3,L_8e7818
L_8e77ea:
	mov_s r0,blink
L_8e77ec:
	mov_s r1,0x1439
L_8e77f2:
	bl L_8c9b28
L_8e77f6:
	b_s L_8e7824
	.global L_8e77f8
L_8e77f8:
	ld_s r0,[r13,0x2c]
L_8e77fa:
	ld_s r1,[r0,0x10]
L_8e77fc:
	jl_s.d [r1]
L_8e77fe:
	mov_s r0,r13
L_8e7800:
	b_s L_8e7824
	.global L_8e7802
L_8e7802:
	mov_s r0,r13
L_8e7804:
	bl.d L_8e4828
L_8e7808:
	ld_s r1,[r13]
L_8e780a:
	b_s L_8e7824
	.global L_8e780c
L_8e780c:
	mov_s r0,r13
L_8e780e:
	bl.d L_8e4828
L_8e7812:
	mov r1,-0x1
L_8e7816:
	b_s L_8e7824
	.global L_8e7818
L_8e7818:
	ld_s r0,[r13,0x2c]
L_8e781a:
	ld_s r1,[r0,0x10]
L_8e781c:
	jl_s.d [r1]
L_8e781e:
	mov_s r0,r13
L_8e7820:
	mov_s r0,0x1
L_8e7822:
	st_s r0,[r13,0x28]
	.global L_8e7824
L_8e7824:
	b L_8c024c
