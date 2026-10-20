/* bi_manager__on_aw @ 0x9289a0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bi_manager.cpp
 * Зовут его: bi_ap_mon__aw_event
 * Зовёт сам: aw_worker__begin_window, bi_ap_mon__window_code, uc_sysassert
 */
	.section .text.bi_manager__on_aw,"ax",@progbits
	.global bi_manager__on_aw
bi_manager__on_aw:
	.global L_9289a0
L_9289a0:
	st.a r13,[sp,-0x8]
L_9289a4:
	st blink,[sp, 0x4]
L_9289a8:
	bl.d L_926490
L_9289ac:
	mov r13,r0
L_9289b0:
	brne.d r0,0x2,L_9289cc
L_9289b4:
	st r0,[r13, 0x38]
	.global L_9289b8
L_9289b8:
	bl.d L_931110
L_9289bc:
	add r0,r13,0x24
L_9289c0:
	ld blink,[sp, 0x4]
L_9289c4:
	j.d [blink]
L_9289c8:
	ld.ab r13,[sp,0x8]
	.global L_9289cc
L_9289cc:
	mov_s r0,blink
L_9289ce:
	mov_s r2,0x1002b80
L_9289d4:
	mov r1,0x64
L_9289d8:
	bl.d L_925548
L_9289dc:
	mov r3,0x54
L_9289e0:
	b_s L_9289b8
L_9289e2:
	nop_s
