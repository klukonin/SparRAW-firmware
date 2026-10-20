/* fw_mailbox__init_rings @ 0x8c87ac, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, fw_mailbox__has_pending, mbox__ring_init
 */
	.section .text.fw_mailbox__init_rings,"ax",@progbits
	.global fw_mailbox__init_rings
fw_mailbox__init_rings:
L_8c87ac:
	add_s sp,sp,0x4
	.global sub_8c87ae
sub_8c87ae:
L_8c87ae:
	nop_s
L_8c87b0:
	push_s blink
L_8c87b2:
	push_s r13
L_8c87b4:
	b_s L_8c87bc
	.global L_8c87b6
L_8c87b6:
	bl.d L_8decf8
L_8c87ba:
	mov_s r0,r13
	.global L_8c87bc
L_8c87bc:
	mov_s r13,0x803e3c
L_8c87c2:
	bl.d L_8c30bc
L_8c87c6:
	mov_s r0,r13
L_8c87c8:
	brne_s r0,0,L_8c87b6
L_8c87ca:
	mov r1,0x200
L_8c87ce:
	mov_s r0,0x880b00
L_8c87d4:
	st_s r1,[r0,0x64]
L_8c87d6:
	sync
L_8c87da:
	.byte 0x65,0x03
