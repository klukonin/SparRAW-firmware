/* SDP__sdp_init @ 0x8c5244, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::sdp_init() the following sdp port has invalid enabled_at_personality field: %d
 *   SDP_GPIO_srvs.c
 * Зовут его: sdp_gpio__boot_init
 * Зовёт сам: fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.SDP__sdp_init,"ax",@progbits
	.global SDP__sdp_init
SDP__sdp_init:
	.global L_8c5244
L_8c5244:
	push_s blink
L_8c5246:
	mov_s r1,0x800ce8
L_8c524c:
	ld.as r3,[r1,r0]
L_8c5250:
	lsr r0,r3,0xd
L_8c5254:
	bmsk.f r0,r0,0x1
L_8c5258:
	beq_s L_8c528c
L_8c525a:
	breq r0,0x1,L_8c5298
L_8c525e:
	breq r0,0x2,L_8c52a8
L_8c5262:
	breq r0,0x3,L_8c52a4
L_8c5266:
	mov_s r2,0x1008248
L_8c526c:
	mov_s r0,0x0
L_8c526e:
	mov_s r1,r0
L_8c5270:
	bl.d L_8edfcc
L_8c5274:
	bmsk_s r3,r3,0x4
L_8c5276:
	mov_s r0,blink
L_8c5278:
	mov_s r2,0x100829c
L_8c527e:
	mov_s r1,0x1311
L_8c5284:
	bl.d L_8c82c0
L_8c5288:
	mov_s r3,0xb5
L_8c528a:
	b_s L_8c52a8
	.global L_8c528c
L_8c528c:
	mov_s r0,0x880a3c
L_8c5292:
	ld_s r0,[r0,0x7c]
L_8c5294:
	breq_s r0,0,L_8c52a8
L_8c5296:
	b_s L_8c52a4
	.global L_8c5298
L_8c5298:
	mov_s r0,0x880a3c
L_8c529e:
	ld_s r0,[r0,0x7c]
L_8c52a0:
	breq r0,0x1,L_8c52a8
	.global L_8c52a4
L_8c52a4:
	mov_s r0,0x0
L_8c52a6:
	b_s L_8c52aa
	.global L_8c52a8
L_8c52a8:
	mov_s r0,0x1
	.global L_8c52aa
L_8c52aa:
	pop_s blink
L_8c52ac:
	j_s [blink]
L_8c52ae:
	nop_s
