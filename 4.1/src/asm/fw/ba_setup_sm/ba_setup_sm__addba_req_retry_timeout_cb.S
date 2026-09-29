/* ba_setup_sm__addba_req_retry_timeout_cb @ 0x8e9238, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::addba_req_retry_timeout_cb()
 *   ba_setup_sm.cpp
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.ba_setup_sm__addba_req_retry_timeout_cb,"ax",@progbits
	.global ba_setup_sm__addba_req_retry_timeout_cb
ba_setup_sm__addba_req_retry_timeout_cb:
L_8e9238:
	push_s blink
L_8e923a:
	push_s r13
L_8e923c:
	mov_s r13,r0
L_8e923e:
	mov_s r2,0x1010474
L_8e9244:
	mov_s r0,0x5
L_8e9246:
	bl.d L_8edfb0
L_8e924a:
	mov_s r1,0x2
L_8e924c:
	breq_s r13,0,L_8e9262
	.global L_8e924e
L_8e924e:
	mov_s r2,0x0
L_8e9250:
	st_s r2,[r13,0x34]
L_8e9252:
	mov_s r0,r13
L_8e9254:
	mov_s r1,0x5
L_8e9256:
	mov_s r3,r2
L_8e9258:
	bl.d L_8d6a1c
L_8e925c:
	mov_s r4,r2
L_8e925e:
	b L_8c033c
	.global L_8e9262
L_8e9262:
	mov_s r0,blink
L_8e9264:
	mov_s r2,0x10102c4
L_8e926a:
	mov_s r1,0x1430
L_8e9270:
	bl.d L_8c82c0
L_8e9274:
	mov r3,0x114
