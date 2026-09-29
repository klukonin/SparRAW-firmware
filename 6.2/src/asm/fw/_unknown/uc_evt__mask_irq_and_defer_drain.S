/* uc_evt__mask_irq_and_defer_drain @ 0x8cd864, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_880b50__dispatch_causes
 * Зовёт сам: u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global uc_evt__mask_irq_and_defer_drain
uc_evt__mask_irq_and_defer_drain:
	.global L_8cd864
L_8cd864:
	mov r1,0x200
L_8cd868:
	mov_s r0,0x880b00
L_8cd86e:
	st_s r1,[r0,0x60]
L_8cd870:
	mov_s r0,L_8ca22c-0x8c0000
L_8cd876:
	mov_s r1,0x0
L_8cd878:
	mov_s r2,r1
L_8cd87a:
	b.d L_8c3248
L_8cd87e:
	mov_s r3,0x1
