/* mbox__build_rings_and_pool @ 0x8f1104, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mbox__debug_init_flow, operational_if__mbox_init
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, mem_pool__init, ring__init_desc
 */
	.section .text.mbox__build_rings_and_pool,"ax",@progbits
	.global mbox__build_rings_and_pool
mbox__build_rings_and_pool:
	.global L_8f1104
L_8f1104:
	push_s blink
L_8f1106:
	bl L_8c02ac
L_8f110a:
	mov_s r14,r0
L_8f110c:
	mov_s r13,r1
L_8f110e:
	mov_s r19,r2
L_8f1110:
	mov_s r15,r3
L_8f1112:
	mov_s r1,r4
L_8f1114:
	mov r16,r5
L_8f1118:
	asl r17,r6,0x3
L_8f111c:
	asl r18,r7,0x3
L_8f1120:
	st_s r2,[r13]
L_8f1122:
	st_s r2,[r13,0x8]
L_8f1124:
	st_s r2,[r13,0xc]
L_8f1126:
	ld_s r2,[sp,0x2c]
L_8f1128:
	stw r17,[r13, 0x6]
L_8f112c:
	stw_s r2,[r13,0x4]
L_8f112e:
	add3 r20,r0,0x9
L_8f1132:
	mov_s r0,r20
L_8f1134:
	bl.d L_8c6c70
L_8f1138:
	ld_s r3,[sp,0x24]
L_8f113a:
	add r0,r14,0x24
L_8f113e:
	mov_s r1,r19
L_8f1140:
	mov_s r2,r17
L_8f1142:
	mov_s r3,r13
L_8f1144:
	mov r4,r20
L_8f1148:
	mov r5,0x1
L_8f114c:
	bl.d L_8d5898
L_8f1150:
	mov r6,r5
L_8f1154:
	mov r0,0x510
L_8f1158:
	st_s r15,[r13,0x10]
L_8f115a:
	st_s r15,[r13,0x18]
L_8f115c:
	st_s r15,[r13,0x1c]
L_8f115e:
	stw r18,[r13, 0x16]
L_8f1162:
	stw_s r0,[r13,0x14]
L_8f1164:
	add2 r17,r14,0x17
L_8f1168:
	ld_s r2,[sp,0x30]
L_8f116a:
	mov_s r0,r17
L_8f116c:
	mov_s r1,r16
L_8f116e:
	bl.d L_8c6c70
L_8f1172:
	ld_s r3,[sp,0x28]
L_8f1174:
	add r16,r14,0x4
L_8f1178:
	add r3,r13,0x10
L_8f117c:
	mov_s r0,r16
L_8f117e:
	mov_s r1,r15
L_8f1180:
	mov_s r2,r18
L_8f1182:
	mov r4,r17
L_8f1186:
	mov r5,0x0
L_8f118a:
	bl.d L_8d5898
L_8f118e:
	mov r6,0x1
L_8f1192:
	mov_s r1,0x9428
L_8f1198:
	st r1,[r16, 0x18]
L_8f119c:
	mov_s r1,0x94c4
L_8f11a2:
	st r1,[r16, 0x1c]
L_8f11a6:
	ld_s r0,[r14,0x44]
L_8f11a8:
	ld_s r1,[r0,0x8]
L_8f11aa:
	jl_s.d [r1]
L_8f11ac:
	mov_s r0,r14
L_8f11ae:
	b L_8c0304
L_8f11b2:
	nop_s
