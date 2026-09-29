/* fwq_tx__check_prio @ 0x8c9b10, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx.cpp
 * Зовут его: fwq_tx__enable_queue, fwq_tx__enqueue, fwq_tx__flush_by_prio
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.fwq_tx__check_prio,"ax",@progbits
	.global fwq_tx__check_prio
fwq_tx__check_prio:
	.global L_8c9b10
L_8c9b10:
	push_s blink
L_8c9b12:
	push_s r13
L_8c9b14:
	mov_s r13,0x0
L_8c9b16:
	breq_s r1,0,L_8c9b34
L_8c9b18:
	breq r1,0x1,L_8c9b38
L_8c9b1c:
	mov_s r0,blink
L_8c9b1e:
	mov_s r2,0x1015730
L_8c9b24:
	mov_s r1,0x120f
L_8c9b2a:
	bl.d L_8c82c0
L_8c9b2e:
	mov_s r3,0x45
L_8c9b30:
	mov_s r0,r13
L_8c9b32:
	b_s L_8c9b3a
	.global L_8c9b34
L_8c9b34:
	add_s r0,r0,0x18
L_8c9b36:
	b_s L_8c9b3a
	.global L_8c9b38
L_8c9b38:
	add_s r0,r0,0x24
	.global L_8c9b3a
L_8c9b3a:
	.byte 0x05,0x00
