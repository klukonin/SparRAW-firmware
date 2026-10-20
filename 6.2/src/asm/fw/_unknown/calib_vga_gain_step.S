/* calib_vga_gain_step @ 0x8d66cc, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_row_step, calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__rx_table_config_vga_atten, hwd_abif__rx_table_config_vga_dc, hwd_abif_rx_table_config_vga_gain, hwd_abif_rx_table_read_vga_gain, hwf_vga_dc__calibrate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_vga_gain_step
calib_vga_gain_step:
	.global L_8d66cc
L_8d66cc:
	push_s blink
L_8d66ce:
	bl L_8c01d8
L_8d66d2:
	sub_s sp,sp,0x4
L_8d66d4:
	cmp_s r1,r0
L_8d66d6:
	mov_s r13,r0
L_8d66d8:
	blt.d L_8d67ce
L_8d66dc:
	mov_s r15,0x1
L_8d66de:
	sub_s r1,r1,r13
L_8d66e0:
	extb_s r1,r1
L_8d66e2:
	add r16,r1,0x1
	.global L_8d66e6
L_8d66e6:
	mov_s r14,0x1
L_8d66e8:
	b_s L_8d6700
	.global L_8d66ea
L_8d66ea:
	bl.d L_8cf250
L_8d66ee:
	mov_s r3,r2
L_8d66f0:
	mov_s r0,r13
L_8d66f2:
	mov_s r1,r14
L_8d66f4:
	mov_s r2,0x1
L_8d66f6:
	bl.d L_8cf250
L_8d66fa:
	mov_s r3,0x0
	.global L_8d66fc
L_8d66fc:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d66fe:
	extb_s r14,r14
	.global L_8d6700
L_8d6700:
	brhs r14,0x5,L_8d6754
L_8d6704:
	mov_s r0,r13
L_8d6706:
	mov_s r1,r14
L_8d6708:
	mov_s r2,0x0
L_8d670a:
	bl.d L_8cf36c
L_8d670e:
	mov_s r3,0xf
L_8d6710:
	mov_s r0,r13
L_8d6712:
	mov_s r1,r14
L_8d6714:
	mov_s r2,0x1
L_8d6716:
	bl.d L_8cf36c
L_8d671a:
	mov_s r3,0xf
L_8d671c:
	ldb.x r0,[gp, 0xfa]
L_8d6720:
	mov_s r1,r14
L_8d6722:
	cmp_s r0,0x0
L_8d6724:
	mov_s r0,r13
L_8d6726:
	mov_s r2,0x0
L_8d6728:
	blt_s L_8d66ea
L_8d672a:
	bl L_8cf788
L_8d672e:
	sub r1,sp,0x1
L_8d6732:
	add_s r1,r1,r14
L_8d6734:
	stb_s r0,[r1]
L_8d6736:
	mov_s r0,r13
L_8d6738:
	mov_s r1,r14
L_8d673a:
	mov_s r2,0x0
L_8d673c:
	bl.d L_8cf418
L_8d6740:
	ldb r3,[gp, 0xfa]
L_8d6744:
	mov_s r0,r13
L_8d6746:
	mov_s r1,r14
L_8d6748:
	mov_s r2,0x1
L_8d674a:
	bl.d L_8cf418
L_8d674e:
	ldb r3,[gp, 0xfa]
L_8d6752:
	b_s L_8d66fc
	.global L_8d6754
L_8d6754:
	mov_s r14,0x0
L_8d6756:
	b_s L_8d675c
	.global L_8d6758
L_8d6758:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d675a:
	extb_s r14,r14
	.global L_8d675c
L_8d675c:
	brhs r14,0x2,L_8d67c2
L_8d6760:
	mov r17,0x1
L_8d6764:
	b_s L_8d677c
	.global L_8d6766
L_8d6766:
	mov_s r0,r13
L_8d6768:
	mov_s r1,r14
L_8d676a:
	mov r4,r17
	.global L_8d676e
L_8d676e:
	bl.d L_8d67d8
L_8d6772:
	add r17,r17,0x1
L_8d6776:
	mov_s r15,r0
L_8d6778:
	extb r17,r17
	.global L_8d677c
L_8d677c:
	brhs r17,0x5,L_8d6758
L_8d6780:
	ldb.x r0,[gp, 0xfa]
L_8d6784:
	brge r0,0x0,L_8d6796
L_8d6788:
	mov_s r0,r13
L_8d678a:
	mov_s r1,r17
L_8d678c:
	mov_s r2,r14
L_8d678e:
	bl.d L_8cf250
L_8d6792:
	mov_s r3,0x1
L_8d6794:
	b_s L_8d67a8
	.global L_8d6796
L_8d6796:
	sub r0,sp,0x1
L_8d679a:
	ldb r3,[r0,r17]
L_8d679e:
	mov_s r0,r13
L_8d67a0:
	mov_s r1,r17
L_8d67a2:
	bl.d L_8cf418
L_8d67a6:
	mov_s r2,r14
	.global L_8d67a8
L_8d67a8:
	ldb r2,[gp, 0xf8]
L_8d67ac:
	brhs.d r17,0x4,L_8d6766
L_8d67b0:
	ldb r3,[gp, 0xf9]
L_8d67b4:
	add r4,r17,0x1
L_8d67b8:
	extb r4,r4
L_8d67bc:
	mov_s r0,r13
L_8d67be:
	mov_s r1,r14
L_8d67c0:
	b_s L_8d676e
	.global L_8d67c2
L_8d67c2:
	sub r16,r16,0x1
L_8d67c6:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d67c8:
	brhs.d r16,0x1,L_8d66e6
L_8d67cc:
	extb_s r13,r13
	.global L_8d67ce
L_8d67ce:
	mov_s r0,r15
L_8d67d0:
	b.d L_8c023c
L_8d67d4:
	add_s sp,sp,0x4
L_8d67d6:
	nop_s
