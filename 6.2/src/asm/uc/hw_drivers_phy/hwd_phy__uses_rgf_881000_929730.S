/* hwd_phy__uses_rgf_881000_929730 @ 0x929730, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__uses_rgf_881000_929730
hwd_phy__uses_rgf_881000_929730:
	.global L_929730
L_929730:
	st.a r13,[sp,-0x8]
L_929734:
	st_s r14,[sp,0x4]
L_929736:
	mov_s r14,blink
L_929738:
	mov.f r13,r0
L_92973c:
	cmp.ne r13,0x1
L_929740:
	cmp.ne r13,0x2
L_929744:
	beq L_929750
L_929748:
	breq r13,0x3,L_92979c
L_92974c:
	brne r13,0x4,L_92979c
	.global L_929750
L_929750:
	asl r5,r13,0x4
L_929754:
	or r5,r5,r13
L_929758:
	asl r4,r13,0x8
L_92975c:
	or r4,r4,r5
L_929760:
	asl r3,r13,0xc
L_929764:
	or r3,r3,r4
L_929768:
	asl r2,r13,0x10
L_92976c:
	or_s r2,r2,r3
L_92976e:
	asl r1,r13,0x14
L_929772:
	or_s r1,r1,r2
L_929774:
	asl r0,r13,0x18
L_929778:
	or_s r0,r0,r1
L_92977a:
	asl_s r13,r13,0x1c
L_92977c:
	or_s r0,r0,r13
L_92977e:
	mov r6,0x881000
L_929786:
	st.as r0,[r6,-0xff]
L_92978a:
	bmsk_s r0,r0,0x1b
L_92978c:
	st.as r0,[r6,-0xfe]
L_929790:
	mov_s blink,r14
L_929792:
	ld_s r14,[sp,0x4]
L_929794:
	j.d [blink]
L_929798:
	ld.ab r13,[sp,0x8]
	.global L_92979c
L_92979c:
	mov_s r0,blink
L_92979e:
	mov_s r1,0x12da
L_9297a4:
	bl L_926618
L_9297a8:
	b_s L_929750
L_9297aa:
	nop_s
