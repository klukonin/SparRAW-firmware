/* uc_send_evt__sta_update_field_rsp @ 0x927810, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x18_handler
 * Зовёт сам: irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__sta_update_field_rsp
uc_send_evt__sta_update_field_rsp:
	.global L_927810
L_927810:
	sub_s sp,sp,0x8
L_927812:
	push_s blink
L_927814:
	st_s r0,[sp,0x4]
L_927816:
	mov_s r0,0x802470
L_92781c:
	bl.d L_920d4c
L_927820:
	st_s r1,[sp,0x8]
L_927822:
	ld_s r2,[sp,0x4]
L_927824:
	ld_s r1,[sp,0x8]
L_927826:
	st_s r2,[r0]
L_927828:
	st_s r1,[r0,0x4]
L_92782a:
	mov_s r1,0x11
L_92782c:
	mov_s r2,0x8
L_92782e:
	bl.d L_927958
L_927832:
	mov_s r3,0x0
L_927834:
	pop_s blink
L_927836:
	j_s.d [blink]
L_927838:
	add_s sp,sp,0x8
L_92783a:
	nop_s
