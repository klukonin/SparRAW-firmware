/* hwd_abif__lpbk_mode_switches_config @ 0x8ceb2c, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__set_loopback, hwm__set_analog_path, hwm_calib__set_loopback_mode, ut_hw_modes_step
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__lpbk_mode_switches_config
hwd_abif__lpbk_mode_switches_config:
	.global L_8ceb2c
L_8ceb2c:
	push_s blink
L_8ceb2e:
	bl L_8c01d8
L_8ceb32:
	mov_s r17,r0
L_8ceb34:
	bic.f r0,r0,0xf
L_8ceb38:
	mov_s r13,r1
L_8ceb3a:
	mov_s r16,r2
L_8ceb3c:
	bne_s L_8ceb8e
	.global L_8ceb3e
L_8ceb3e:
	mov_s r0,0x88b000
L_8ceb44:
	ld.as r2,[r0,-0x54]
L_8ceb48:
	asl r1,r17,0x9
L_8ceb4c:
	and r2,r2,0xffffe1ff
L_8ceb54:
	or_s r1,r1,r2
L_8ceb56:
	st.as r1,[r0,-0x54]
L_8ceb5a:
	bic.f 0x0,r13,0xf
L_8ceb5e:
	bne_s L_8ceb98
	.global L_8ceb60
L_8ceb60:
	mov_s r14,0x88af00
L_8ceb66:
	ld_s r0,[r14,0x58]
L_8ceb68:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8ceb6a:
	bic r0,r0,0xf0
L_8ceb6e:
	or_s r0,r0,r13
L_8ceb70:
	st_s r0,[r14,0x58]
L_8ceb72:
	bic.f 0x0,r16,0xf
L_8ceb76:
	bne_s L_8ceba2
	.global L_8ceb78
L_8ceb78:
	ld_s r0,[r14,0x58]
L_8ceb7a:
	asl r1,r16,0x8
L_8ceb7e:
	and r0,r0,0xfffff0ff
L_8ceb86:
	or_s r0,r0,r1
L_8ceb88:
	st_s r0,[r14,0x58]
L_8ceb8a:
	b L_8c023c
	.global L_8ceb8e
L_8ceb8e:
	mov_s r0,blink
L_8ceb90:
	bl.d L_8c9b28
L_8ceb94:
	mov_s r1,0xac
L_8ceb96:
	b_s L_8ceb3e
	.global L_8ceb98
L_8ceb98:
	mov_s r0,blink
L_8ceb9a:
	bl.d L_8c9b28
L_8ceb9e:
	mov_s r1,0xac
L_8ceba0:
	b_s L_8ceb60
	.global L_8ceba2
L_8ceba2:
	mov_s r0,blink
L_8ceba4:
	bl.d L_8c9b28
L_8ceba8:
	mov_s r1,0xac
L_8cebaa:
	b_s L_8ceb78
