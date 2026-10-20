/* mac__read_counter_886d64 @ 0x8e47f4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: psc__read_mac_counters
 * Зовёт сам: __ld_r13_ret, mac__wait_counter_ready
 */
	.section .text.mac__read_counter_886d64,"ax",@progbits
	.global mac__read_counter_886d64
mac__read_counter_886d64:
	.global L_8e47f4
L_8e47f4:
	push_s blink
L_8e47f6:
	push_s r13
L_8e47f8:
	bl.d L_8e47d0
L_8e47fc:
	mov_s r13,r1
L_8e47fe:
	mov_s r0,0x886d00
L_8e4804:
	ld_s r0,[r0,0x64]
L_8e4806:
	ld_s r2,[r13]
L_8e4808:
	extw_s r0,r0
L_8e480a:
	asl r3,r0,0xa
L_8e480e:
	add.f r2,r2,r3
L_8e4812:
	ld_s r1,[r13,0x4]
L_8e4814:
	mov_s r0,0x0
L_8e4816:
	adc r0,r0,r1
L_8e481a:
	st_s r2,[r13]
L_8e481c:
	b.d L_8c033c
L_8e4820:
	st_s r0,[r13,0x4]
L_8e4822:
	nop_s
