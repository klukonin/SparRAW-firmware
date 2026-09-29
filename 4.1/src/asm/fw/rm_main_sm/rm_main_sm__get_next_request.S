/* rm_main_sm__get_next_request @ 0x8ca3c0, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::get_next_request. Next request is type = %d. Handle:0x%x
 *   rm_main_sm.cpp
 *   rm_main_sm::get_next_request. RX is Off --> GOTO IDLE
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__store_pending_event, fw_log__emit0, fw_log__emit2, fw_sysassert_fatal, obj__get_field4
 */
	.section .text.rm_main_sm__get_next_request,"ax",@progbits
	.global rm_main_sm__get_next_request
rm_main_sm__get_next_request:
	.byte 0xcf
	.byte 0xfa
	.global fwlog_rm_main_sm_get_next_request_Next_request
fwlog_rm_main_sm_get_next_request_Next_request:
L_8ca3c2:
	nop_s
L_8ca3c4:
	push_s blink
L_8ca3c6:
	bl L_8c02bc
L_8ca3ca:
	mov_s r13,r0
L_8ca3cc:
	bl.d L_8ca454
L_8ca3d0:
	ld_s r0,[r0,0x2c]
L_8ca3d2:
	mov.f r16,r0
L_8ca3d6:
	beq_s L_8ca432
L_8ca3d8:
	ld_s r0,[r13,0x28]
L_8ca3da:
	ld r3,[r16, 0x14]
L_8ca3de:
	breq_s r0,0,L_8ca3f2
L_8ca3e0:
	mov_s r2,0x1015e24
L_8ca3e6:
	mov_s r0,0x8
L_8ca3e8:
	mov_s r1,0x2
L_8ca3ea:
	bl.d L_8edff8
L_8ca3ee:
	mov r4,r16
	.global L_8ca3f2
L_8ca3f2:
	ld r0,[r16, 0x14]
L_8ca3f6:
	brne_s r0,0,L_8ca428
L_8ca3f8:
	ld_s r0,[r13,0x78]
L_8ca3fa:
	brne r0,0x1,L_8ca404
	.global L_8ca3fe
L_8ca3fe:
	mov_s r0,r13
L_8ca400:
	mov_s r1,0x4
L_8ca402:
	b_s L_8ca41c
	.global L_8ca404
L_8ca404:
	mov_s r0,blink
L_8ca406:
	mov_s r2,0x1015d54
L_8ca40c:
	mov_s r1,0x1175
L_8ca412:
	bl.d L_8c82c0
L_8ca416:
	mov r3,0x194
L_8ca41a:
	b_s L_8ca3fe
	.global L_8ca41c
L_8ca41c:
	mov_s r2,0x0
L_8ca41e:
	mov_s r3,r2
L_8ca420:
	bl.d L_8e20c0
L_8ca424:
	mov_s r4,r2
L_8ca426:
	b_s L_8ca44e
	.global L_8ca428
L_8ca428:
	brne r0,0x1,L_8ca44e
L_8ca42c:
	mov_s r0,r13
L_8ca42e:
	mov_s r1,0x6
L_8ca430:
	b_s L_8ca41c
	.global L_8ca432
L_8ca432:
	ld_s r0,[r13,0x78]
L_8ca434:
	brne_s r0,0,L_8ca44e
L_8ca436:
	ld_s r0,[r13,0x28]
L_8ca438:
	breq_s r0,0,L_8ca448
L_8ca43a:
	mov_s r2,0x1015e6c
L_8ca440:
	mov_s r0,0x8
L_8ca442:
	bl.d L_8edfb0
L_8ca446:
	mov_s r1,0x2
	.global L_8ca448
L_8ca448:
	mov_s r0,r13
L_8ca44a:
	mov_s r1,0x9
L_8ca44c:
	b_s L_8ca41c
	.global L_8ca44e
L_8ca44e:
	.byte 0xd9,0x06
