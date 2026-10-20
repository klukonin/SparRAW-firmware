/* rw_g_800630_921fb0 @ 0x921fb0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__dispatch, background_task__step
 */
	.section .text.rw_g_800630_921fb0,"ax",@progbits
	.global rw_g_800630_921fb0
rw_g_800630_921fb0:
	.global L_921fb0
L_921fb0:
	mov_s r2,0x800630
L_921fb6:
	ld_s r1,[r2]
L_921fb8:
	bclr r1,r1,r0
L_921fbc:
	st_s r1,[r2]
L_921fbe:
	j_s [blink]
