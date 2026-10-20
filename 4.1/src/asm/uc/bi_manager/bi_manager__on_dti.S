/* bi_manager__on_dti @ 0x928a58, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bi_manager.cpp
 * Зовут его: bi_ap_mon__dti_event
 * Зовёт сам: bi_ap_mon__window_code, bi_dti__wake_and_evaluate_sleep, uc_sysassert
 */
	.section .text.bi_manager__on_dti,"ax",@progbits
	.global bi_manager__on_dti
bi_manager__on_dti:
	.global L_928a58
L_928a58:
	st.a r13,[sp,-0x8]
L_928a5c:
	st blink,[sp, 0x4]
L_928a60:
	bl.d L_926490
L_928a64:
	mov r13,r0
L_928a68:
	brne.d r0,0x1,L_928a84
L_928a6c:
	st r0,[r13, 0x38]
	.global L_928a70
L_928a70:
	bl.d L_931308
L_928a74:
	add r0,r13,0x20
L_928a78:
	ld blink,[sp, 0x4]
L_928a7c:
	j.d [blink]
L_928a80:
	ld.ab r13,[sp,0x8]
	.global L_928a84
L_928a84:
	mov_s r0,blink
L_928a86:
	mov_s r2,0x1002b80
L_928a8c:
	mov r1,0x62
L_928a90:
	bl.d L_925548
L_928a94:
	mov r3,0x4c
