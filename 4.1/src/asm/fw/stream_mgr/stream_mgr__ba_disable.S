/* stream_mgr__ba_disable @ 0x8c3838, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr.cpp
 * Зовут его: wmi_handler_vring_ba_dis
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, ul_stream__ba_sm_evt
 */
	.section .text.stream_mgr__ba_disable,"ax",@progbits
	.global stream_mgr__ba_disable
stream_mgr__ba_disable:
	.global L_8c3838
L_8c3838:
	push_s blink
L_8c383a:
	push_s r13
L_8c383c:
	mov_s r1,0x8485dc
L_8c3842:
	sub3 r1,r1,0x100
L_8c3846:
	add2_s r1,r1,r0
L_8c3848:
	ld r13,[r1,0x818]
L_8c3850:
	breq_s r13,0,L_8c386c
	.global L_8c3852
L_8c3852:
	mov_s r0,0x0
L_8c3854:
	st r0,[r13, 0xc0]
L_8c3858:
	mov_s r0,r13
L_8c385a:
	mov_s r1,0x1
L_8c385c:
	mov_s r2,0x25
L_8c385e:
	mov_s r3,r1
L_8c3860:
	bl.d L_8d6afc
L_8c3864:
	mov r4,0x0
L_8c3868:
	b L_8c033c
	.global L_8c386c
L_8c386c:
	mov_s r0,blink
L_8c386e:
	mov_s r2,0x100e398
L_8c3874:
	mov_s r1,0x128c
L_8c387a:
	bl.d L_8c82c0
L_8c387e:
	mov_s r3,0xa6
L_8c3880:
	b_s L_8c3852
L_8c3882:
	nop_s
