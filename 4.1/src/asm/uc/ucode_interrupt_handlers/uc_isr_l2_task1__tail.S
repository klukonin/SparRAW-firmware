/* uc_isr_l2_task1__tail @ 0x921204, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_isr_l2_task1__tail,"ax",@progbits
	.global uc_isr_l2_task1__tail
uc_isr_l2_task1__tail:
L_921204:
	pop_s r12
L_921206:
	mulu64 r12,0x1
L_92120a:
	mov 0x0,mlo
L_92120e:
	pop_s r12
L_921210:
	sr r12,[0x12]
L_921214:
	pop_s r12
L_921216:
	.byte 0x20,0x20
