/* psc__inject_disassoc_evt @ 0x8c5bf0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__disassoc_ntf
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.psc__inject_disassoc_evt,"ax",@progbits
	.global psc__inject_disassoc_evt
psc__inject_disassoc_evt:
	.global L_8c5bf0
L_8c5bf0:
	ld r1,[r0, 0x94]
L_8c5bf4:
	cmp_s r1,0x0
L_8c5bf6:
	mov_s r1,0x5
L_8c5bf8:
	add2.eq r0,r0,0x11
L_8c5bfc:
	mov.eq r1,0x6
L_8c5c00:
	mov_s r2,0x0
L_8c5c02:
	mov_s r3,r2
L_8c5c04:
	b.d L_8d6a1c
L_8c5c08:
	mov_s r4,r2
L_8c5c0a:
	nop_s
