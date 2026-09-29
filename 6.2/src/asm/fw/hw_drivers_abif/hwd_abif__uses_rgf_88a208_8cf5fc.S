/* hwd_abif__uses_rgf_88a208_8cf5fc @ 0x8cf5fc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__uses_rgf_88a208_8cf5fc
hwd_abif__uses_rgf_88a208_8cf5fc:
	.global L_8cf5fc
L_8cf5fc:
	push_s blink
L_8cf5fe:
	bl L_8c01e4
L_8cf602:
	cmp_s r0,0x40
L_8cf604:
	mov_s r13,r0
L_8cf606:
	mov_s r14,r1
L_8cf608:
	bge_s L_8cf630
	.global L_8cf60a
L_8cf60a:
	mov lp_count,0x3
L_8cf60e:
	mov_s r1,0x0
L_8cf610:
	lp L_8cf62c
L_8cf614:
	add2 r2,r1,r13
L_8cf618:
	mov_s r0,0x88a208
L_8cf61e:
	ld.as r0,[r0,r2]
L_8cf622:
	add2 r12,r14,r1
L_8cf626:
	st_s r0,[r12]
L_8cf628:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8cf62a:
	extb_s r1,r1
	.global L_8cf62c
L_8cf62c:
	b L_8c0254
	.global L_8cf630
L_8cf630:
	mov_s r0,blink
L_8cf632:
	mov_s r1,0x12ce
L_8cf638:
	bl L_8c9b28
L_8cf63c:
	b_s L_8cf60a
L_8cf63e:
	nop_s
