/* conn_main_sm__send_assoc_resp_pbss @ 0x8c3210, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending mlme_sm::ASSOC_RESPONSE for direct STA PBSS member
 *   conn_main_sm.cpp
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.conn_main_sm__send_assoc_resp_pbss,"ax",@progbits
	.global conn_main_sm__send_assoc_resp_pbss
conn_main_sm__send_assoc_resp_pbss:
L_8c3210:
	mov_s r0,r1
	.global fwlog_Sending_mlme_sm_ASSOC_RESPONSE_for_direc
fwlog_Sending_mlme_sm_ASSOC_RESPONSE_for_direc:
L_8c3212:
	nop_s
L_8c3214:
	push_s blink
L_8c3216:
	push_s r13
L_8c3218:
	mov_s r13,r0
L_8c321a:
	ld_s r0,[r0,0x2c]
L_8c321c:
	ld_s r0,[r0,0xc]
L_8c321e:
	ld_s r0,[r0,0x50]
L_8c3220:
	cmp_s r0,0x1
L_8c3222:
	mov_s r0,0x1
L_8c3224:
	sub_s.ne r0,r0,r0
L_8c3226:
	extb.f 0x0,r0
L_8c322a:
	beq_s L_8c3250
	.global L_8c322c
L_8c322c:
	ld_s r0,[r13,0x2c]
L_8c322e:
	ld_s r0,[r0,0x18]
L_8c3230:
	breq_s r0,0,L_8c3268
	.global L_8c3232
L_8c3232:
	ld_s r0,[r13,0x2c]
L_8c3234:
	ld_s r1,[r0,0x1c]
L_8c3236:
	breq_s r1,0,L_8c3280
L_8c3238:
	mov_s r2,0x100f790
L_8c323e:
	mov_s r0,0xb
L_8c3240:
	bl.d L_8edfb0
L_8c3244:
	mov_s r1,0x2
L_8c3246:
	ld_s r0,[r13,0x2c]
L_8c3248:
	add r0,r0,0xb0
L_8c324c:
	mov_s r1,0x4
L_8c324e:
	b_s L_8c3286
	.global L_8c3250
L_8c3250:
	mov_s r0,blink
L_8c3252:
	mov_s r2,0x100f6f0
L_8c3258:
	mov_s r1,0x11c5
L_8c325e:
	bl.d L_8c82c0
L_8c3262:
	mov r3,0x15e
L_8c3266:
	b_s L_8c322c
	.global L_8c3268
L_8c3268:
	mov_s r0,blink
L_8c326a:
	mov_s r2,0x100f6f0
L_8c3270:
	mov_s r1,0x11c6
L_8c3276:
	bl.d L_8c82c0
L_8c327a:
	mov r3,0x15f
L_8c327e:
	b_s L_8c3232
	.global L_8c3280
L_8c3280:
	add r0,r0,0xb0
L_8c3284:
	mov_s r1,0x0
	.global L_8c3286
L_8c3286:
	mov_s r2,0x0
L_8c3288:
	mov_s r3,r2
L_8c328a:
	bl.d L_8d6a1c
L_8c328e:
	mov_s r4,r2
L_8c3290:
	b L_8c033c
