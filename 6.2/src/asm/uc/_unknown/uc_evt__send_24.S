/* uc_evt__send_24 @ 0x927550, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: notify_aoa, ucode_cmd_0x31_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_24
uc_evt__send_24:
	.global L_927550
L_927550:
	push_s blink
L_927552:
	bl L_920234
L_927556:
	mov_s r14,r0
L_927558:
	mov_s r0,0x802470
L_92755e:
	bl L_920d4c
L_927562:
	mov_s r1,r14
L_927564:
	mov_s r13,r0
L_927566:
	bl.d L_920330
L_92756a:
	mov_s r2,0x50
L_92756c:
	mov_s r0,r13
L_92756e:
	mov_s r1,0x24
L_927570:
	mov_s r2,0x50
L_927572:
	bl.d L_927958
L_927576:
	mov_s r3,0x0
L_927578:
	b L_9202a4
