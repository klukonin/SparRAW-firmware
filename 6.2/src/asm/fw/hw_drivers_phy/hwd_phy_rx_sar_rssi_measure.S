/* hwd_phy_rx_sar_rssi_measure @ 0x8d2968, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_rx_sar_rssi_measure: acc_len=0x%x
 *   hwd_phy_rx_sar_rssi_measure: tot_gain_without_dc=0x%x
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_divmod64_signed, fw_divmod_unsigned, fw_log_emit1, hwd_phy__read_sar_sample, hwd_phy__rx_cal_gain_measurement_read, hwd_phy__rx_sar_cal_measurement_config, hwd_phy__rx_sar_measurement_completed, hwd_phy__rx_sar_measurement_start, hwd_phy_dbg_clk_enable, if_gain__scale_value
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_rx_sar_rssi_measure
hwd_phy_rx_sar_rssi_measure:
	.global L_8d2968
L_8d2968:
	push_s blink
L_8d296a:
	bl L_8c01c8
L_8d296e:
	sub_s sp,sp,0x20
L_8d2970:
	mov_s r13,r0
L_8d2972:
	mov_s r16,r1
L_8d2974:
	mov_s r1,0x101d848
L_8d297a:
	mov_s r0,0x21
L_8d297c:
	bl.d L_8dcc10
L_8d2980:
	mov_s r2,r13
L_8d2982:
	bl.d L_8d1bc0
L_8d2986:
	mov_s r0,0x1
L_8d2988:
	mov_s r15,0x0
L_8d298a:
	mov_s r0,0x1
L_8d298c:
	mov_s r1,r15
L_8d298e:
	mov_s r2,r0
L_8d2990:
	mov_s r3,r15
L_8d2992:
	mov_s r4,r13
L_8d2994:
	bl.d L_8d28ec
L_8d2998:
	mov_s r5,r15
L_8d299a:
	bl.d L_8d2958
L_8d299e:
	mov_s r20,r13
L_8d29a0:
	bl.d L_8d2920
L_8d29a4:
	mov_s r14,0x8
L_8d29a6:
	mov_s r19,r15
	.global L_8d29a8
L_8d29a8:
	extb r0,r19
L_8d29ac:
	mov_s r4,r0
L_8d29ae:
	bl.d L_8d2474
L_8d29b2:
	mov_s r1,sp
L_8d29b4:
	add_s r1,sp,0x10
L_8d29b6:
	bl.d L_8d24bc
L_8d29ba:
	mov_s r0,r4
L_8d29bc:
	bl.d L_8e75fc
L_8d29c0:
	ld_s r0,[sp,0x0]
L_8d29c2:
	mov r21,0x0
L_8d29c6:
	mov_s r4,r0
L_8d29c8:
	bl.d L_8e75fc
L_8d29cc:
	mov_s r0,r13
L_8d29ce:
	mov_s r1,r0
L_8d29d0:
	bl.d L_8c02d4
L_8d29d4:
	mov_s r0,r4
L_8d29d6:
	mov_s r17,r0
L_8d29d8:
	ld_s r1,[sp,0x14]
L_8d29da:
	mov_s r2,r20
L_8d29dc:
	ld_s r0,[sp,0x10]
L_8d29de:
	bl.d L_8c047c
L_8d29e2:
	mov_s r3,r21
L_8d29e4:
	ld_s r2,[sp,0x1c]
L_8d29e6:
	sub r18,r0,r17
L_8d29ea:
	mov_s r1,r2
L_8d29ec:
	ld_s r0,[sp,0x18]
L_8d29ee:
	mov_s r2,r20
L_8d29f0:
	bl.d L_8c047c
L_8d29f4:
	mov_s r3,r21
L_8d29f6:
	add r17,r0,r18
L_8d29fa:
	bl.d L_8e75fc
L_8d29fe:
	ld_s r0,[sp,0x8]
L_8d2a00:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d2a02:
	mov_s r4,r0
L_8d2a04:
	bl.d L_8e75fc
L_8d2a08:
	mov_s r0,r13
L_8d2a0a:
	mov_s r2,r0
L_8d2a0c:
	mov_s r0,r4
L_8d2a0e:
	bl.d L_8c02d4
L_8d2a12:
	mov_s r1,r2
L_8d2a14:
	sub r1,r17,r0
L_8d2a18:
	lsr_s r1,r1
L_8d2a1a:
	add_s r15,r15,r1
L_8d2a1c:
	brhs.d r14,0x1,L_8d29a8
L_8d2a20:
	add r19,r19,0x1
L_8d2a24:
	mov_s r1,0x101d874
L_8d2a2a:
	mov_s r0,0x21
L_8d2a2c:
	bl.d L_8dcc10
L_8d2a30:
	mov_s r2,r15
L_8d2a32:
	lsr r0,r15,0x3
L_8d2a36:
	/* asl_s r0,r0,0x5 */
	.byte 0x05,0xb8
L_8d2a38:
	bl.d L_8d6dcc
L_8d2a3c:
	mov_s r1,0x5
L_8d2a3e:
	lsr r1,r0,0x1f
L_8d2a42:
	add_s r1,r1,r0
L_8d2a44:
	asr_s r1,r1
L_8d2a46:
	st r1,[r16]
L_8d2a4a:
	b.d L_8c021c
L_8d2a4e:
	add_s sp,sp,0x20
