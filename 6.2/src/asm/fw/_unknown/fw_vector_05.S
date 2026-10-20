/* fw_vector_05 @ 0x8c10fc, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: txrx_mgr__handle_dma_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_05
fw_vector_05:
	.global L_8c10fc
L_8c10fc:
	push_s r12
L_8c10fe:
	st.a mhi,[sp,-0x4]
L_8c1102:
	st.a mlo,[sp,-0x4]
L_8c1106:
	push_s r0
L_8c1108:
	push_s r1
L_8c110a:
	push_s r2
L_8c110c:
	push_s r3
L_8c110e:
	st.a r4,[sp,-0x4]
L_8c1112:
	st.a r5,[sp,-0x4]
L_8c1116:
	st.a r6,[sp,-0x4]
L_8c111a:
	st.a r7,[sp,-0x4]
L_8c111e:
	st.a r8,[sp,-0x4]
L_8c1122:
	st.a r9,[sp,-0x4]
L_8c1126:
	st.a r10,[sp,-0x4]
L_8c112a:
	st.a r11,[sp,-0x4]
L_8c112e:
	st.a lp_count,[sp,-0x4]
L_8c1132:
	lr r12,[0x2]
L_8c1136:
	push_s r12
L_8c1138:
	lr r12,[0x3]
L_8c113c:
	push_s r12
L_8c113e:
	push_s blink
L_8c1140:
	bl L_8c9604
L_8c1144:
	pop_s blink
L_8c1146:
	pop_s r12
L_8c1148:
	sr r12,[0x3]
L_8c114c:
	pop_s r12
L_8c114e:
	sr r12,[0x2]
L_8c1152:
	pop_s r12
L_8c1154:
	mov_s lp_count,r12
L_8c1156:
	ld.ab r11,[sp,0x4]
L_8c115a:
	ld.ab r10,[sp,0x4]
L_8c115e:
	ld.ab r9,[sp,0x4]
L_8c1162:
	ld.ab r8,[sp,0x4]
L_8c1166:
	ld.ab r7,[sp,0x4]
L_8c116a:
	ld.ab r6,[sp,0x4]
L_8c116e:
	ld.ab r5,[sp,0x4]
L_8c1172:
	ld.ab r4,[sp,0x4]
L_8c1176:
	pop_s r3
L_8c1178:
	pop_s r2
L_8c117a:
	pop_s r1
L_8c117c:
	pop_s r0
L_8c117e:
	pop_s r12
L_8c1180:
	mulu64 r12,0x1
L_8c1184:
	mov 0x0,mlo
L_8c1188:
	pop_s r12
L_8c118a:
	sr r12,[0x12]
L_8c118e:
	pop_s r12
L_8c1190:
	j.f [ilink1]
