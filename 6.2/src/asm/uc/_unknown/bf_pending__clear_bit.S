/* bf_pending__clear_bit @ 0x921750, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__dispatch, boot_uc__init_tail
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_pending__clear_bit
bf_pending__clear_bit:
	.global L_921750
L_921750:
	mov_s r2,0x800648
L_921756:
	ld_s r1,[r2]
L_921758:
	bclr r1,r1,r0
L_92175c:
	st_s r1,[r2]
L_92175e:
	j_s [blink]
