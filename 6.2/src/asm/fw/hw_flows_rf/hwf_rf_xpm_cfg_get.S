/* hwf_rf_xpm_cfg_get @ 0x8f47dc, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_cfg_get(): write_waveforms_cfg[%d]=0x%x,
 *   [NNL] xpm_ifc_wr_time=0x%x, xpm_ifc_wr_vec=0x%x,
 *   hwf_rf_xpm_cfg_get(): read_waveforms_cfg[%d]=0x%x,
 *   [NNL] xpm_ifc_rd_time=0x%x, xpm_ifc_rf_vec=0x%x,
 *   hwf_rf_xpm_cfg_get(): xpm_rd_dout_sample_time=%d, xpm_wr_dout_sample_time=%d
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit2, xpm__read_3c8, xpm__read_3cc, xpm__read_cfg_350, xpm__read_cfg_378
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_cfg_get
hwf_rf_xpm_cfg_get:
	.global L_8f47dc
L_8f47dc:
	push_s blink
L_8f47de:
	bl L_8c01d8
L_8f47e2:
	mov_s r17,r0
L_8f47e4:
	mov_s r16,r1
L_8f47e6:
	mov_s r13,0x0
L_8f47e8:
	mov_s r15,0x14
	.global L_8f47ea
L_8f47ea:
	mov_s r0,r17
L_8f47ec:
	bl.d L_8d4660
L_8f47f0:
	mov_s r1,r13
L_8f47f2:
	mov_s r3,r0
L_8f47f4:
	add2 r14,r16,r13
L_8f47f8:
	st_s r0,[r14,0x8]
L_8f47fa:
	mov_s r1,0x101bb3c
L_8f4800:
	mov_s r0,0x20
L_8f4802:
	bl.d L_8dcc80
L_8f4806:
	mov_s r2,r13
L_8f4808:
	ld_s r3,[r14,0x8]
L_8f480a:
	mov_s r1,0x101bb70
L_8f4810:
	lsr_s r3,r3,0x10
L_8f4812:
	bmsk_s r3,r3,0x8
L_8f4814:
	mov_s r0,0x20
L_8f4816:
	bl.d L_8dcc80
L_8f481a:
	ldw_s r2,[r14,0x8]
L_8f481c:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8f481e:
	brhs.d r15,0x1,L_8f47ea
L_8f4822:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f4824:
	mov_s r13,0x0
L_8f4826:
	mov_s r15,0xa
	.global L_8f4828
L_8f4828:
	mov_s r0,r17
L_8f482a:
	bl.d L_8d4640
L_8f482e:
	mov_s r1,r13
L_8f4830:
	mov_s r3,r0
L_8f4832:
	add2 r14,r16,r13
L_8f4836:
	st_s r0,[r14,0x58]
L_8f4838:
	mov_s r1,0x101bba4
L_8f483e:
	mov_s r0,0x20
L_8f4840:
	bl.d L_8dcc80
L_8f4844:
	mov_s r2,r13
L_8f4846:
	ld_s r3,[r14,0x58]
L_8f4848:
	mov_s r1,0x101bbd8
L_8f484e:
	ldw r2,[r14, 0x58]
L_8f4852:
	lsr_s r3,r3,0x10
L_8f4854:
	mov_s r0,0x20
L_8f4856:
	bl.d L_8dcc80
L_8f485a:
	bmsk_s r3,r3,0x2
L_8f485c:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8f485e:
	/* brhs.d r15,0x1,0x008f4828 */
	.byte 0xcd,0x0f,0x75,0x90
L_8f4862:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f4864:
	bl.d L_8d45c0
L_8f4868:
	mov_s r0,r17
L_8f486a:
	st r0,[r16]
L_8f486e:
	bl.d L_8d4680
L_8f4872:
	mov_s r0,r17
L_8f4874:
	mov_s r3,r0
L_8f4876:
	st r0,[r16, 0x4]
L_8f487a:
	mov_s r1,0x101baec
L_8f4880:
	mov_s r0,0x20
L_8f4882:
	bl.d L_8dcc80
L_8f4886:
	ld r2,[r16]
L_8f488a:
	b L_8c023c
L_8f488e:
	nop_s
