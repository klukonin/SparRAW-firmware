/* background_task__step @ 0x921e14, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_main_init
 * Зовёт сам: bf_sm__background_step, rw_g_800630_921fb0
 */
	.section .text.background_task__step,"ax",@progbits
	.global background_task__step
background_task__step:
	.global L_921e14
L_921e14:
	/* b_s 0x00921e2e */
	.byte 0x0d,0xf0
	.global sub_921e16
sub_921e16:
L_921e16:
	bl.d L_921fb0
L_921e1a:
	mov_s r0,0x0
L_921e1c:
	bl L_9225ec
