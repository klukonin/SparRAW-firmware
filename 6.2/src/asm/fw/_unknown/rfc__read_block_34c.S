/* rfc__read_block_34c @ 0x8d3164, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_sense__prepare_no_rf
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_rfc_read_rgf, hwd_rfc_write_verify, rfc__read_block_loop
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__read_block_34c
rfc__read_block_34c:
	.global L_8d3164
L_8d3164:
	push_s blink
L_8d3166:
	bl.d L_8c01e4
L_8d316a:
	mov_s r2,0xf
L_8d316c:
	mov_s r14,r0
L_8d316e:
	mov_s r13,r1
L_8d3170:
	mov r1,0x34c
L_8d3174:
	bl.d L_8d4468
L_8d3178:
	mov_s r3,0x6
L_8d317a:
	mov_s r0,r14
L_8d317c:
	bl.d L_8d3588
L_8d3180:
	mov r1,0x440
L_8d3184:
	bmsk r2,r0,0x1
L_8d3188:
	extb_s r3,r13
L_8d318a:
	/* asl_s r3,r3,0x2 */
	.byte 0x02,0xbb
L_8d318c:
	bset_s r3,r3,0x5
L_8d318e:
	mov_s r0,r14
L_8d3190:
	mov r1,0x440
L_8d3194:
	or_s r2,r2,r3
L_8d3196:
	bl.d L_8d4468
L_8d319a:
	mov_s r3,0x6
L_8d319c:
	mov_s r0,r14
L_8d319e:
	mov r1,0x444
L_8d31a2:
	mov_s r2,0x10
L_8d31a4:
	bset_s r2,r2,0xc
L_8d31a6:
	bl.d L_8d4468
L_8d31aa:
	mov_s r3,0x6
L_8d31ac:
	mov_s r0,r14
L_8d31ae:
	mov r1,0x45c
L_8d31b2:
	mov_s r2,0x1
L_8d31b4:
	bl.d L_8d42e0
L_8d31b8:
	mov_s r3,r2
L_8d31ba:
	mov_s r0,r14
L_8d31bc:
	mov r1,0x454
L_8d31c0:
	mov_s r2,0x10
L_8d31c2:
	bl.d L_8d4468
L_8d31c6:
	mov_s r3,0x6
L_8d31c8:
	mov_s r0,r14
L_8d31ca:
	mov r1,0x44c
L_8d31ce:
	mov_s r2,0x1
L_8d31d0:
	bl.d L_8d42e0
L_8d31d4:
	mov_s r3,r2
L_8d31d6:
	b L_8c0254
L_8d31da:
	nop_s
