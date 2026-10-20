/* hw_880b60__set_and_schedule @ 0x8cb488, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: u_schd__add
 */
	.section .text.hw_880b60__set_and_schedule,"ax",@progbits
	.global hw_880b60__set_and_schedule
hw_880b60__set_and_schedule:
	.global L_8cb488
L_8cb488:
	mov r1,0x200
L_8cb48c:
	mov_s r0,0x880b00
L_8cb492:
	st_s r1,[r0,0x60]
L_8cb494:
	mov_s r0,0x87b0
L_8cb49a:
	mov_s r1,0x0
L_8cb49c:
	mov_s r2,r1
L_8cb49e:
	b.d L_8c2ac8
L_8cb4a2:
	mov_s r3,0x1
