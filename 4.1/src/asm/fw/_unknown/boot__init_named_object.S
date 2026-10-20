/* boot__init_named_object @ 0x8ea994, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__init_subsystems
 * Зовёт сам: __ld_r13_ret, boot__copy_name
 */
	.section .text.boot__init_named_object,"ax",@progbits
	.global boot__init_named_object
boot__init_named_object:
	.global L_8ea994
L_8ea994:
	push_s blink
L_8ea996:
	push_s r13
L_8ea998:
	mov_s r6,r0
L_8ea99a:
	mov_s r0,r2
L_8ea99c:
	mov_s r5,r3
L_8ea99e:
	mov_s r13,0x0
L_8ea9a0:
	b_s L_8ea9a6
	.global L_8ea9a2
L_8ea9a2:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8ea9a4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8ea9a6
L_8ea9a6:
	ldb_s r3,[r1,r0]
L_8ea9a8:
	brne_s r3,0,L_8ea9a2
L_8ea9aa:
	add r4,r13,0x1
L_8ea9ae:
	extb r4,r4
L_8ea9b2:
	mov_s r0,r6
L_8ea9b4:
	bl.d L_8ea9c0
L_8ea9b8:
	mov_s r3,r5
L_8ea9ba:
	b.d L_8c033c
L_8ea9be:
	extw_s r0,r13
