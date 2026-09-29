/* uc_send_evt__ucode_ready @ 0x927508, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot_uc__init_g800610
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, mac__ddc_mask_bit3, uc_evt__enqueue, uc_mailbox__init_rings
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__ucode_ready
uc_send_evt__ucode_ready:
	.global L_927508
L_927508:
	push_s blink
L_92750a:
	push_s r13
L_92750c:
	mov_s r13,0x802470
L_927512:
	bl.d L_9359b8
L_927516:
	mov_s r0,r13
L_927518:
	bl L_92735c
L_92751c:
	bl.d L_920d4c
L_927520:
	mov_s r0,r13
L_927522:
	mov_s r1,0x0
L_927524:
	mov_s r2,r1
L_927526:
	bl.d L_927958
L_92752a:
	mov_s r3,r1
L_92752c:
	b L_9202ac
