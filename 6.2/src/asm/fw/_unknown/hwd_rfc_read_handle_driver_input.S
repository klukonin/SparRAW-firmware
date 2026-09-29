/* hwd_rfc_read_handle_driver_input @ 0x8f41c8, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_read_handle_driver_input: Driver set rdac val: %d. bb_rdac_val: 0x%x
 * Зовут его: hwd_rfc_read_calibrate
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_read_handle_driver_input
hwd_rfc_read_handle_driver_input:
	.global L_8f41c8
L_8f41c8:
	push_s blink
L_8f41ca:
	bl.d L_8c01e0
L_8f41ce:
	mov_s r0,0x0
L_8f41d0:
	mov_s r15,0x880a3c
L_8f41d6:
	ld_s r1,[r15,0x54]
L_8f41d8:
	mov_s r3,0x11
L_8f41da:
	asl_s r3,r3,0x8
L_8f41dc:
	and r2,r1,r3
L_8f41e0:
	brne r2,r3,L_8f4248
L_8f41e4:
	mov_s r13,0x889000
L_8f41ea:
	ld.as r0,[r13,0xad]
L_8f41ee:
	extb_s r14,r1
L_8f41f0:
	bic r0,r0,0x6
L_8f41f4:
	bset_s r0,r0,0x1
L_8f41f6:
	st.as r0,[r13,0xad]
L_8f41fa:
	bic.f r1,r1,-0xf1
L_8f41fe:
	bne_s L_8f424c
	.global L_8f4200
L_8f4200:
	ld.as r0,[r13,0x55]
L_8f4204:
	asl r1,r14,0xc
L_8f4208:
	and r0,r0,0xffff0fff
L_8f4210:
	or_s r0,r0,r1
L_8f4212:
	st.as r0,[r13,0x55]
L_8f4216:
	mov lp_count,0xa
L_8f421a:
	mov_s r0,0x0
L_8f421c:
	lp L_8f4230
L_8f4220:
	mov r2,-0x1
L_8f4224:
	mov_s r1,0x801a8c
L_8f422a:
	add2_s r1,r1,r0
L_8f422c:
	st_s r2,[r1]
L_8f422e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8f4230
L_8f4230:
	sub_s r0,r14,0x6
L_8f4232:
	stb r0,[gp, 0xc1]
L_8f4236:
	mov_s r1,0x101e9e0
L_8f423c:
	mov_s r0,0x20
L_8f423e:
	mov_s r2,r14
L_8f4240:
	bl.d L_8dcc80
L_8f4244:
	ld_s r3,[r15,0x54]
L_8f4246:
	mov_s r0,0x1
	.global L_8f4248
L_8f4248:
	b L_8c024c
	.global L_8f424c
L_8f424c:
	mov_s r0,blink
L_8f424e:
	bl.d L_8c9b28
L_8f4252:
	mov_s r1,0xac
L_8f4254:
	b_s L_8f4200
L_8f4256:
	nop_s
