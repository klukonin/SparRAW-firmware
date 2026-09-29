/* hwd_rfc_read_rgf_uc @ 0x92a1cc, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_read_rgf: rf_rgf_addr=0x%x rfca_en=0x%02x
 *   hwd_rfc_read_rgf: RF read failed in all %d trials. Returning invalid res_val=0x%8x
 * Зовут его: hwd_rfc_auto_fill_verify, rf_utils_auto_fill_uc
 * Зовёт сам: hwd_abif__rfc_divider_restart_uc, hwd_rfc_write_core, uc_log__emit2, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_read_rgf_uc
hwd_rfc_read_rgf_uc:
	.global L_92a1cc
L_92a1cc:
	st.a r13,[sp,-0x14]
L_92a1d0:
	st blink,[sp, 0x4]
L_92a1d4:
	st_s r14,[sp,0x8]
L_92a1d6:
	st r16,[sp, 0x10]
L_92a1da:
	ld r3,[0x889488]
L_92a1e2:
	mov r16,0xdeadbeef
L_92a1ea:
	lsr_s r3,r3,0x8
L_92a1ec:
	extb_s r3,r3
L_92a1ee:
	rsub r4,r3,0x0
L_92a1f2:
	and r4,r4,r3
L_92a1f6:
	xor.f 0x0,r4,r3
L_92a1fa:
	st_s r15,[sp,0xc]
L_92a1fc:
	beq.d L_92a220
L_92a200:
	mov_s r15,r1
L_92a202:
	mov_s r1,0x1001f78
L_92a208:
	mov r0,0x0
L_92a20c:
	bl.d L_92d27c
L_92a210:
	mov r2,r15
L_92a214:
	mov_s r0,blink
L_92a216:
	mov_s r1,0x1513
L_92a21c:
	bl L_926618
	.global L_92a220
L_92a220:
	mov_s r13,0x889000
L_92a226:
	mov_s r14,0x5
	.global L_92a228
L_92a228:
	ld.as r5,[r13,0x46]
L_92a22c:
	mov_s r0,0x0
L_92a22e:
	bset r5,r5,0x6
L_92a232:
	st.as r5,[r13,0x46]
L_92a236:
	ld.as r6,[r13,0x46]
L_92a23a:
	mov_s r1,0x4
L_92a23c:
	bclr r6,r6,0x6
L_92a240:
	st.as r6,[r13,0x46]
L_92a244:
	mov r2,r15
L_92a248:
	bl.d L_92a3d8
L_92a24c:
	mov r3,r0
L_92a250:
	ld.as r7,[r13,0xfb]
L_92a254:
	breq r7,0x1,L_92a26c
L_92a258:
	bl.d L_928c78
L_92a25c:
	mov r0,0x1
L_92a260:
	sub r14,r14,0x1
L_92a264:
	brhs r14,0x1,L_92a228
L_92a268:
	b L_92a270
	.global L_92a26c
L_92a26c:
	ld r16,[r13, 0xd8]
	.global L_92a270
L_92a270:
	brne r16,0xdeadbeef,L_92a290
L_92a278:
	mov_s r1,0x1001fac
L_92a27e:
	mov_s r0,0x0
L_92a280:
	mov r3,0xdeadbeef
L_92a288:
	bl.d L_92d27c
L_92a28c:
	mov r2,0x5
	.global L_92a290
L_92a290:
	ld blink,[sp, 0x4]
L_92a294:
	mov_s r0,r16
L_92a296:
	ld_s r14,[sp,0x8]
L_92a298:
	ld_s r15,[sp,0xc]
L_92a29a:
	ld r16,[sp, 0x10]
L_92a29e:
	j_s.d [blink]
L_92a2a0:
	ld.ab r13,[sp,0x14]
