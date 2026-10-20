/* hwf_calib_all @ 0x8d19b0, 424 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   =========  HWF_CALIB_ALL ================
 *   =========  HWF_CALIB_ALL === LO_POWER ===
 *   =========  HWF_CALIB_ALL === VGA-DC (LastDAC) ===
 *   =========  HWF_CALIB_ALL === SAR-DC =============
 *   =========  HWF_CALIB_ALL === BB-GAIN ============
 *   =========  HWF_CALIB_ALL === VGA-DC =============
 *    =========  HWF_CALIB_ALL === IF-GAIN ============
 *    =========  HWF_CALIB_ALL === SILENT-RSSI =============
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_calib__run_step, bf_w_s20_w12, calib__log_if_nonzero, calib_lo_power__vt04, calib_lo_power_measure, calib_lo_power_step, calib_mngr_step_a, calib_sar__enable_path, calib_vga_gain_step, fw_log__emit0
 * Глобалы (через gp): 0x800206, 0x800207
 */
	.section .text.hwf_calib_all,"ax",@progbits
	.global hwf_calib_all
hwf_calib_all:
	.global L_8d19b0
L_8d19b0:
	push_s blink
L_8d19b2:
	bl L_8c02bc
L_8d19b6:
	sub_s sp,sp,0x10
L_8d19b8:
	bl.d L_8e4694
L_8d19bc:
	mov_s r15,0x0
L_8d19be:
	mov_s r16,r0
L_8d19c0:
	mov_s r2,0x101764c
L_8d19c6:
	mov_s r0,0x6
L_8d19c8:
	bl.d L_8edfb0
L_8d19cc:
	mov_s r1,0x2
L_8d19ce:
	mov_s r0,r15
L_8d19d0:
	bl.d L_8d9e84
L_8d19d4:
	mov_s r1,r15
L_8d19d6:
	ldb_s r0,[gp,0x96]
L_8d19d8:
	mov_s r13,0x1
L_8d19da:
	breq_s r0,0,L_8d1a16
L_8d19dc:
	mov_s r2,0x1017678
L_8d19e2:
	mov_s r0,0x6
L_8d19e4:
	bl.d L_8edfb0
L_8d19e8:
	mov_s r1,0x2
L_8d19ea:
	ldb_s r0,[gp,0x97]
L_8d19ec:
	mov_s r2,0x80674c
L_8d19f2:
	brne_s r0,0,L_8d1a00
L_8d19f4:
	bl.d L_8d5fdc
L_8d19f8:
	mov_s r0,r2
L_8d19fa:
	stb r13,[gp, 0x97]
L_8d19fe:
	b_s L_8d1a16
	.global L_8d1a00
L_8d1a00:
	mov_s r0,sp
L_8d1a02:
	mov_s r1,r15
L_8d1a04:
	bl.d L_8e8408
L_8d1a08:
	st_s r15,[sp,0x0]
L_8d1a0a:
	mov_s r0,r2
L_8d1a0c:
	ld_s r1,[sp,0x0]
L_8d1a0e:
	mov_s r2,r13
L_8d1a10:
	bl.d L_8c66a4
L_8d1a14:
	mov_s r3,r13
	.global L_8d1a16
L_8d1a16:
	mov_s r2,0x10176a4
L_8d1a1c:
	mov_s r0,0x6
L_8d1a1e:
	bl.d L_8edfb0
L_8d1a22:
	mov_s r1,0x2
L_8d1a24:
	mov_s r0,0x1
L_8d1a26:
	mov_s r1,r0
L_8d1a28:
	mov_s r2,r0
L_8d1a2a:
	mov_s r3,r0
L_8d1a2c:
	bl.d L_8d3d0c
L_8d1a30:
	mov r4,0xa
L_8d1a34:
	mov_s r0,0x3f
L_8d1a36:
	mov_s r1,r0
L_8d1a38:
	bl.d L_8d3bec
L_8d1a3c:
	mov_s r2,0x1
L_8d1a3e:
	mov_s r0,0x1
L_8d1a40:
	bl.d L_8d3dc0
L_8d1a44:
	mov_s r1,r0
L_8d1a46:
	mov_s r2,0x10176d8
L_8d1a4c:
	mov_s r0,0x6
L_8d1a4e:
	bl.d L_8edfb0
L_8d1a52:
	mov_s r1,0x2
L_8d1a54:
	mov_s r0,0x1
L_8d1a56:
	mov_s r1,r0
L_8d1a58:
	mov_s r2,r0
L_8d1a5a:
	mov_s r3,r0
L_8d1a5c:
	bl.d L_8d3614
L_8d1a60:
	mov r4,0xd
L_8d1a64:
	mov_s r2,0x8004e8
L_8d1a6a:
	ldb_s r0,[r2,0x2]
L_8d1a6c:
	ldb_s r1,[r2,0x1]
L_8d1a6e:
	bl.d L_8d31ac
L_8d1a72:
	ldb_s r2,[r2]
L_8d1a74:
	mov_s r0,0x1
L_8d1a76:
	bl.d L_8d36b4
L_8d1a7a:
	mov_s r1,r0
L_8d1a7c:
	mov_s r2,0x101770c
L_8d1a82:
	mov_s r0,0x6
L_8d1a84:
	bl.d L_8edfb0
L_8d1a88:
	mov_s r1,0x2
L_8d1a8a:
	bl.d L_8d1ebc
L_8d1a8e:
	mov_s r0,0x0
L_8d1a90:
	bl.d L_8d1b58
L_8d1a94:
	mov_s r0,0x0
L_8d1a96:
	bl.d L_8d1f28
L_8d1a9a:
	mov_s r0,0x0
L_8d1a9c:
	mov_s r2,0x1017740
L_8d1aa2:
	mov_s r0,0x6
L_8d1aa4:
	bl.d L_8edfb0
L_8d1aa8:
	mov_s r1,0x2
L_8d1aaa:
	mov_s r0,0x1
L_8d1aac:
	mov_s r1,r0
L_8d1aae:
	mov_s r2,r0
L_8d1ab0:
	mov_s r3,r0
L_8d1ab2:
	bl.d L_8d3d0c
L_8d1ab6:
	mov r4,0xa
L_8d1aba:
	mov_s r0,0x1
L_8d1abc:
	bl.d L_8d3964
L_8d1ac0:
	mov_s r1,0x3f
L_8d1ac2:
	mov_s r13,0x1e
L_8d1ac4:
	mov_s r14,0xb
	.global L_8d1ac6
L_8d1ac6:
	mov_s r0,0x0
L_8d1ac8:
	bl.d L_8cc674
L_8d1acc:
	mov_s r1,r0
L_8d1ace:
	mov_s r0,0x1
L_8d1ad0:
	bl.d L_8cc674
L_8d1ad4:
	mov_s r1,r13
L_8d1ad6:
	mov_s r2,sp
L_8d1ad8:
	mov_s r0,0xff
L_8d1ada:
	bl.d L_8d3f40
L_8d1ade:
	mov_s r1,0xd
L_8d1ae0:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d1ae2:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d1ae4:
	brhs.d r14,0x1,L_8d1ac6
L_8d1ae8:
	extb_s r13,r13
L_8d1aea:
	mov_s r0,0x1
L_8d1aec:
	bl.d L_8d3dc0
L_8d1af0:
	mov_s r1,r0
L_8d1af2:
	mov_s r2,0x1017774
L_8d1af8:
	mov_s r0,0x6
L_8d1afa:
	bl.d L_8edfb0
L_8d1afe:
	mov_s r1,0x2
L_8d1b00:
	bl.d L_8d2f38
L_8d1b04:
	mov_s r0,0x0
L_8d1b06:
	bl.d L_8d2d78
L_8d1b0a:
	mov_s r0,0x0
L_8d1b0c:
	bl.d L_8d3084
L_8d1b10:
	mov_s r0,0x0
L_8d1b12:
	mov_s r2,0x10177a8
L_8d1b18:
	mov_s r0,0x6
L_8d1b1a:
	bl.d L_8edfb0
L_8d1b1e:
	mov_s r1,0x2
L_8d1b20:
	mov_s r0,sp
L_8d1b22:
	mov_s r1,0x1
L_8d1b24:
	bl.d L_8e8408
L_8d1b28:
	st_s r15,[sp,0x0]
L_8d1b2a:
	mov_s r0,0x806740
L_8d1b30:
	ld_s r1,[sp,0x0]
L_8d1b32:
	mov_s r2,0x1
L_8d1b34:
	bl.d L_8c66a4
L_8d1b38:
	mov_s r3,0x1
L_8d1b3a:
	bl L_8e4694
L_8d1b3e:
	mov_s r2,0x10177e4
L_8d1b44:
	sub r0,r0,r16
L_8d1b48:
	asl_s r3,r0,0x4
L_8d1b4a:
	mov_s r0,0x6
L_8d1b4c:
	bl.d L_8edfcc
L_8d1b50:
	mov_s r1,0x2
L_8d1b52:
	b.d L_8c0324
L_8d1b56:
	add_s sp,sp,0x10
