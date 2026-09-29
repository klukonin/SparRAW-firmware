/* lut__find_index @ 0x8c64f4, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lut::find_index(): Trying to use not initialized LUT
 *   binary_search_lut.cpp
 * Зовут его: lmac_if__mac_monitor_report
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_sysassert_fatal, lut__find_index__2
 */
	.section .text.lut__find_index,"ax",@progbits
	.global lut__find_index
lut__find_index:
	.global L_8c64f4
L_8c64f4:
	push_s blink
L_8c64f6:
	bl L_8c02c4
L_8c64fa:
	mov_s r14,r0
L_8c64fc:
	ld_s r0,[r0]
L_8c64fe:
	mov_s r13,r1
L_8c6500:
	breq_s r0,0,L_8c6506
L_8c6502:
	ld_s r0,[r14,0x4]
L_8c6504:
	brne_s r0,0,L_8c652a
	.global L_8c6506
L_8c6506:
	mov_s r2,0x1006ee4
L_8c650c:
	mov_s r0,0x0
L_8c650e:
	bl.d L_8edfb0
L_8c6512:
	mov_s r1,r0
L_8c6514:
	mov_s r0,blink
L_8c6516:
	mov_s r2,0x1006f1c
L_8c651c:
	mov_s r1,0x1445
L_8c6522:
	bl.d L_8c82c0
L_8c6526:
	mov_s r3,0x27
L_8c6528:
	b_s L_8c6536
	.global L_8c652a
L_8c652a:
	bl.d L_8c8ca0
L_8c652e:
	mov_s r0,r14
L_8c6530:
	ld_s r1,[r14,0x4]
L_8c6532:
	ld.as r13,[r1,r0]
	.global L_8c6536
L_8c6536:
	b.d L_8c0334
L_8c653a:
	mov_s r0,r13
