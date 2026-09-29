/* isr_awake_tsf_led @ 0x8c1000, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: isr_880b50__dispatch_causes
 */
	.section .text.isr_awake_tsf_led,"ax",@progbits
	.global isr_awake_tsf_led
isr_awake_tsf_led:
L_8c1000:
	push_s r12
L_8c1002:
	st.a mhi,[sp,-0x4]
L_8c1006:
	st.a mlo,[sp,-0x4]
L_8c100a:
	push_s r0
L_8c100c:
	push_s r1
L_8c100e:
	push_s r2
L_8c1010:
	push_s r3
L_8c1012:
	st.a r4,[sp,-0x4]
L_8c1016:
	st.a r5,[sp,-0x4]
L_8c101a:
	st.a r6,[sp,-0x4]
L_8c101e:
	st.a r7,[sp,-0x4]
L_8c1022:
	st.a r8,[sp,-0x4]
L_8c1026:
	st.a r9,[sp,-0x4]
L_8c102a:
	st.a r10,[sp,-0x4]
L_8c102e:
	st.a r11,[sp,-0x4]
L_8c1032:
	st.a lp_count,[sp,-0x4]
L_8c1036:
	lr r12,[0x2]
L_8c103a:
	push_s r12
L_8c103c:
	lr r12,[0x3]
L_8c1040:
	push_s r12
L_8c1042:
	push_s blink
L_8c1044:
	bl L_8c15e8
L_8c1048:
	pop_s blink
L_8c104a:
	pop_s r12
L_8c104c:
	sr r12,[0x3]
L_8c1050:
	pop_s r12
L_8c1052:
	sr r12,[0x2]
L_8c1056:
	pop_s r12
L_8c1058:
	mov_s lp_count,r12
L_8c105a:
	ld.ab r11,[sp,0x4]
L_8c105e:
	ld.ab r10,[sp,0x4]
L_8c1062:
	ld.ab r9,[sp,0x4]
L_8c1066:
	ld.ab r8,[sp,0x4]
L_8c106a:
	ld.ab r7,[sp,0x4]
L_8c106e:
	ld.ab r6,[sp,0x4]
L_8c1072:
	ld.ab r5,[sp,0x4]
L_8c1076:
	ld.ab r4,[sp,0x4]
L_8c107a:
	pop_s r3
L_8c107c:
	pop_s r2
L_8c107e:
	pop_s r1
L_8c1080:
	pop_s r0
L_8c1082:
	pop_s r12
L_8c1084:
	mulu64 r12,0x1
L_8c1088:
	mov 0x0,mlo
L_8c108c:
	pop_s r12
L_8c108e:
	sr r12,[0x12]
L_8c1092:
	pop_s r12
L_8c1094:
	j.f [ilink1]
