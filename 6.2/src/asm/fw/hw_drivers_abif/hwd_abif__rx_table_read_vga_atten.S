/* hwd_abif__rx_table_read_vga_atten @ 0x8cf640, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_read_vga_atten
hwd_abif__rx_table_read_vga_atten:
	.global L_8cf640
L_8cf640:
	push_s blink
L_8cf642:
	bl L_8c01e0
L_8cf646:
	mov_s r15,r0
L_8cf648:
	mov_s r14,r1
L_8cf64a:
	brge.d r1,0x5,L_8cf686
L_8cf64e:
	mov_s r13,r2
L_8cf650:
	brlt r14,0x2,L_8cf686
	.global L_8cf654
L_8cf654:
	brge r13,0x2,L_8cf694
	.global L_8cf658
L_8cf658:
	cmp_s r15,0x40
L_8cf65a:
	bge L_8cf6a2
	.global L_8cf65e
L_8cf65e:
	rsub r0,r14,0x4
L_8cf662:
	extb_s r0,r0
L_8cf664:
	add2_s r0,r0,r13
L_8cf666:
	add r1,r0,0x800530
L_8cf66e:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cf670:
	add2_s r13,r13,r15
L_8cf672:
	mov_s r0,0x88a208
L_8cf678:
	ld.as r0,[r0,r13]
L_8cf67c:
	ldb_s r1,[r1,0xc]
L_8cf67e:
	lsr_s r0,r0,r1
L_8cf680:
	b.d L_8c024c
L_8cf684:
	bmsk_s r0,r0,0x0
	.global L_8cf686
L_8cf686:
	mov_s r0,blink
L_8cf688:
	mov_s r1,0x1303
L_8cf68e:
	bl L_8c9b28
L_8cf692:
	b_s L_8cf654
	.global L_8cf694
L_8cf694:
	mov_s r0,blink
L_8cf696:
	mov_s r1,0x1304
L_8cf69c:
	bl L_8c9b28
L_8cf6a0:
	b_s L_8cf658
	.global L_8cf6a2
L_8cf6a2:
	mov_s r0,blink
L_8cf6a4:
	mov_s r1,0x1305
L_8cf6aa:
	bl L_8c9b28
L_8cf6ae:
	b_s L_8cf65e
