/* rfc__write_buffer_and_wait @ 0x8e85b0, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   /home/gatis/sdk/sparrow/fwsrc4/src/common/inc/hw_drivers_rfc.h
 * Зовут его: marlon_r_if_class__rf_hw_write_buffer, marlon_r_if_class__rf_write_with_block_retries
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.rfc__write_buffer_and_wait,"ax",@progbits
	.global rfc__write_buffer_and_wait
rfc__write_buffer_and_wait:
	.global L_8e85b0
L_8e85b0:
	push_s blink
L_8e85b2:
	push_s r13
L_8e85b4:
	bmsk_s r1,r1,0x3
L_8e85b6:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8e85b8:
	bmsk_s r0,r0,0x3
L_8e85ba:
	or_s r1,r1,r0
L_8e85bc:
	mov_s r13,0x889080
L_8e85c2:
	ld_s r0,[r13,0x50]
L_8e85c4:
	asl_s r1,r1,0x10
L_8e85c6:
	and r0,r0,0x8000ffff
L_8e85ce:
	or_s r0,r0,r1
L_8e85d0:
	st_s r0,[r13,0x50]
L_8e85d2:
	st_s r2,[r13,0x54]
L_8e85d4:
	st_s r3,[r13,0x58]
L_8e85d6:
	mov lp_count,0x7d0
L_8e85da:
	nop_s
L_8e85dc:
	lp L_8e85e8
L_8e85e0:
	ld_s r1,[r13,0x4c]
L_8e85e2:
	btst_s r1,0x1d
L_8e85e4:
	beq_s L_8e85e8
L_8e85e6:
	nop_s
	.global L_8e85e8
L_8e85e8:
	ld_s r0,[r13,0x4c]
L_8e85ea:
	bbit0 r0,0x1d,L_8e85fe
L_8e85ee:
	mov_s r3,blink
L_8e85f0:
	mov_s r2,0x10005e4
L_8e85f6:
	mov_s r0,0x0
L_8e85f8:
	bl.d L_8edfcc
L_8e85fc:
	mov_s r1,r0
	.global L_8e85fe
L_8e85fe:
	mov lp_count,0x30d40
L_8e8606:
	nop_s
L_8e8608:
	lp L_8e8614
L_8e860c:
	ld_s r1,[r13,0x4c]
L_8e860e:
	btst_s r1,0x1d
L_8e8610:
	beq_s L_8e8614
L_8e8612:
	nop_s
	.global L_8e8614
L_8e8614:
	ld_s r0,[r13,0x4c]
L_8e8616:
	bbit0 r0,0x1d,L_8e863c
L_8e861a:
	mov_s r2,0x1000614
L_8e8620:
	mov_s r0,0x0
L_8e8622:
	bl.d L_8edfb0
L_8e8626:
	mov_s r1,r0
L_8e8628:
	mov_s r0,blink
L_8e862a:
	mov_s r2,0x1000634
L_8e8630:
	mov_s r1,0x1345
L_8e8636:
	bl.d L_8c82c0
L_8e863a:
	mov_s r3,0x6a
	.global L_8e863c
L_8e863c:
	ld_s r0,[r13,0x4c]
L_8e863e:
	bset_s r0,r0,0x1e
L_8e8640:
	st_s r0,[r13,0x4c]
L_8e8642:
	b L_8c033c
L_8e8646:
	nop_s
