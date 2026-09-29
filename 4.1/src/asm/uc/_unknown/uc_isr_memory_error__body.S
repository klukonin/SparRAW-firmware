/* uc_isr_memory_error__body @ 0x921558, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: memset0_words_uc, uc_main_init
 */
	.section .text.uc_isr_memory_error__body,"ax",@progbits
	.global uc_isr_memory_error__body
uc_isr_memory_error__body:
L_921558:
	push_s blink
L_92155a:
	ld.as r3,[gp,-0x38]
L_92155e:
	breq_s r3,0,L_921588
L_921560:
	mov_s r0,0x800ef4
L_921566:
	mov_s r1,0x80209c
L_92156c:
	bl.d L_92166c
L_921570:
	sub r1,r1,r0
L_921574:
	/* mov_s r0,0x0 */
	.byte 0xcf,0x70,0x00,0x00,0x00,0x00
L_92157a:
	/* mov_s r1,0x0 */
	.byte 0xcf,0x71,0x00,0x00,0x00,0x00
L_921580:
	bl.d L_92166c
L_921584:
	sub r1,r1,r0
	.global L_921588
L_921588:
	mov r2,0x0
L_92158c:
	stb r2,[gp, -0x100]
L_921590:
	/* jl 0x114 */
	.byte 0x22,0x20,0x80,0x0f,0x00,0x00,0x14,0x01
L_921598:
	bl L_92160c
