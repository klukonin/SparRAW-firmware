/* uc_isr_memory_error @ 0x921548, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ucode_interrupt_handlers.c
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_isr_memory_error,"ax",@progbits
	.global uc_isr_memory_error
uc_isr_memory_error:
L_921548:
	mov_s r0,blink
L_92154a:
	mov_s r2,0x10000fc
L_921550:
	mov_s r1,0x22
L_921552:
	b.d L_925548
L_921556:
	mov_s r3,0x1b
