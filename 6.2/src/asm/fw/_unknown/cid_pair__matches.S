/* cid_pair__matches @ 0x8da62c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_scheme_builder__build_allocations, schedule_scheme_builder__build_allocations_from_beacon
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global cid_pair__matches
cid_pair__matches:
	.global L_8da62c
L_8da62c:
	ld_s r0,[r0,0x10]
L_8da62e:
	ldb_s r3,[r0,0x8]
L_8da630:
	mov_s r0,0x0
L_8da632:
	cmp_s r1,r3
L_8da634:
	mov_s r12,0xff
L_8da636:
	cmp.ne r1,r12
L_8da63a:
	mov.eq r0,0x1
L_8da63e:
	extb.f 0x0,r0
L_8da642:
	bne_s L_8da650
L_8da644:
	cmp_s r2,r3
L_8da646:
	mov_s r12,0xff
L_8da648:
	cmp.ne r2,r12
L_8da64c:
	mov_s r0,0x0
L_8da64e:
	bne_s L_8da652
	.global L_8da650
L_8da650:
	mov_s r0,0x1
	.global L_8da652
L_8da652:
	j_s.d [blink]
L_8da654:
	extb_s r0,r0
L_8da656:
	nop_s
