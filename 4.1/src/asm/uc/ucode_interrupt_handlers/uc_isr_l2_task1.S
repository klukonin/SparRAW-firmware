/* uc_isr_l2_task1 @ 0x921180, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_isr_l2_task1,"ax",@progbits
	.global uc_isr_l2_task1
uc_isr_l2_task1:
L_921180:
	push_s r12
L_921182:
	st.a mhi,[sp,-0x4]
L_921186:
	st.a mlo,[sp,-0x4]
L_92118a:
	push_s r0
L_92118c:
	push_s r1
L_92118e:
	push_s r2
L_921190:
	push_s r3
L_921192:
	st.a r4,[sp,-0x4]
L_921196:
	.byte 0xfc,0x1c
