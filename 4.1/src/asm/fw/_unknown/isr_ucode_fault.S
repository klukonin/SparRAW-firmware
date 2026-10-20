/* isr_ucode_fault @ 0x8c1130, 316 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Awake TSF interrupt expired! TSF: 0x%08x:%08x
 *   LMAC CRASH detected !!!
 *   UCODE :: SYSASSERT_CODE_0x%x curr_blink=0x%X
 *   UCODE :: SYSTEM FATAL CRASH1: sp=0x%08X, ilink1=0x%X, ilink2=0x%X
 *   interrupt_handlers.c
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, fw_log__emit0, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, mac_read_tsf64, set_reg_886e50
 */
	.section .text.isr_ucode_fault,"ax",@progbits
	.global isr_ucode_fault
isr_ucode_fault:
L_8c1130:
	push_s r12
L_8c1132:
	st.a mhi,[sp,-0x4]
L_8c1136:
	st.a mlo,[sp,-0x4]
L_8c113a:
	push_s r0
L_8c113c:
	push_s r1
L_8c113e:
	push_s r2
L_8c1140:
	push_s r3
L_8c1142:
	st.a r4,[sp,-0x4]
L_8c1146:
	st.a r5,[sp,-0x4]
L_8c114a:
	st.a r6,[sp,-0x4]
L_8c114e:
	st.a r7,[sp,-0x4]
L_8c1152:
	st.a r8,[sp,-0x4]
L_8c1156:
	st.a r9,[sp,-0x4]
L_8c115a:
	st.a r10,[sp,-0x4]
L_8c115e:
	st.a r11,[sp,-0x4]
L_8c1162:
	push_s r13
L_8c1164:
	st.a lp_count,[sp,-0x4]
L_8c1168:
	lr r12,[0x2]
L_8c116c:
	push_s r12
L_8c116e:
	lr r12,[0x3]
L_8c1172:
	push_s r12
L_8c1174:
	push_s blink
L_8c1176:
	sub_s sp,sp,0x8
L_8c1178:
	bl.d L_8c7460
L_8c117c:
	mov_s r0,0x4
L_8c117e:
	mov_s r13,0x886e00
L_8c1184:
	ld_s r0,[r13,0x44]
L_8c1186:
	st_s r0,[r13,0x40]
L_8c1188:
	bbit0 r0,0xf,L_8c11b0
L_8c118c:
	bl L_8e49d4
L_8c1190:
	mov_s r1,sp
L_8c1192:
	mov_s r0,0x0
L_8c1194:
	bl.d L_8e4840
L_8c1198:
	mov_s r2,r0
L_8c119a:
	mov_s r2,0x1000528
L_8c11a0:
	ld r4,[sp]
L_8c11a4:
	mov_s r0,0x0
L_8c11a6:
	mov_s r1,0x2
L_8c11a8:
	bl.d L_8edff8
L_8c11ac:
	ld_s r3,[sp,0x4]
L_8c11ae:
	b_s L_8c1216
	.global L_8c11b0
L_8c11b0:
	mov_s r2,0x1000558
L_8c11b6:
	mov_s r0,0x0
L_8c11b8:
	bl.d L_8edfb0
L_8c11bc:
	mov_s r1,r0
L_8c11be:
	mov_s r0,0x40
L_8c11c0:
	st_s r0,[r13,0x50]
L_8c11c2:
	mov_s r2,0x1000570
L_8c11c8:
	mov_s r3,0x857000
L_8c11ce:
	ld r4,[r3, 0x2c]
L_8c11d2:
	mov_s r0,0x0
L_8c11d4:
	mov_s r1,r0
L_8c11d6:
	bl.d L_8edff8
L_8c11da:
	ld_s r3,[r3,0x28]
L_8c11dc:
	mov_s r0,0x886f00
L_8c11e2:
	ld_s r3,[r0,0x4c]
L_8c11e4:
	mov_s r2,0x10005a0
L_8c11ea:
	ld r4,[r0, 0x50]
L_8c11ee:
	ld r5,[r0, 0x54]
L_8c11f2:
	mov_s r0,0x0
L_8c11f4:
	bl.d L_8ee034
L_8c11f8:
	mov_s r1,r0
L_8c11fa:
	mov_s r0,0x1
L_8c11fc:
	st.as r0,[gp,-0x47]
L_8c1200:
	mov_s r0,blink
L_8c1202:
	mov_s r2,0x1000250
L_8c1208:
	mov_s r1,0x11ac
L_8c120e:
	bl.d L_8c82c0
L_8c1212:
	mov r3,0x2b1
	.global L_8c1216
L_8c1216:
	add_s sp,sp,0x8
L_8c1218:
	pop_s blink
L_8c121a:
	pop_s r12
L_8c121c:
	sr r12,[0x3]
L_8c1220:
	pop_s r12
L_8c1222:
	sr r12,[0x2]
L_8c1226:
	pop_s r12
L_8c1228:
	mov_s lp_count,r12
L_8c122a:
	pop_s r13
L_8c122c:
	ld.ab r11,[sp,0x4]
L_8c1230:
	ld.ab r10,[sp,0x4]
L_8c1234:
	ld.ab r9,[sp,0x4]
L_8c1238:
	ld.ab r8,[sp,0x4]
L_8c123c:
	ld.ab r7,[sp,0x4]
L_8c1240:
	ld.ab r6,[sp,0x4]
L_8c1244:
	ld.ab r5,[sp,0x4]
L_8c1248:
	ld.ab r4,[sp,0x4]
L_8c124c:
	pop_s r3
L_8c124e:
	pop_s r2
L_8c1250:
	pop_s r1
L_8c1252:
	pop_s r0
L_8c1254:
	pop_s r12
L_8c1256:
	mulu64 r12,0x1
L_8c125a:
	mov 0x0,mlo
L_8c125e:
	pop_s r12
L_8c1260:
	sr r12,[0x12]
L_8c1264:
	pop_s r12
L_8c1266:
	j.f [ilink1]
L_8c126a:
	nop_s
