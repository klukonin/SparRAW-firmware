/* ba_setup_sm__close_addba_resp_timeout @ 0x8ea488, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::close_addba_resp_timeout() delete addba resp pending TO.
 * Зовут его: ba_setup_sm__addba_resp, ba_setup_sm__close_all_timers
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, u_schd__cancel
 */
	.section .text.ba_setup_sm__close_addba_resp_timeout,"ax",@progbits
	.global ba_setup_sm__close_addba_resp_timeout
ba_setup_sm__close_addba_resp_timeout:
	.global L_8ea488
L_8ea488:
	push_s blink
L_8ea48a:
	push_s r13
L_8ea48c:
	mov_s r13,r0
L_8ea48e:
	ld_s r0,[r0,0x30]
L_8ea490:
	breq_s r0,0,L_8ea4a6
L_8ea492:
	mov_s r2,0x1010238
L_8ea498:
	mov_s r0,0x7
L_8ea49a:
	bl.d L_8edfb0
L_8ea49e:
	mov_s r1,0x2
L_8ea4a0:
	bl.d L_8c7794
L_8ea4a4:
	ld_s r0,[r13,0x30]
	.global L_8ea4a6
L_8ea4a6:
	mov_s r0,0x0
L_8ea4a8:
	b.d L_8c033c
L_8ea4ac:
	st_s r0,[r13,0x30]
L_8ea4ae:
	nop_s
