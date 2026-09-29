/* RADIO_MGR__lock_primary @ 0x8d9288, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RADIO_MGR::lock_primary() Handle:0x%x
 * Зовут его: l2_mgr__connect, maintain_sm__lock_radio, mlme_sm__assoc_req_handle
 * Зовёт сам: __ld_r13_ret, fw_log__emit1
 */
	.section .text.RADIO_MGR__lock_primary,"ax",@progbits
	.global RADIO_MGR__lock_primary
RADIO_MGR__lock_primary:
	.global L_8d9288
L_8d9288:
	push_s blink
L_8d928a:
	push_s r13
L_8d928c:
	mov_s r5,r0
L_8d928e:
	mov_s r4,r1
L_8d9290:
	ld_s r0,[gp,-0x30]
L_8d9292:
	mov_s r3,r2
L_8d9294:
	ld_s r1,[r0]
L_8d9296:
	ld_s r13,[r1,0x8]
L_8d9298:
	mov_s r1,r5
L_8d929a:
	jl_s.d [r13]
L_8d929c:
	mov_s r2,r4
L_8d929e:
	mov_s r13,r0
L_8d92a0:
	mov_s r2,0x1015bcc
L_8d92a6:
	mov_s r0,0x8
L_8d92a8:
	mov_s r1,0x2
L_8d92aa:
	bl.d L_8edfcc
L_8d92ae:
	mov_s r3,r13
L_8d92b0:
	b.d L_8c033c
