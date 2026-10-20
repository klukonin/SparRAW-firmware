/* scan_mngr__init @ 0x8f1cb8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__init_scan_and_pools
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, obj_vt802fb4__ctor, scan_mngr__entry_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__init
scan_mngr__init:
	.global L_8f1cb8
L_8f1cb8:
	push_s blink
L_8f1cba:
	bl L_8c01e4
L_8f1cbe:
	mov_s r14,r0
L_8f1cc0:
	mov_s r13,r1
L_8f1cc2:
	bl.d L_8cc6a4
L_8f1cc6:
	ldb_s r0,[r1,0x10]
L_8f1cc8:
	mov_s r1,r14
L_8f1cca:
	st r0,[r14, 0x80]
L_8f1cce:
	bl.d L_8d9058
L_8f1cd2:
	mov_s r2,r13
L_8f1cd4:
	b.d L_8c0254
L_8f1cd8:
	st_s r13,[r14,0x7c]
L_8f1cda:
	nop_s
