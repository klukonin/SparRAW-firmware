/* hwd_abif__txrx_table_index_lpbk_mode @ 0x8cff68, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm__set_analog_path, ut_hw_modes_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__txrx_table_index_lpbk_mode
hwd_abif__txrx_table_index_lpbk_mode:
	.global L_8cff68
L_8cff68:
	push_s blink
L_8cff6a:
	bl L_8c01dc
L_8cff6e:
	mov_s r16,r0
L_8cff70:
	bic.f r0,r0,0x1f
L_8cff74:
	mov_s r13,r1
L_8cff76:
	bne_s L_8cffae
	.global L_8cff78
L_8cff78:
	mov_s r14,0x88a000
L_8cff7e:
	ld_s r1,[r14]
L_8cff80:
	asl r0,r16,0x10
L_8cff84:
	and r1,r1,0xffe0ffff
L_8cff8c:
	or_s r0,r0,r1
L_8cff8e:
	st_s r0,[r14]
L_8cff90:
	bic.f 0x0,r13,0x3f
L_8cff94:
	bne_s L_8cffb8
	.global L_8cff96
L_8cff96:
	ld.as r0,[r14,0x81]
L_8cff9a:
	asl_s r13,r13,0x13
L_8cff9c:
	and r0,r0,0xfe07ffff
L_8cffa4:
	or_s r0,r0,r13
L_8cffa6:
	st.as r0,[r14,0x81]
L_8cffaa:
	b L_8c0244
	.global L_8cffae
L_8cffae:
	mov_s r0,blink
L_8cffb0:
	bl.d L_8c9b28
L_8cffb4:
	mov_s r1,0xac
L_8cffb6:
	b_s L_8cff78
	.global L_8cffb8
L_8cffb8:
	mov_s r0,blink
L_8cffba:
	bl.d L_8c9b28
L_8cffbe:
	mov_s r1,0xac
L_8cffc0:
	b_s L_8cff96
L_8cffc2:
	nop_s
