/* uc_select_m2_or_1 @ 0x921158, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_select_m2_or_1,"ax",@progbits
	.global uc_select_m2_or_1
uc_select_m2_or_1:
L_921158:
	mov.f 0x0,r0
L_92115c:
	mov r0,-0x2
L_921160:
	mov.mi r0,0x1
L_921164:
	j_s.d [blink]
L_921166:
	.byte 0x2f,0x20
