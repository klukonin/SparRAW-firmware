/* uc_mailbox__init_rings @ 0x930fc4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_send_evt__ucode_ready
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, stub_ret_927924, uc_ring__init_desc
 */
	.section .text.uc_mailbox__init_rings,"ax",@progbits
	.global uc_mailbox__init_rings
uc_mailbox__init_rings:
	.global L_930fc4
L_930fc4:
	push_s blink
L_930fc6:
	bl L_920214
L_930fca:
	bl L_927924
L_930fce:
	ld_s r13,[r0,0x24]
L_930fd0:
	ld_s r0,[r13]
L_930fd2:
	breq_s r0,0,L_93100e
L_930fd4:
	add r3,r13,0x10
L_930fd8:
	mov r4,0x0
L_930fdc:
	mov_s r14,0x801618
L_930fe2:
	ld_s r1,[r3]
L_930fe4:
	add r0,r14,0x24
L_930fe8:
	ldw_s r2,[r3,0x6]
L_930fea:
	mov r5,r4
L_930fee:
	bl.d L_928098
L_930ff2:
	mov r6,r4
L_930ff6:
	mov r4,0x0
L_930ffa:
	ld_s r1,[r13]
L_930ffc:
	add_s r0,r14,0x4
L_930ffe:
	ldw_s r2,[r13,0x6]
L_931000:
	mov_s r3,r13
L_931002:
	mov r5,r4
L_931006:
	bl.d L_928098
L_93100a:
	mov r6,r4
	.global L_93100e
L_93100e:
	b L_920284
L_931012:
	nop_s
