/* u_schd__add @ 0x8c3248, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, TX_API__send_packet, TX_INTERNAL_API__connection, WBE_DRIVER__link_down_notif, WBE_DRIVER__link_up_notif, ba__schedule_timeout_update, backoff__add_and_schedule, conn_main_sm__action_8c9050, conn_main_sm__action_8da6b0, conn_main_sm__action_8db038
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, u_schd__alloc_task, u_schd__enqueue_ready
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__add
u_schd__add:
	.global L_8c3248
L_8c3248:
	push_s blink
L_8c324a:
	bl L_8c01d8
L_8c324e:
	mov_s r15,r0
L_8c3250:
	mov_s r17,r1
L_8c3252:
	mov_s r16,r2
L_8c3254:
	bl.d L_8c32f8
L_8c3258:
	mov_s r13,r3
L_8c325a:
	brhs.d r13,0x3,L_8c3276
L_8c325e:
	mov_s r14,r0
	.global L_8c3260
L_8c3260:
	st_s r15,[r14,0xc]
L_8c3262:
	st r17,[r14, 0x10]
L_8c3266:
	st r16,[r14, 0x14]
L_8c326a:
	mov_s r0,r14
L_8c326c:
	bl.d L_8e0bcc
L_8c3270:
	mov_s r1,r13
L_8c3272:
	b L_8c023c
	.global L_8c3276
L_8c3276:
	mov_s r0,blink
L_8c3278:
	mov_s r1,0x65
L_8c327a:
	bl.d L_8c9b28
L_8c327e:
	bset_s r1,r1,0xc
L_8c3280:
	b_s L_8c3260
L_8c3282:
	nop_s
