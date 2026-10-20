/* calib_obj__reset_results @ 0x8f5438, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_all
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib__results_addr_800a28, calib__results_addr_800a34, rfc__pack_field_value, rfc__read_field_484
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_obj__reset_results
calib_obj__reset_results:
	.global L_8f5438
L_8f5438:
	push_s blink
L_8f543a:
	bl.d L_8c01e0
L_8f543e:
	add r3,r0,0x2c
L_8f5442:
	sub_s sp,sp,0x4
L_8f5444:
	mov_s r14,r0
L_8f5446:
	mov_s r1,0x0
L_8f5448:
	mov lp_count,0x8
L_8f544c:
	mov_s r2,r1
L_8f544e:
	lp L_8f545c
L_8f5452:
	add2 r12,r3,r2
L_8f5456:
	st_s r1,[r12]
L_8f5458:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8f545a:
	extb_s r2,r2
	.global L_8f545c
L_8f545c:
	st_s r1,[r14,0x4c]
L_8f545e:
	bl.d L_8cc394
L_8f5462:
	st_s r1,[r14,0x28]
L_8f5464:
	mov_s r1,r0
L_8f5466:
	mov_s r13,0x8042c8
L_8f546c:
	bl.d L_8d32b0
L_8f5470:
	ldb_s r0,[r13]
L_8f5472:
	bl L_8cc394
L_8f5476:
	bl.d L_8cc39c
L_8f547a:
	mov_s r15,r0
L_8f547c:
	mov_s r2,r0
L_8f547e:
	ldb_s r0,[r13]
L_8f5480:
	mov_s r1,r15
L_8f5482:
	mov_s r3,0xc
L_8f5484:
	mov_s r4,r3
L_8f5486:
	bl.d L_8d32e4
L_8f548a:
	mov_s r5,r3
L_8f548c:
	ld_s r0,[r14,0x24]
L_8f548e:
	ld_s r1,[sp,0x0]
L_8f5490:
	mov_s r2,0x0
L_8f5492:
	ld_s r13,[r0,0x1c]
L_8f5494:
	mov_s r0,r14
L_8f5496:
	mov_s r3,r2
L_8f5498:
	jl_s.d [r13]
L_8f549a:
	mov_s r4,r2
L_8f549c:
	b.d L_8c024c
L_8f54a0:
	add_s sp,sp,0x4
L_8f54a2:
	nop_s
