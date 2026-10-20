/* hw__has_cause_880b54 @ 0x8d478c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw__has_cause_880b54
hw__has_cause_880b54:
	.global L_8d478c
L_8d478c:
	mov_s r0,0x880b00
L_8d4792:
	ld_s r0,[r0,0x54]
L_8d4794:
	sub.f r0,r0,0x0
L_8d4798:
	j_s.d [blink]
L_8d479a:
	mov.ne r0,0x1
L_8d479e:
	nop_s
