/* bi_cfg__apply @ 0x9331d8, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_bi_cfg__apply
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, bi_cfg__fill_slot_desc, txrx_api_cmd_step
 * Глобалы (через gp): 0x8005a8, 0x8005ac
 */
	.section .text.bi_cfg__apply,"ax",@progbits
	.global bi_cfg__apply
bi_cfg__apply:
	.global L_9331d8
L_9331d8:
	push_s blink
L_9331da:
	bl L_92020c
L_9331de:
	sub_s sp,sp,0x50
L_9331e0:
	cmp_s r0,0x0
L_9331e2:
	mov_s r13,0x801438
L_9331e8:
	ld_s r0,[r13,0x14]
L_9331ea:
	mov r16,0x80142c
L_9331f2:
	lsr_s r3,r0
L_9331f4:
	lsr r15,r0,0x2
L_9331f8:
	bmsk r14,r0,0x0
L_9331fc:
	lsr_s r0,r0,0x3
L_9331fe:
	ldb r1,[r16, 0x3]
L_933202:
	bmsk_s r3,r3,0x0
L_933204:
	ldb r6,[r13, 0xa]
L_933208:
	bmsk_s r15,r15,0x0
L_93320a:
	ldb r4,[r13, 0x7]
L_93320e:
	bmsk r2,r0,0x0
L_933212:
	ldb r8,[r13, 0x9]
L_933216:
	ldb r7,[r13, 0x4]
L_93321a:
	ldb r5,[r13, 0x5]
L_93321e:
	asl_s r3,r3
L_933220:
	or_s r14,r14,r3
L_933222:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_933224:
	or_s r14,r14,r1
L_933226:
	asl r1,r6,0x7
L_93322a:
	or_s r1,r1,r14
L_93322c:
	asl r0,r4,0xa
L_933230:
	or_s r0,r0,r1
L_933232:
	asl_s r15,r15,0x13
L_933234:
	or_s r15,r15,r0
L_933236:
	asl r0,r2,0x14
L_93323a:
	or_s r0,r0,r15
L_93323c:
	st.as r0,[gp,0x20]
L_933240:
	asl r0,r7,0x7
L_933244:
	or r0,r0,r8
L_933248:
	asl r1,r5,0x11
L_93324c:
	or_s r0,r0,r1
L_93324e:
	asl_s r2,r2,0x17
L_933250:
	or_s r0,r0,r2
L_933252:
	st.as r0,[gp,0x21]
L_933256:
	beq_s L_93327a
L_933258:
	ld_s r0,[sp,0x40]
L_93325a:
	st 0x19000,[sp, 0x48]
L_933262:
	bset_s r0,r0,0x0
L_933264:
	st_s r0,[sp,0x40]
L_933266:
	mov_s r0,0x0
L_933268:
	st_s r0,[sp,0x30]
L_93326a:
	st_s r0,[sp,0x34]
L_93326c:
	bl.d L_931ce8
L_933270:
	add_s r0,sp,0x30
L_933272:
	mov_s r0,r16
L_933274:
	bl.d L_92820c
L_933278:
	mov_s r1,r13
	.global L_93327a
L_93327a:
	b.d L_920274
L_93327e:
	add_s sp,sp,0x50
