/* hwd_abif__set_sel_nibbles @ 0x8cbb20, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__set_loopback, hwm__set_analog_path, hwm_calib__set_loopback_mode, ut_hw_modes_step
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__set_sel_nibbles,"ax",@progbits
	.global hwd_abif__set_sel_nibbles
hwd_abif__set_sel_nibbles:
	.global L_8cbb20
L_8cbb20:
	push_s blink
L_8cbb22:
	bl L_8c02b4
L_8cbb26:
	mov_s r18,r0
L_8cbb28:
	bic.f r0,r0,0xf
L_8cbb2c:
	mov_s r16,r1
L_8cbb2e:
	mov_s r17,r2
L_8cbb30:
	bne_s L_8cbb84
	.global L_8cbb32
L_8cbb32:
	mov_s r0,0x88b000
L_8cbb38:
	ld.as r2,[r0,-0x54]
L_8cbb3c:
	asl r1,r18,0x9
L_8cbb40:
	and r2,r2,0xffffe1ff
L_8cbb48:
	or_s r1,r1,r2
L_8cbb4a:
	st.as r1,[r0,-0x54]
L_8cbb4e:
	bic.f 0x0,r16,0xf
L_8cbb52:
	bne_s L_8cbb98
	.global L_8cbb54
L_8cbb54:
	mov_s r13,0x88af00
L_8cbb5a:
	ld_s r0,[r13,0x58]
L_8cbb5c:
	asl r1,r16,0x4
L_8cbb60:
	bic r0,r0,0xf0
L_8cbb64:
	or_s r0,r0,r1
L_8cbb66:
	st_s r0,[r13,0x58]
L_8cbb68:
	bic.f 0x0,r17,0xf
L_8cbb6c:
	bne_s L_8cbbac
	.global L_8cbb6e
L_8cbb6e:
	ld_s r0,[r13,0x58]
L_8cbb70:
	asl r1,r17,0x8
L_8cbb74:
	and r0,r0,0xfffff0ff
L_8cbb7c:
	or_s r0,r0,r1
L_8cbb7e:
	st_s r0,[r13,0x58]
L_8cbb80:
	b L_8c0314
	.global L_8cbb84
L_8cbb84:
	mov_s r0,blink
L_8cbb86:
	mov_s r2,0x1019954
L_8cbb8c:
	mov_s r1,0xac
L_8cbb8e:
	bl.d L_8c82c0
L_8cbb92:
	mov r3,0x1f1
L_8cbb96:
	b_s L_8cbb32
	.global L_8cbb98
L_8cbb98:
	mov_s r0,blink
L_8cbb9a:
	mov_s r2,0x1019954
L_8cbba0:
	mov_s r1,0xac
L_8cbba2:
	bl.d L_8c82c0
L_8cbba6:
	mov r3,0x1f4
L_8cbbaa:
	b_s L_8cbb54
	.global L_8cbbac
L_8cbbac:
	mov_s r0,blink
L_8cbbae:
	mov_s r2,0x1019954
L_8cbbb4:
	mov_s r1,0xac
L_8cbbb6:
	bl.d L_8c82c0
L_8cbbba:
	mov r3,0x1f8
L_8cbbbe:
	b_s L_8cbb6e
