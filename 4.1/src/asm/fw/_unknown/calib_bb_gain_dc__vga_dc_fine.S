/* calib_bb_gain_dc__vga_dc_fine @ 0x8c68fc, 320 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BB GAIN DC::VGA_DC_FINE:: RxGainIndex=%d ======== CAL_NON_CONVERGED ====
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, calib_lo_power_measure, calib_vga_gain_step, fw_div_unsigned, fw_log__emit1, hwd_abif__rgf_88a200_8cc674, hwf_calib__setup_loopback, hwf_calib_bb_gain_alg, hwf_vga_dc__calibrate
 */
	.section .text.calib_bb_gain_dc__vga_dc_fine,"ax",@progbits
	.global calib_bb_gain_dc__vga_dc_fine
calib_bb_gain_dc__vga_dc_fine:
L_8c68fc:
	sub_s sp,sp,0x4
L_8c68fe:
	push_s blink
L_8c6900:
	bl.d L_8c02b4
L_8c6904:
	lsr r0,r1,0x14
L_8c6908:
	sub_s sp,sp,0x8
L_8c690a:
	mov_s r16,r2
L_8c690c:
	mov_s r17,r3
L_8c690e:
	and.f 0x0,r1,0xfff00000
L_8c6916:
	mov_s r13,0x1
L_8c6918:
	bne_s L_8c6962
L_8c691a:
	bl.d L_8d1b58
L_8c691e:
	mov_s r14,0x1e
L_8c6920:
	ldb r4,[gp, 0xf4]
L_8c6924:
	mov_s r0,0x0
L_8c6926:
	mov_s r1,r0
L_8c6928:
	mov_s r2,r0
L_8c692a:
	bl.d L_8d3d0c
L_8c692e:
	mov_s r3,r13
L_8c6930:
	mov_s r0,r13
L_8c6932:
	bl.d L_8d3964
L_8c6936:
	mov_s r1,0x3f
L_8c6938:
	mov_s r13,r0
L_8c693a:
	mov_s r15,0xb
	.global L_8c693c
L_8c693c:
	mov_s r0,0x0
L_8c693e:
	bl.d L_8cc674
L_8c6942:
	mov_s r1,r0
L_8c6944:
	mov_s r0,0x1
L_8c6946:
	bl.d L_8cc674
L_8c694a:
	mov_s r1,r14
L_8c694c:
	mov_s r2,sp
L_8c694e:
	mov_s r0,0xff
L_8c6950:
	bl.d L_8d3f40
L_8c6954:
	mov_s r1,0xd
L_8c6956:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8c6958:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c695a:
	brhs.d r15,0x1,L_8c693c
L_8c695e:
	extb_s r14,r14
L_8c6960:
	b_s L_8c6a32
	.global L_8c6962
L_8c6962:
	cmp r0,0xdc
L_8c6966:
	bne_s L_8c6984
L_8c6968:
	ldb r4,[gp, 0xf4]
L_8c696c:
	mov_s r0,0x0
L_8c696e:
	mov_s r1,r0
L_8c6970:
	mov_s r2,r0
L_8c6972:
	bl.d L_8d3d0c
L_8c6976:
	mov_s r3,r13
L_8c6978:
	mov_s r0,r13
L_8c697a:
	bl.d L_8d3964
L_8c697e:
	mov_s r1,0x3f
L_8c6980:
	mov_s r13,r0
L_8c6982:
	b_s L_8c6a32
	.global L_8c6984
L_8c6984:
	brne r0,0x1,L_8c6a32
L_8c6988:
	ldb r4,[gp, 0xf4]
L_8c698c:
	mov_s r0,0x0
L_8c698e:
	mov_s r1,r0
L_8c6990:
	mov_s r2,r0
L_8c6992:
	bl.d L_8d3d0c
L_8c6996:
	mov_s r3,r13
L_8c6998:
	mov_s r1,0x8004e0
L_8c699e:
	ldb r18,[r1, 0x3]
L_8c69a2:
	ldb_s r15,[r1,0x2]
L_8c69a4:
	sub r14,r18,r15
L_8c69a8:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c69aa:
	extb_s r14,r14
L_8c69ac:
	mov_s r0,r14
L_8c69ae:
	bl.d L_8c03b4
L_8c69b2:
	mov_s r1,r17
L_8c69b4:
	extb_s r0,r0
L_8c69b6:
	mulu64 r0,r17
L_8c69ba:
	sub.f r1,r14,mlo
L_8c69be:
	mov.ne r1,0x1
L_8c69c2:
	add_s r0,r0,r1
L_8c69c4:
	extb_s r0,r0
L_8c69c6:
	breq r14,0x1,L_8c69d6
L_8c69ca:
	sub r1,r16,0x1
L_8c69ce:
	mulu64 r1,r0
L_8c69d2:
	add_s r15,r15,mlo
L_8c69d4:
	extb_s r15,r15
	.global L_8c69d6
L_8c69d6:
	sub_s r1,r15,0x1
L_8c69d8:
	add_s r0,r0,r1
L_8c69da:
	min r0,r0,r18
L_8c69de:
	extb_s r0,r0
L_8c69e0:
	brlt r0,r15,L_8c6a32
L_8c69e4:
	sub_s r0,r0,r15
L_8c69e6:
	extb_s r0,r0
L_8c69e8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8c69ea
L_8c69ea:
	mov_s r16,r0
L_8c69ec:
	mov_s r14,0x0
L_8c69ee:
	b_s L_8c6a22
	.global L_8c69f0
L_8c69f0:
	ldb r2,[gp, 0xf4]
L_8c69f4:
	mov_s r0,r15
L_8c69f6:
	ldb r3,[gp, 0xf5]
L_8c69fa:
	mov_s r1,r14
L_8c69fc:
	bl.d L_8d3a70
L_8c6a00:
	mov r4,0x4
L_8c6a04:
	mov.f r13,r0
L_8c6a08:
	cmp.ne r13,0x1
L_8c6a0c:
	beq_s L_8c6a1e
L_8c6a0e:
	mov_s r2,0x1008c10
L_8c6a14:
	mov_s r0,0x6
L_8c6a16:
	mov_s r1,0x1
L_8c6a18:
	bl.d L_8edfcc
L_8c6a1c:
	mov_s r3,r15
	.global L_8c6a1e
L_8c6a1e:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c6a20:
	extb_s r14,r14
	.global L_8c6a22
L_8c6a22:
	brlt r14,0x2,L_8c69f0
L_8c6a26:
	sub r0,r16,0x1
L_8c6a2a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8c6a2c:
	brhs.d r0,0x1,L_8c69ea
L_8c6a30:
	extb_s r15,r15
	.global L_8c6a32
L_8c6a32:
	mov_s r0,r13
L_8c6a34:
	mov_s r12,0x8
L_8c6a36:
	b.d L_8c0316
L_8c6a3a:
	add_s sp,sp,0x8
