/* scan_mngr__abort_scan @ 0x8f04bc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::abort_scan() request !!!
 * Зовут его: scan_stop
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0, scan_mngr__free_channel_list
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__abort_scan
scan_mngr__abort_scan:
	.global L_8f04bc
L_8f04bc:
	push_s blink
L_8f04be:
	push_s r13
L_8f04c0:
	mov_s r13,r0
L_8f04c2:
	mov_s r1,0x1015724
L_8f04c8:
	bl.d L_8dcba8
L_8f04cc:
	mov_s r0,0x29
L_8f04ce:
	bl.d L_8f3160
L_8f04d2:
	mov_s r0,r13
L_8f04d4:
	mov_s r0,0x1
L_8f04d6:
	st.as r0,[r13,0x78]
L_8f04da:
	ld.as r0,[r13,0x89]
L_8f04de:
	brne_s r0,0,L_8f04ea
L_8f04e0:
	ld r0,[r13, 0x80]
L_8f04e4:
	mov_s r1,0x7
L_8f04e6:
	mov_s r2,0x0
L_8f04e8:
	b_s L_8f04f2
	.global L_8f04ea
L_8f04ea:
	add3 r0,r13,0x3a
L_8f04ee:
	mov_s r1,0x3
L_8f04f0:
	mov_s r2,0x2
	.global L_8f04f2
L_8f04f2:
	mov_s r3,0x0
L_8f04f4:
	bl.d L_8d9b6c
L_8f04f8:
	mov_s r4,r3
L_8f04fa:
	b L_8c025c
L_8f04fe:
	nop_s
