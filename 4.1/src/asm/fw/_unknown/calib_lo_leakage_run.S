/* calib_lo_leakage_run @ 0x8e0128, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_lo_leakage_res
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, ber_test__measure, calib_lo__set_result, calib_lo_leakage__prepare_ctx, calib_lo_leakage_step, calib_lo_leakage_substep, get_reg88a204_s1_w32, hwd_abif__set_agc_field, hwf__set_agc_index_1c
 */
	.section .text.calib_lo_leakage_run,"ax",@progbits
	.global calib_lo_leakage_run
calib_lo_leakage_run:
	.global L_8e0128
L_8e0128:
	push_s blink
L_8e012a:
	bl L_8c02b0
L_8e012e:
	mov_s r19,r0
L_8e0130:
	mov_s r18,r1
L_8e0132:
	mov_s r17,r2
L_8e0134:
	mov_s r16,r3
L_8e0136:
	mov_s r1,0x802eec
L_8e013c:
	ld_s r2,[r1]
L_8e013e:
	ld_s r0,[r1,0x4]
L_8e0140:
	st.a r2,[sp,-0x4c]
L_8e0144:
	st_s r0,[sp,0x4]
L_8e0146:
	mov r0,-0x1
L_8e014a:
	st_s r0,[sp,0x40]
L_8e014c:
	st_s r0,[sp,0x44]
L_8e014e:
	ld_s r0,[r1,0x8]
L_8e0150:
	mov_s r14,0x0
L_8e0152:
	st_s r0,[sp,0x48]
L_8e0154:
	add_s r13,sp,0x48
L_8e0156:
	mov_s r0,r19
L_8e0158:
	bl.d L_8c6fd8
L_8e015c:
	mov_s r1,r13
L_8e015e:
	add_s r15,sp,0x8
L_8e0160:
	mov_s r0,r15
L_8e0162:
	mov_s r1,r14
L_8e0164:
	mov_s r2,0x7f
L_8e0166:
	mov_s r3,r14
L_8e0168:
	bl.d L_8ea598
L_8e016c:
	mov_s r4,r2
L_8e016e:
	b_s L_8e01cc
	.global L_8e0170
L_8e0170:
	ld r4,[r0, 0x4]
L_8e0174:
	mov_s r0,r15
L_8e0176:
	bl.d L_8f0c40
L_8e017a:
	mov r5,r4
L_8e017e:
	ld_s r1,[sp,0x0]
L_8e0180:
	mov_s r0,r19
L_8e0182:
	bl.d L_8e1940
L_8e0186:
	ld_s r2,[sp,0x4]
L_8e0188:
	mov_s r0,r19
L_8e018a:
	bl.d L_8d8eac
L_8e018e:
	mov_s r1,r13
L_8e0190:
	mov_s r0,r19
L_8e0192:
	bl.d L_8c6fd8
L_8e0196:
	mov_s r1,r13
L_8e0198:
	mov r0,0x320
L_8e019c:
	mov lp_count,r0
L_8e01a0:
	nop_s
L_8e01a2:
	lp L_8e01aa
L_8e01a6:
	nop_s
L_8e01a8:
	nop_s
	.global L_8e01aa
L_8e01aa:
	mov_s r0,r19
L_8e01ac:
	bl.d L_8d8eac
L_8e01b0:
	mov_s r1,r13
L_8e01b2:
	mov_s r0,r19
L_8e01b4:
	bl.d L_8c6fd8
L_8e01b8:
	mov_s r1,r13
L_8e01ba:
	mov r4,sp
L_8e01be:
	add_s r3,sp,0x40
L_8e01c0:
	mov_s r0,r19
L_8e01c2:
	mov_s r1,r15
L_8e01c4:
	bl.d L_8e325c
L_8e01c8:
	mov_s r2,r4
L_8e01ca:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8e01cc
L_8e01cc:
	add3 r0,r16,r14
L_8e01d0:
	ld_s r3,[r0]
L_8e01d2:
	ld_s r1,[sp,0x0]
L_8e01d4:
	ld_s r2,[sp,0x4]
L_8e01d6:
	brne r3,0x0,L_8e0170
L_8e01da:
	mov_s r0,0x854880
L_8e01e0:
	st_s r1,[r0,0x28]
L_8e01e2:
	st_s r2,[r0,0x2c]
L_8e01e4:
	st r1,[r18]
L_8e01e8:
	ld_s r1,[sp,0x4]
L_8e01ea:
	bl.d L_8cc6cc
L_8e01ee:
	st r1,[r17]
L_8e01f2:
	mov_s r16,r0
L_8e01f4:
	mov_s r14,0x1
L_8e01f6:
	mov_s r13,0x4
	.global L_8e01f8
L_8e01f8:
	add r3,sp,r14
L_8e01fc:
	ldb r3,[r3, 0x47]
L_8e0200:
	mov_s r0,r16
L_8e0202:
	mov_s r1,r14
L_8e0204:
	bl.d L_8cc3c8
L_8e0208:
	mov_s r2,0x1
L_8e020a:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e020c:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e020e:
	brhs.d r13,0x1,L_8e01f8
L_8e0212:
	extb_s r14,r14
L_8e0214:
	b.d L_8c030c
