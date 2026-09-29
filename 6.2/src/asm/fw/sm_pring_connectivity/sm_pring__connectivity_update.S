/* sm_pring__connectivity_update @ 0x8ea254, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__notify_vring_state
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, sm_pring__by_index, sm_pring__notify_vring_state, sm_pring__slot_optimized
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_pring__connectivity_update
sm_pring__connectivity_update:
	.global L_8ea254
L_8ea254:
	push_s blink
L_8ea256:
	bl L_8c01dc
L_8ea25a:
	mov_s r13,r0
L_8ea25c:
	ld_s r0,[r0,0x28]
L_8ea25e:
	mov_s r16,r1
L_8ea260:
	breq_s r0,0,L_8ea272
	.global L_8ea262
L_8ea262:
	mov_s r0,0x0
L_8ea264:
	st_s r0,[r13,0x28]
L_8ea266:
	ldw_s r0,[r13]
L_8ea268:
	bl.d L_8ea1b4
L_8ea26c:
	mov_s r1,r16
L_8ea26e:
	b L_8c0244
	.global L_8ea272
L_8ea272:
	mov_s r0,blink
L_8ea274:
	mov_s r1,0x12a3
L_8ea27a:
	bl L_8c9b28
L_8ea27e:
	b_s L_8ea262
L_8ea280:
	push_s blink
L_8ea282:
	push_s r13
L_8ea284:
	mov_s r13,r0
L_8ea286:
	bl.d L_8cca20
L_8ea28a:
	mov_s r0,r1
L_8ea28c:
	bl.d L_8ea298
L_8ea290:
	mov_s r1,r13
L_8ea292:
	b L_8c025c
L_8ea296:
	nop_s
