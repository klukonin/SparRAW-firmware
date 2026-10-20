/* direct_tx__send_ctrl_frame @ 0x9362b8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__tx_ctrl_frame
 * Зовёт сам: direct_tx__send_from_desc, frame_hdr__init
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx__send_ctrl_frame
direct_tx__send_ctrl_frame:
	.global L_9362b8
L_9362b8:
	st.a r13,[sp,-0x10]
L_9362bc:
	st blink,[sp, 0x4]
L_9362c0:
	st_s r14,[sp,0x8]
L_9362c2:
	st_s r15,[sp,0xc]
L_9362c4:
	sub_s sp,sp,0x18
L_9362c6:
	mov_s r14,r0
L_9362c8:
	mov_s r15,sp
L_9362ca:
	mov_s r0,r15
L_9362cc:
	mov_s r13,0x1
L_9362ce:
	mov_s r1,r13
L_9362d0:
	mov r2,r13
L_9362d4:
	bl.d L_9246fc
L_9362d8:
	mov r3,r14
L_9362dc:
	ldb r5,[gp, -0xec]
L_9362e0:
	mov_s r0,r15
L_9362e2:
	ldb_s r1,[r14,0x2]
L_9362e4:
	mov_s r14,0x0
L_9362e6:
	mov_s r2,r14
L_9362e8:
	mov_s r3,r14
L_9362ea:
	mov_s r4,r14
L_9362ec:
	bl.d L_93869c
L_9362f0:
	mov r6,0x17
L_9362f4:
	cmp r0,0x0
L_9362f8:
	beq.d L_93630c
L_9362fc:
	mov.eq r13,r14
L_936300:
	mov_s r2,0x8022c8
L_936306:
	ld_s r0,[r2,0x30]
L_936308:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93630a:
	st_s r0,[r2,0x30]
	.global L_93630c
L_93630c:
	mov_s r0,r13
L_93630e:
	add_s sp,sp,0x18
L_936310:
	ld blink,[sp, 0x4]
L_936314:
	ld_s r14,[sp,0x8]
L_936316:
	ld_s r15,[sp,0xc]
L_936318:
	j.d [blink]
L_93631c:
	ld.ab r13,[sp,0x10]
