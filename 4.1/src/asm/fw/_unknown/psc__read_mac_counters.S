/* psc__read_mac_counters @ 0x8c98a8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__psc_complete
 * Зовёт сам: __ld_r13_ret, get_reg_886d00_8e47a8, get_reg_886e80_8e4824, mac__read_counter_886d64
 */
	.section .text.psc__read_mac_counters,"ax",@progbits
	.global psc__read_mac_counters
psc__read_mac_counters:
	.global L_8c98a8
L_8c98a8:
	push_s blink
L_8c98aa:
	push_s r13
L_8c98ac:
	sub_s sp,sp,0x8
L_8c98ae:
	mov_s r13,r1
L_8c98b0:
	mov_s r1,sp
L_8c98b2:
	mov_s r0,0x0
L_8c98b4:
	bl.d L_8e47f4
L_8c98b8:
	mov_s r2,r0
L_8c98ba:
	brne_s r13,0,L_8c98ce
L_8c98bc:
	bl.d L_8e4824
L_8c98c0:
	mov_s r0,0x0
L_8c98c2:
	brhs 0x4e20,r0,L_8c98ce
L_8c98ca:
	ld_s r0,[sp,0x0]
L_8c98cc:
	b_s L_8c98d8
	.global L_8c98ce
L_8c98ce:
	bl L_8e47a8
L_8c98d2:
	ld_s r1,[sp,0x0]
L_8c98d4:
	asl_s r0,r0,0xa
L_8c98d6:
	add_s r0,r0,r1
	.global L_8c98d8
L_8c98d8:
	b.d L_8c033c
