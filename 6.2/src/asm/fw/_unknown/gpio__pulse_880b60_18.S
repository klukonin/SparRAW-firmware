/* gpio__pulse_880b60_18 @ 0x8cd724, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global gpio__pulse_880b60_18
gpio__pulse_880b60_18:
	.global L_8cd724
L_8cd724:
	mov_s r0,0x880b00
L_8cd72a:
	st 0x40000,[r0, 0x60]
L_8cd732:
	mov_s r0,0x2378c
L_8cd738:
	mov_s r1,0x0
L_8cd73a:
	mov_s r2,r1
L_8cd73c:
	b.d L_8c3248
L_8cd740:
	mov_s r3,0x1
L_8cd742:
	nop_s
