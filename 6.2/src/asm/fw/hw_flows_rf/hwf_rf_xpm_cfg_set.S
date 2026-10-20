/* hwf_rf_xpm_cfg_set @ 0x8f4890, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_rf_xpm_cfg_set(): write_waveforms_cfg[%d]=0x%x
 *   hwf_rf_xpm_cfg_set(): read_waveforms_cfg[%d]=0x%x
 *   hwf_rf_xpm_cfg_get(): xpm_rd_dout_sample_time=%d, xpm_wr_dout_sample_time=%d
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, hwf_rf_xpm_enter_cfg_mode
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit2, xpm__wave_rd_set, xpm__write_3c8, xpm__write_3cc, xpm__write_cfg_350
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf_xpm_cfg_set
hwf_rf_xpm_cfg_set:
	.global L_8f4890
L_8f4890:
	push_s blink
L_8f4892:
	bl L_8c01d8
L_8f4896:
	mov_s r17,r0
L_8f4898:
	mov_s r14,r1
L_8f489a:
	mov_s r13,0x0
L_8f489c:
	mov_s r15,0x14
	.global L_8f489e
L_8f489e:
	mov_s r1,0x101ba84
L_8f48a4:
	add2 r16,r14,r13
L_8f48a8:
	mov_s r0,0x20
L_8f48aa:
	mov_s r2,r13
L_8f48ac:
	bl.d L_8dcc80
L_8f48b0:
	ld r3,[r16, 0x8]
L_8f48b4:
	mov_s r0,r17
L_8f48b6:
	mov_s r1,r13
L_8f48b8:
	bl.d L_8d4670
L_8f48bc:
	ld r2,[r16, 0x8]
L_8f48c0:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8f48c2:
	brhs.d r15,0x1,L_8f489e
L_8f48c6:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f48c8:
	mov_s r13,0x0
L_8f48ca:
	mov_s r15,0xa
	.global L_8f48cc
L_8f48cc:
	mov_s r1,0x101bab8
L_8f48d2:
	add2 r16,r14,r13
L_8f48d6:
	mov_s r0,0x20
L_8f48d8:
	mov_s r2,r13
L_8f48da:
	bl.d L_8dcc80
L_8f48de:
	ld r3,[r16, 0x58]
L_8f48e2:
	mov_s r0,r17
L_8f48e4:
	mov_s r1,r13
L_8f48e6:
	bl.d L_8d4650
L_8f48ea:
	ld r2,[r16, 0x58]
L_8f48ee:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8f48f0:
	brhs.d r15,0x1,L_8f48cc
L_8f48f4:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f48f6:
	ld_s r2,[r14]
L_8f48f8:
	mov_s r1,0x101baec
L_8f48fe:
	mov_s r0,0x20
L_8f4900:
	bl.d L_8dcc80
L_8f4904:
	ld_s r3,[r14,0x4]
L_8f4906:
	mov_s r0,r17
L_8f4908:
	bl.d L_8d45d4
L_8f490c:
	ld_s r1,[r14]
L_8f490e:
	mov_s r0,r17
L_8f4910:
	bl.d L_8d4694
L_8f4914:
	ld_s r1,[r14,0x4]
L_8f4916:
	b L_8c023c
L_8f491a:
	nop_s
