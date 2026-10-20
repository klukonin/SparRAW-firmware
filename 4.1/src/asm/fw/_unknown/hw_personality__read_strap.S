/* hw_personality__read_strap @ 0x8d1578, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_personality_detect
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r13_ret
 */
	.section .text.hw_personality__read_strap,"ax",@progbits
	.global hw_personality__read_strap
hw_personality__read_strap:
	.global L_8d1578
L_8d1578:
	push_s blink
L_8d157a:
	push_s r13
L_8d157c:
	bl.d L_8d14a8
L_8d1580:
	mov_s r13,r0
L_8d1582:
	mov_s r0,0x880b00
L_8d1588:
	ld_s r1,[r0,0x7c]
L_8d158a:
	mov_s r0,0x0
L_8d158c:
	bset r0,r0,r13
L_8d1590:
	and_s r0,r0,r1
L_8d1592:
	b.d L_8c033c
L_8d1596:
	lsr_s r0,r0,r13
