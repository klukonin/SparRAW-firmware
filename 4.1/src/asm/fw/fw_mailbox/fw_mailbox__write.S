/* fw_mailbox__write @ 0x8c9198, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_mailbox.cpp
 * Зовут его: basic_if__mailbox_send
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_mailbox__enqueue, fw_mailbox__has_space, fw_mailbox__is_empty, fw_sysassert_fatal, mbox__notify_sm
 */
	.section .text.fw_mailbox__write,"ax",@progbits
	.global fw_mailbox__write
fw_mailbox__write:
	.global L_8c9198
L_8c9198:
	push_s blink
L_8c919a:
	bl L_8c02bc
L_8c919e:
	mov.f r15,r1
L_8c91a2:
	mov_s r14,r0
L_8c91a4:
	beq_s L_8c91f6
	.global L_8c91a6
L_8c91a6:
	bl.d L_8d7078
L_8c91aa:
	mov_s r0,r14
L_8c91ac:
	breq_s r0,0,L_8c9208
	.global L_8c91ae
L_8c91ae:
	lr r16,[0xa]
L_8c91b2:
	bclr r0,r16,0x1
L_8c91b6:
	flag r0
L_8c91ba:
	ld_s r0,[r14,0x14]
L_8c91bc:
	brne r0,0x1,L_8c91d8
L_8c91c0:
	ld_s r13,[r14,0x4]
L_8c91c2:
	b_s L_8c91ce
	.global L_8c91c4
L_8c91c4:
	mov_s r0,r14
L_8c91c6:
	bl.d L_8c937c
L_8c91ca:
	mov_s r1,r13
L_8c91cc:
	add_s r13,r13,0x8
	.global L_8c91ce
L_8c91ce:
	ld_s r0,[r14,0x8]
L_8c91d0:
	brlo r13,r0,L_8c91c4
L_8c91d4:
	ld_s r0,[r14]
L_8c91d6:
	st_s r15,[r0,0x4]
	.global L_8c91d8
L_8c91d8:
	ld_s r0,[r14]
L_8c91da:
	mov_s r1,0x1
L_8c91dc:
	st_s r1,[r0]
L_8c91de:
	bl.d L_8d533c
L_8c91e2:
	mov_s r0,r14
L_8c91e4:
	lr r1,[0xa]
L_8c91e8:
	and r0,r16,0x2
L_8c91ec:
	or_s r0,r0,r1
L_8c91ee:
	flag r0
L_8c91f2:
	b L_8c0324
	.global L_8c91f6
L_8c91f6:
	mov_s r0,blink
L_8c91f8:
	mov_s r2,0x1001aa0
L_8c91fe:
	mov_s r1,0xca
L_8c9200:
	bl.d L_8c82c0
L_8c9204:
	mov_s r3,0x95
L_8c9206:
	b_s L_8c91a6
	.global L_8c9208
L_8c9208:
	mov_s r0,blink
L_8c920a:
	mov_s r2,0x1001aa0
L_8c9210:
	mov_s r1,0xcb
L_8c9212:
	bl.d L_8c82c0
L_8c9216:
	mov_s r3,0x96
L_8c9218:
	b_s L_8c91ae
L_8c921a:
	nop_s
L_8c921c:
	b L_8d9cac
