/* sysassert__wmi_lock_notice @ 0x8c8420, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   To enable WMI commands change g_sysassert_wmi_lock to FALSE
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_mailbox__has_space, irq_disable_all, mbox__debug_init_flow, mbox__init_debug, mbox__init_operational, operational_if__mbox_ptr
 * Глобалы (через gp): 0x800232, 0x800233, 0x800284, 0x800320, 0x8003f0
 */
	.section .text.sysassert__wmi_lock_notice,"ax",@progbits
	.global sysassert__wmi_lock_notice
sysassert__wmi_lock_notice:
	.global L_8c8420
L_8c8420:
	push_s blink
L_8c8422:
	bl.d L_8c02c4
L_8c8426:
	mov_s r0,0x0
L_8c8428:
	mov_s r2,0x10014cc
L_8c842e:
	bl.d L_8edfb0
L_8c8432:
	mov_s r1,0x2
L_8c8434:
	bl L_8c042c
	.global L_8c8438
L_8c8438:
	ldb_s r0,[gp,0xc2]
L_8c843a:
	brne_s r0,0,L_8c8438
L_8c843c:
	mov_s r13,0x0
L_8c843e:
	ld.as r1,[gp,0xa0]
L_8c8442:
	mov_s r0,0x1
L_8c8444:
	st.as r13,[gp,-0x52]
L_8c8448:
	stb r0,[gp, 0xc2]
L_8c844c:
	brne_s r1,0,L_8c8452
L_8c844e:
	ld_s r0,[gp,0x1b0]
L_8c8450:
	breq_s r0,0,L_8c847e
	.global L_8c8452
L_8c8452:
	breq_s r1,0,L_8c845a
L_8c8454:
	bl L_8d6e80
L_8c8458:
	b_s L_8c845e
	.global L_8c845a
L_8c845a:
	bl L_8d6ea8
	.global L_8c845e
L_8c845e:
	add r14,r0,0x24
L_8c8462:
	ld_s r0,[r14]
L_8c8464:
	st_s r13,[r0]
L_8c8466:
	bl.d L_8d533c
L_8c846a:
	mov_s r0,r14
L_8c846c:
	ld_s r1,[r14,0xc]
L_8c846e:
	ld_s r0,[r14]
L_8c8470:
	st_s r0,[r1,0x8]
L_8c8472:
	b_s L_8c847e
	.global L_8c8474
L_8c8474:
	mov_s r0,0x880b00
L_8c847a:
	ld_s r13,[r0,0x50]
L_8c847c:
	brne_s r13,0,L_8c8486
	.global L_8c847e
L_8c847e:
	ldb_s r0,[gp,0xc3]
L_8c8480:
	brne_s r0,0,L_8c8474
L_8c8482:
	b L_8c0334
	.global L_8c8486
L_8c8486:
	st_s r13,[r0,0x50]
L_8c8488:
	ldw_s r0,[gp,0x114]
L_8c848a:
	btst_s r13,0x12
L_8c848c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c848e:
	stw.as r0,[gp,0x8a]
L_8c8492:
	sub_s.ne r0,r0,r0
L_8c8494:
	bl.ne.d L_8ded20
L_8c8498:
	mov.ne r1,r0
L_8c849c:
	btst_s r13,0x13
L_8c849e:
	sub_s.ne r0,r0,r0
L_8c84a0:
	bl.ne.d L_8ded5c
L_8c84a4:
	mov.ne r1,r0
L_8c84a8:
	b_s L_8c847e
L_8c84aa:
	nop_s
