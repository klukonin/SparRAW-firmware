/* ucode_cmd__echo @ 0x927338, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd__echo
ucode_cmd__echo:
	.global L_927338
L_927338:
	push_s blink
L_92733a:
	push_s r13
L_92733c:
	mov_s r13,r0
L_92733e:
	mov_s r0,0x802470
L_927344:
	bl L_920d4c
L_927348:
	ld_s r1,[r13]
L_92734a:
	mov_s r2,0x4
L_92734c:
	st_s r1,[r0]
L_92734e:
	mov_s r1,0x2
L_927350:
	bl.d L_927958
L_927354:
	mov_s r3,0x0
L_927356:
	b L_9202ac
L_92735a:
	nop_s
