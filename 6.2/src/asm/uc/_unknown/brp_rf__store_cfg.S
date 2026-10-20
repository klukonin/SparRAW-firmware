/* brp_rf__store_cfg @ 0x9213d0, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: config_brp_rf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_rf__store_cfg
brp_rf__store_cfg:
	.global L_9213d0
L_9213d0:
	push_s blink
L_9213d2:
	bl.d L_920230
L_9213d6:
	mov_s r4,r1
L_9213d8:
	push_s r0
L_9213da:
	mov_s r0,0x0
L_9213dc:
	mov_s r1,0x801504
L_9213e2:
	add r3,r1,0xc
L_9213e6:
	brlo.d r2,0x1,L_92140a
L_9213ea:
	stw_s r0,[r1,0x8]
L_9213ec:
	mov_s r13,r0
	.global L_9213ee
L_9213ee:
	ld_s r14,[sp,0x0]
L_9213f0:
	mov_s r15,0x801c94
L_9213f6:
	/* asl_s r14,r14,0x6 */
	.byte 0x06,0xbe
L_9213f8:
	add1_s r14,r14,r13
L_9213fa:
	ldb_s r14,[r15,r14]
L_9213fc:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_9213fe:
	add_s r0,r0,r14
L_921400:
	extw_s r0,r0
L_921402:
	stw_s r0,[r1,0x8]
L_921404:
	brhs.d r2,0x1,L_9213ee
L_921408:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_92140a
L_92140a:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_92140c:
	/* asr_s r0,r0,0x3 */
	.byte 0x43,0xb8
L_92140e:
	extb_s r0,r0
L_921410:
	min r0,r0,0x2f
L_921414:
	ldb_s r2,[r1,0x1]
L_921416:
	extb_s r0,r0
L_921418:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_92141a:
	asr_s r2,r2
L_92141c:
	min r2,r2,0x2f
L_921420:
	mov_s r14,0x80152c
L_921426:
	extb_s r13,r2
L_921428:
	ldb_s r2,[r14,r0]
L_92142a:
	ldb_s r13,[r14,r13]
L_92142c:
	mov_s r14,0x8025dc
L_921432:
	ldb_s r0,[r1]
L_921434:
	ld_s r14,[r14]
L_921436:
	ldw_s.x r1,[r1,0xa]
L_921438:
	sub_s r0,r0,r14
L_92143a:
	sub2 r1,r1,r0
L_92143e:
	sub_s r1,r1,r2
L_921440:
	add_s r13,r13,r1
L_921442:
	add1 r3,r3,r4
L_921446:
	stw_s r13,[r3]
L_921448:
	b.d L_92029c
L_92144c:
	add_s sp,sp,0x4
L_92144e:
	nop_s
