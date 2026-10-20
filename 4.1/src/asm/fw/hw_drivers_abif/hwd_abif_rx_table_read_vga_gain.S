/* hwd_abif_rx_table_read_vga_gain @ 0x8cc8c0, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 *   hwd_abif_rx_table_read_vga_gain: Row %d, index %d, is_q %d --> not a legal vga_gain_val
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_vga_gain_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.hwd_abif_rx_table_read_vga_gain,"ax",@progbits
	.global hwd_abif_rx_table_read_vga_gain
hwd_abif_rx_table_read_vga_gain:
	.global L_8cc8c0
L_8cc8c0:
	push_s blink
L_8cc8c2:
	bl L_8c02bc
L_8cc8c6:
	mov_s r13,r0
L_8cc8c8:
	mov_s r14,r1
L_8cc8ca:
	brge.d r1,0x5,L_8cc924
L_8cc8ce:
	mov_s r16,r2
L_8cc8d0:
	brlt r14,0x1,L_8cc924
	.global L_8cc8d4
L_8cc8d4:
	brge r16,0x2,L_8cc93c
	.global L_8cc8d8
L_8cc8d8:
	cmp_s r13,0x40
L_8cc8da:
	bge L_8cc954
	.global L_8cc8de
L_8cc8de:
	rsub r4,r14,0x4
L_8cc8e2:
	extb.f r4,r4
L_8cc8e6:
	add2 r0,r4,r16
L_8cc8ea:
	add_s r0,r0,0x800538
L_8cc8f0:
	ldb_s r1,[r0,0x4]
L_8cc8f2:
	ldb_s r2,[r0,0xc]
L_8cc8f4:
	mov_s r0,0x88a208
L_8cc8fa:
	add2_s r1,r1,r13
L_8cc8fc:
	ld.as r0,[r0,r1]
L_8cc900:
	lsr_s r0,r0,r2
L_8cc902:
	bmsk_s r0,r0,0x2
L_8cc904:
	cmp.ne r4,0x1
L_8cc908:
	cmp.ne r4,0x2
L_8cc90c:
	bne_s L_8cc99c
L_8cc90e:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8cc910:
	brhs r0,0x7,L_8cc984
L_8cc914:
	ldb.x r0,[0x8030d8,r0]
L_8cc91c:
	add r1,pcl,0x8
L_8cc920:
	add1_s r1,r1,r0
L_8cc922:
	j_s [r1]
	.global L_8cc924
L_8cc924:
	mov_s r0,blink
L_8cc926:
	mov_s r2,0x1019954
L_8cc92c:
	mov_s r1,0x12d0
L_8cc932:
	bl.d L_8c82c0
L_8cc936:
	mov r3,0x3cf
L_8cc93a:
	b_s L_8cc8d4
	.global L_8cc93c
L_8cc93c:
	mov_s r0,blink
L_8cc93e:
	mov_s r2,0x1019954
L_8cc944:
	mov_s r1,0x12d1
L_8cc94a:
	bl.d L_8c82c0
L_8cc94e:
	mov r3,0x3d0
L_8cc952:
	b_s L_8cc8d8
	.global L_8cc954
L_8cc954:
	mov_s r0,blink
L_8cc956:
	mov_s r2,0x1019954
L_8cc95c:
	mov_s r1,0x12cd
L_8cc962:
	bl.d L_8c82c0
L_8cc966:
	mov r3,0x3d1
L_8cc96a:
	b_s L_8cc8de
L_8cc96c:
	mov_s r0,0x0
L_8cc96e:
	b_s L_8cc99c
L_8cc970:
	mov_s r0,0x1
L_8cc972:
	b_s L_8cc99c
L_8cc974:
	mov_s r0,0x2
L_8cc976:
	b_s L_8cc99c
L_8cc978:
	mov_s r0,0x3
L_8cc97a:
	b_s L_8cc99c
L_8cc97c:
	mov_s r0,0x4
L_8cc97e:
	b_s L_8cc99c
L_8cc980:
	mov_s r0,0x5
L_8cc982:
	b_s L_8cc99c
	.global L_8cc984
L_8cc984:
	mov_s r14,0x7
L_8cc986:
	mov_s r2,0x1019a74
L_8cc98c:
	mov_s r0,0x6
L_8cc98e:
	mov_s r1,0x1
L_8cc990:
	mov_s r3,r13
L_8cc992:
	bl.d L_8ee034
L_8cc996:
	mov r5,r16
L_8cc99a:
	mov_s r0,r14
	.global L_8cc99c
L_8cc99c:
	b L_8c0324
