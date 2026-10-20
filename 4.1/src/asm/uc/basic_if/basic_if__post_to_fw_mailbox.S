/* basic_if__post_to_fw_mailbox @ 0x930150, 324 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_if.cpp
 * Зовут его: uc_send_event
 * Зовёт сам: mailbox__free_space, mailbox_debug_dump__2, uc_mailbox__advance, uc_sysassert
 */
	.section .text.basic_if__post_to_fw_mailbox,"ax",@progbits
	.global basic_if__post_to_fw_mailbox
basic_if__post_to_fw_mailbox:
	.global L_930150
L_930150:
	st.a r13,[sp,-0x2c]
L_930154:
	st blink,[sp, 0x4]
L_930158:
	st_s r14,[sp,0x8]
L_93015a:
	st_s r15,[sp,0xc]
L_93015c:
	st r16,[sp, 0x10]
L_930160:
	st r17,[sp, 0x14]
L_930164:
	st r18,[sp, 0x18]
L_930168:
	st r19,[sp, 0x1c]
L_93016c:
	st r20,[sp, 0x20]
L_930170:
	st r21,[sp, 0x24]
L_930174:
	st r22,[sp, 0x28]
L_930178:
	mov_s r16,r0
L_93017a:
	mov.f r13,r1
L_93017e:
	mov_s r19,r2
L_930180:
	mov_s r18,r3
L_930182:
	mov r17,r4
L_930186:
	mov r22,r5
L_93018a:
	mov_s r14,r6
L_93018c:
	beq.d L_930260
L_930190:
	mov r15,r7
	.global L_930194
L_930194:
	add r20,r16,0x4
L_930198:
	bl.d L_929004
L_93019c:
	mov r0,r20
L_9301a0:
	brne r0,0x0,L_9301c0
L_9301a4:
	bl.d L_929f54
L_9301a8:
	mov r0,r20
L_9301ac:
	mov_s r0,blink
L_9301ae:
	mov_s r2,0x1001164
L_9301b4:
	mov r1,0xc4
L_9301b8:
	bl.d L_925548
L_9301bc:
	mov r3,0x3b
	.global L_9301c0
L_9301c0:
	sub r13,r13,0x10
L_9301c4:
	stw r19,[r13, 0x4]
L_9301c8:
	ldw.x r6,[r16]
L_9301cc:
	mov r19,0x0
L_9301d0:
	stw r6,[r13]
L_9301d4:
	stb r19,[r13, 0x6]
L_9301d8:
	ld r21,[r20, 0xc]
L_9301dc:
	ldw r4,[r21, 0x4]
L_9301e0:
	brge r4,r17,L_9301e8
L_9301e4:
	breq r14,0x0,L_930278
	.global L_9301e8
L_9301e8:
	stw r17,[r13, 0x2]
L_9301ec:
	stb r17,[r13, 0x7]
L_9301f0:
	stb r22,[r13, 0x8]
L_9301f4:
	stb r19,[r13, 0x9]
L_9301f8:
	stw r18,[r13, 0xa]
L_9301fc:
	st r19,[r13, 0xc]
L_930200:
	bmsk_s r14,r14,0x0
L_930202:
	asl_s r3,r14
L_930204:
	ldw r7,[r13, 0x6]
L_930208:
	bmsk_s r15,r15,0x0
L_93020a:
	/* asl_s r15,r15,0x2 */
	.byte 0x02,0xbf
L_93020c:
	bic r2,r7,0x6
L_930210:
	bclr_s r3,r3,0x2
L_930212:
	or_s r2,r2,r3
L_930214:
	or_s r15,r15,r2
L_930216:
	stw_s r15,[r13,0x6]
L_930218:
	ldw.x r1,[r16]
L_93021c:
	mov_s r0,r20
L_93021e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_930220:
	stw r1,[r16]
L_930224:
	bl.d L_9258f4
L_930228:
	mov r1,r13
L_93022c:
	ld r5,[r20]
L_930230:
	ld blink,[sp, 0x4]
L_930234:
	st r5,[r21, 0xc]
L_930238:
	ld_s r14,[sp,0x8]
L_93023a:
	ld_s r15,[sp,0xc]
L_93023c:
	ld r16,[sp, 0x10]
L_930240:
	ld r17,[sp, 0x14]
L_930244:
	ld r18,[sp, 0x18]
L_930248:
	ld r19,[sp, 0x1c]
L_93024c:
	ld r20,[sp, 0x20]
L_930250:
	ld r21,[sp, 0x24]
L_930254:
	ld r22,[sp, 0x28]
L_930258:
	j.d [blink]
L_93025c:
	ld.ab r13,[sp,0x2c]
	.global L_930260
L_930260:
	mov_s r0,blink
L_930262:
	mov_s r2,0x1001164
L_930268:
	mov r1,0xc3
L_93026c:
	bl.d L_925548
L_930270:
	mov r3,0x37
L_930274:
	b L_930194
	.global L_930278
L_930278:
	brne r15,0x0,L_9301e8
L_93027c:
	mov_s r0,blink
L_93027e:
	mov_s r2,0x1001164
L_930284:
	mov r1,0xc5
L_930288:
	bl.d L_925548
L_93028c:
	mov r3,0x4c
L_930290:
	b_s L_9301e8
L_930292:
	nop_s
