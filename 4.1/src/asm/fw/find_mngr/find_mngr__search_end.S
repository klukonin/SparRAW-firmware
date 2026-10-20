/* find_mngr__search_end @ 0x8e00ec, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: End of SEARCH phase.
 *   find_mngr.cpp
 * Зовёт сам: __ld_r13_ret, find_mng__listen, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.find_mngr__search_end,"ax",@progbits
	.global find_mngr__search_end
find_mngr__search_end:
L_8e00ec:
	push_s blink
L_8e00ee:
	push_s r13
L_8e00f0:
	mov_s r13,r0
L_8e00f2:
	mov_s r2,0x1014044
L_8e00f8:
	mov_s r0,0xc
L_8e00fa:
	bl.d L_8edfb0
L_8e00fe:
	mov_s r1,0x2
L_8e0100:
	mov_s r0,0x0
L_8e0102:
	st_s r0,[r13,0x18]
L_8e0104:
	ld_s r0,[r13,0xc]
L_8e0106:
	breq_s r0,0,L_8e0112
	.global L_8e0108
L_8e0108:
	bl.d L_8d7e50
L_8e010c:
	mov_s r0,r13
L_8e010e:
	b L_8c033c
	.global L_8e0112
L_8e0112:
	mov_s r0,blink
L_8e0114:
	mov_s r2,0x1013eb8
L_8e011a:
	mov_s r1,0x1245
L_8e0120:
	bl.d L_8c82c0
L_8e0124:
	mov_s r3,0xa1
L_8e0126:
	b_s L_8e0108
