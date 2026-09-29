/* uc_isr_instruction_error @ 0x921170, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ucode_interrupt_handlers.c
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_isr_instruction_error,"ax",@progbits
	.global uc_isr_instruction_error
uc_isr_instruction_error:
L_921170:
	mov_s r0,blink
L_921172:
	mov_s r2,0x10000fc
L_921178:
	mov_s r1,0x23
L_92117a:
	b.d L_925548
L_92117e:
	mov_s r3,0x20
