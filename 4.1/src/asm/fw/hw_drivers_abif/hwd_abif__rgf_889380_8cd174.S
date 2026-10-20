/* hwd_abif__rgf_889380_8cd174 @ 0x8cd174, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: rf__configure_chain
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_889380_8cd174,"ax",@progbits
	.global hwd_abif__rgf_889380_8cd174
hwd_abif__rgf_889380_8cd174:
	.global L_8cd174
L_8cd174:
	push_s blink
L_8cd176:
	bl L_8c02c4
L_8cd17a:
	mov_s r13,r1
L_8cd17c:
	mov_s r14,0x889380
L_8cd182:
	st_s r0,[r14,0x1c]
L_8cd184:
	bic.f r1,r1,0x1f
L_8cd188:
	bne_s L_8cd198
	.global L_8cd18a
L_8cd18a:
	ld_s r0,[r14,0x18]
L_8cd18c:
	bic r0,r0,0x1f
L_8cd190:
	or_s r13,r13,r0
L_8cd192:
	st_s r13,[r14,0x18]
L_8cd194:
	b L_8c0334
	.global L_8cd198
L_8cd198:
	mov_s r0,blink
L_8cd19a:
	mov_s r2,0x1019954
L_8cd1a0:
	mov_s r1,0xac
L_8cd1a2:
	mov_s r3,0x25
L_8cd1a4:
	bl.d L_8c82c0
L_8cd1a8:
	bset_s r3,r3,0xb
L_8cd1aa:
	b_s L_8cd18a
