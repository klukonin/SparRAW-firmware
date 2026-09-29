/* app_ie__print_ies @ 0x8e1008, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   About to print ies:
 *   IE index: %d, IE Type: %d. IE Length %d
 * Зовут его: set_app_ie
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, app_ie__walk_list, fw_log_emit0, fw_log_emit3, hexdump_words, ie_iter__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global app_ie__print_ies
app_ie__print_ies:
	.global L_8e1008
L_8e1008:
	push_s blink
L_8e100a:
	bl.d L_8c01e0
L_8e100e:
	mov_s r1,r0
L_8e1010:
	sub_s sp,sp,0xc
L_8e1012:
	mov_s r15,sp
L_8e1014:
	bl.d L_8e5de8
L_8e1018:
	mov_s r0,r15
L_8e101a:
	mov_s r1,0x1010e60
L_8e1020:
	bl.d L_8dcba8
L_8e1024:
	mov_s r0,0x2d
L_8e1026:
	mov_s r13,0x0
L_8e1028:
	b_s L_8e104a
	.global L_8e102a
L_8e102a:
	mov_s r1,0x1010e74
L_8e1030:
	ldb r4,[r14, 0x1]
L_8e1034:
	mov_s r0,0x2d
L_8e1036:
	mov_s r2,r13
L_8e1038:
	bl.d L_8dcd00
L_8e103c:
	ldb_s r3,[r14]
L_8e103e:
	add_s r0,r14,0x2
L_8e1040:
	bl.d L_8c9790
L_8e1044:
	ldb_s r1,[r14,0x1]
L_8e1046:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e1048:
	extb_s r13,r13
	.global L_8e104a
L_8e104a:
	bl.d L_8df404
L_8e104e:
	mov_s r0,r15
L_8e1050:
	mov.f r14,r0
L_8e1054:
	bne_s L_8e102a
L_8e1056:
	b.d L_8c024c
L_8e105a:
	add_s sp,sp,0xc
