/* mbox__notify_sm @ 0x8d9ca8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_mailbox__write, tail_mbox__notify_sm
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.mbox__notify_sm,"ax",@progbits
	.global mbox__notify_sm
mbox__notify_sm:
	.byte 0x0f
	.byte 0xf3
	.global sub_8d9caa
sub_8d9caa:
L_8d9caa:
	nop_s
	.global L_8d9cac
L_8d9cac:
	add r0,r0,0xfc
L_8d9cb0:
	mov_s r1,0x6
L_8d9cb2:
	mov_s r2,0x0
L_8d9cb4:
	mov_s r3,r2
L_8d9cb6:
	b.d L_8d6a1c
L_8d9cba:
	mov_s r4,r2
