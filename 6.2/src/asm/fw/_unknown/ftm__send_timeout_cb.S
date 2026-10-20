/* ftm__send_timeout_cb @ 0x8f3254, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ftm_send_to(), FTM Req send TO, failed to hanedle TO event
 *   ftm_send_to(), FTM Req send TO: NEXT_PERIOD, aborting
 *   ftm_send_to(), FTM Req send TO: INITIATOR_START_BURST, aborting
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm__send_timeout_cb
ftm__send_timeout_cb:
	.global L_8f3254
L_8f3254:
	push_s blink
L_8f3256:
	bl L_8c01e4
L_8f325a:
	mov.f r13,r0
L_8f325e:
	bne_s L_8f326e
L_8f3260:
	mov_s r1,0x1019bdc
L_8f3266:
	bl.d L_8dcba8
L_8f326a:
	mov_s r0,0x2b
L_8f326c:
	b_s L_8f32b0
	.global L_8f326e
L_8f326e:
	mov_s r14,r13
L_8f3270:
	add r14,r14,0x164
L_8f3274:
	mov_s r0,0x0
L_8f3276:
	st_s r0,[r14,0xc]
L_8f3278:
	breq_s r1,0,L_8f3294
L_8f327a:
	brne r1,0x2,L_8f32b0
L_8f327e:
	mov_s r1,0x1019c18
L_8f3284:
	bl.d L_8dcba8
L_8f3288:
	mov_s r0,0x2b
L_8f328a:
	mov_s r0,r14
L_8f328c:
	mov_s r1,0x6
L_8f328e:
	mov_s r2,r13
L_8f3290:
	mov_s r3,0x2
L_8f3292:
	b_s L_8f32a8
	.global L_8f3294
L_8f3294:
	mov_s r1,0x1019c50
L_8f329a:
	bl.d L_8dcba8
L_8f329e:
	mov_s r0,0x2b
L_8f32a0:
	mov_s r0,r14
L_8f32a2:
	mov_s r1,0x6
L_8f32a4:
	mov_s r2,r13
L_8f32a6:
	mov_s r3,0x1
	.global L_8f32a8
L_8f32a8:
	bl.d L_8d9b6c
L_8f32ac:
	mov r4,0x0
	.global L_8f32b0
L_8f32b0:
	b L_8c0254
