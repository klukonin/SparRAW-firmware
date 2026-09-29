/* basic_sm__error_handler @ 0x8c81cc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_sm::error_handler event: %s  SM: %s  STATE: %s
 *   basic_sm.cpp
 * Зовёт сам: fw_log__emit3_nonl, fw_sysassert_fatal
 */
	.section .text.basic_sm__error_handler,"ax",@progbits
	.global basic_sm__error_handler
basic_sm__error_handler:
L_8c81cc:
	push_s blink
L_8c81ce:
	ld_s r3,[r0,0x8]
L_8c81d0:
	ld_s r1,[r0,0x20]
L_8c81d2:
	mov_s r2,0x10027d4
L_8c81d8:
	ld.as r3,[r1,r3]
L_8c81dc:
	ldb_s r1,[r0]
L_8c81de:
	ld r4,[r0, 0x24]
L_8c81e2:
	ld_s r0,[r0,0x1c]
L_8c81e4:
	ld.as r5,[r0,r1]
L_8c81e8:
	mov_s r0,0x5
L_8c81ea:
	bl.d L_8ee0e8
L_8c81ee:
	mov_s r1,0x0
L_8c81f0:
	mov_s r0,blink
L_8c81f2:
	mov_s r2,0x100279c
L_8c81f8:
	mov_s r1,0x33
L_8c81fa:
	bset_s r1,r1,0xc
L_8c81fc:
	bl.d L_8c82c0
L_8c8200:
	mov_s r3,0x5a
L_8c8202:
	pop_s blink
