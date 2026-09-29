/* app_ie__print_ies @ 0x8dce44, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   About to print ies:
 *   IE index: %d, IE Type: %d. IE Length
 * Зовут его: set_app_ie
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit3, ie_iter__init, ie_iter__next, ies__has_buffer, log_hexdump
 */
	.section .text.app_ie__print_ies,"ax",@progbits
	.global app_ie__print_ies
app_ie__print_ies:
	.global L_8dce44
L_8dce44:
	push_s blink
L_8dce46:
	bl.d L_8c02c0
L_8dce4a:
	mov_s r1,r0
L_8dce4c:
	sub_s sp,sp,0xc
L_8dce4e:
	mov_s r15,sp
L_8dce50:
	bl.d L_8e112c
L_8dce54:
	mov_s r0,r15
L_8dce56:
	mov_s r2,0x100ee98
L_8dce5c:
	mov_s r0,0xd
L_8dce5e:
	bl.d L_8edfb0
L_8dce62:
	mov_s r1,0x2
L_8dce64:
	mov_s r13,0x0
L_8dce66:
	b_s L_8dce94
	.global L_8dce68
L_8dce68:
	bl.d L_8db160
L_8dce6c:
	mov_s r0,r15
L_8dce6e:
	ldb r4,[r0]
L_8dce72:
	mov_s r14,r0
L_8dce74:
	ldb r5,[r0, 0x1]
L_8dce78:
	mov_s r2,0x100eeac
L_8dce7e:
	mov_s r0,0xd
L_8dce80:
	mov_s r1,0x2
L_8dce82:
	bl.d L_8ee034
L_8dce86:
	mov_s r3,r13
L_8dce88:
	add_s r0,r14,0x2
L_8dce8a:
	bl.d L_8c7f90
L_8dce8e:
	ldb_s r1,[r14,0x1]
L_8dce90:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8dce92:
	extb_s r13,r13
	.global L_8dce94
L_8dce94:
	bl.d L_8cb668
L_8dce98:
	mov_s r0,r15
L_8dce9a:
	brne_s r0,0,L_8dce68
L_8dce9c:
	b.d L_8c032c
L_8dcea0:
	add_s sp,sp,0xc
L_8dcea2:
	nop_s
