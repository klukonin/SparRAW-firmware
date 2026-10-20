/* find_mngr__listen_end @ 0x8d7eac, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: End of LISTEN phase.
 *   find_mngr.cpp
 * Зовёт сам: __ld_r13_ret, find_mng__search, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.find_mngr__listen_end,"ax",@progbits
	.global find_mngr__listen_end
find_mngr__listen_end:
L_8d7eac:
	push_s blink
L_8d7eae:
	push_s r13
L_8d7eb0:
	mov_s r13,r0
L_8d7eb2:
	mov_s r2,0x1014028
L_8d7eb8:
	mov_s r0,0xc
L_8d7eba:
	bl.d L_8edfb0
L_8d7ebe:
	mov_s r1,0x2
L_8d7ec0:
	mov_s r0,0x0
L_8d7ec2:
	st_s r0,[r13,0x18]
L_8d7ec4:
	ld_s r0,[r13,0xc]
L_8d7ec6:
	breq_s r0,0,L_8d7ed2
	.global L_8d7ec8
L_8d7ec8:
	bl.d L_8e0098
L_8d7ecc:
	mov_s r0,r13
L_8d7ece:
	b L_8c033c
	.global L_8d7ed2
L_8d7ed2:
	mov_s r0,blink
L_8d7ed4:
	mov_s r2,0x1013eb8
L_8d7eda:
	mov_s r1,0x1244
L_8d7ee0:
	bl.d L_8c82c0
L_8d7ee4:
	mov_s r3,0x96
L_8d7ee6:
	b_s L_8d7ec8
