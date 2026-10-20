/* uc_isr_l1_task3 @ 0x928a9c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l1_task__entry
 */
	.section .text.uc_isr_l1_task3,"ax",@progbits
	.global uc_isr_l1_task3
uc_isr_l1_task3:
L_928a9c:
	push_s r12
L_928a9e:
	st.a mhi,[sp,-0x4]
L_928aa2:
	st.a mlo,[sp,-0x4]
L_928aa6:
	push_s r0
L_928aa8:
	push_s r1
L_928aaa:
	push_s r2
L_928aac:
	push_s r3
L_928aae:
	st.a r4,[sp,-0x4]
L_928ab2:
	st.a r5,[sp,-0x4]
L_928ab6:
	st.a r6,[sp,-0x4]
L_928aba:
	st.a r7,[sp,-0x4]
L_928abe:
	st.a r8,[sp,-0x4]
L_928ac2:
	st.a r9,[sp,-0x4]
L_928ac6:
	st.a r10,[sp,-0x4]
L_928aca:
	st.a r11,[sp,-0x4]
L_928ace:
	st.a lp_count,[sp,-0x4]
L_928ad2:
	lr r12,[0x2]
L_928ad6:
	push_s r12
L_928ad8:
	lr r12,[0x3]
L_928adc:
	push_s r12
L_928ade:
	push_s blink
L_928ae0:
	bl.d L_929738
