/* calib__start_scheme4 @ 0x8e6fd4, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_set_active_silent_rssi_table
 * Зовёт сам: __ld_r13_to_r13_ret, calib__bits_set32_s20_w12, calib_mngr__engine_start, fw_sysassert_fatal, rf_cfg__get_rf_mask_45e
 * Глобалы (через gp): 0x800408
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib__start_scheme4
calib__start_scheme4:
	.global L_8e6fd4
L_8e6fd4:
	push_s blink
L_8e6fd6:
	push_s r13
L_8e6fd8:
	sub_s sp,sp,0x4
L_8e6fda:
	mov_s r13,r0
L_8e6fdc:
	breq_s r1,0,L_8e6fee
L_8e6fde:
	brne r1,0x1,L_8e6ffa
L_8e6fe2:
	mov_s r0,0x800d04
L_8e6fe8:
	st.as r0,[gp,0xa1]
L_8e6fec:
	b_s L_8e6ffa
	.global L_8e6fee
L_8e6fee:
	mov_s r0,blink
L_8e6ff0:
	mov_s r1,0x1588
L_8e6ff6:
	bl L_8c9b28
	.global L_8e6ffa
L_8e6ffa:
	mov_s r0,0x8042c8
L_8e7000:
	bl L_8ccb3c
L_8e7004:
	mov_s r2,0x0
L_8e7006:
	b_s L_8e7010
	.global L_8e7008
L_8e7008:
	sub_s r1,r0,0x1
L_8e700a:
	and_s r0,r0,r1
L_8e700c:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8e700e:
	extw_s r2,r2
	.global L_8e7010
L_8e7010:
	brne_s r0,0,L_8e7008
L_8e7012:
	mov_s r1,0x0
L_8e7014:
	st_s r1,[r13,0x50]
L_8e7016:
	st_s r1,[sp,0x0]
L_8e7018:
	mov_s r0,sp
L_8e701a:
	bl.d L_8ed430
L_8e701e:
	stb r2,[r13, 0xd0]
L_8e7022:
	mov_s r0,0x4
L_8e7024:
	ld_s r1,[sp,0x0]
L_8e7026:
	mov_s r2,0x1
L_8e7028:
	ldb r3,[r13, 0xd0]
L_8e702c:
	mov_s r4,r2
L_8e702e:
	mov r5,0x0
L_8e7032:
	mov r6,r5
L_8e7036:
	bl.d L_8ca25c
L_8e703a:
	mov r7,r5
L_8e703e:
	b.d L_8c025c
L_8e7042:
	add_s sp,sp,0x4
