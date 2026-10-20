/* sxd_hal__write_qset_field @ 0x930608, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sxd_hal.c
 * Зовут его: aw_worker__begin_window
 * Зовёт сам: sxd_hal__select_qset_group, uc_sysassert
 */
	.section .text.sxd_hal__write_qset_field,"ax",@progbits
	.global sxd_hal__write_qset_field
sxd_hal__write_qset_field:
	.global L_930608
L_930608:
	st.a r13,[sp,-0xc]
L_93060c:
	st blink,[sp, 0x4]
L_930610:
	st_s r14,[sp,0x8]
L_930612:
	mov_s r14,r0
L_930614:
	and.f 0x0,r1,0xff000000
L_93061c:
	bne.d L_930694
L_930620:
	mov r13,r1
	.global L_930624
L_930624:
	bl.d L_924fe8
L_930628:
	mov r0,r14
L_93062c:
	asl r0,r14,0x14
L_930630:
	and r0,r0,0xf00000
L_930638:
	or r0,r0,0x68000000
L_930640:
	mov r32,r0
L_930644:
	st.ab r0,[r25,0x4]
L_930648:
	bclr r25,r25,0xa
L_93064c:
	nop_s
L_93064e:
	nop_s
L_930650:
	nop_s
L_930652:
	or r13,r13,0x67000000
L_93065a:
	mov_s r32,r13
L_93065c:
	st.ab r13,[r25,0x4]
L_930660:
	bclr r25,r25,0xa
L_930664:
	nop_s
L_930666:
	nop_s
L_930668:
	nop_s
L_93066a:
	asl r1,r14,0x14
L_93066e:
	and r1,r1,0xf00000
L_930676:
	or r1,r1,0x6800000b
L_93067e:
	mov_s r32,r1
L_930680:
	st.ab r1,[r25,0x4]
L_930684:
	bclr r25,r25,0xa
L_930688:
	ld blink,[sp, 0x4]
L_93068c:
	ld_s r14,[sp,0x8]
L_93068e:
	j_s.d [blink]
L_930690:
	ld.ab r13,[sp,0xc]
	.global L_930694
L_930694:
	mov_s r0,blink
L_930696:
	mov_s r2,0x1000d80
L_93069c:
	mov r1,0x53
L_9306a0:
	bl.d L_925548
L_9306a4:
	mov r3,0xee
L_9306a8:
	b_s L_930624
L_9306aa:
	nop_s
