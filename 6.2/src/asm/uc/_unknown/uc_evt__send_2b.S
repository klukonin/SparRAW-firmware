/* uc_evt__send_2b @ 0x92783c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_req__claim_and_report_2b
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_2b
uc_evt__send_2b:
	.global L_92783c
L_92783c:
	push_s blink
L_92783e:
	push_s r13
L_927840:
	mov_s r13,r0
L_927842:
	mov_s r0,0x802470
L_927848:
	bl L_920d4c
L_92784c:
	mov_s r1,0x2b
L_92784e:
	stb_s r13,[r0]
L_927850:
	mov_s r2,0x1
L_927852:
	bl.d L_927958
L_927856:
	mov_s r3,0x0
L_927858:
	b L_9202ac
