/* calib_lo_power__step @ 0x8d5f78, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__step_save_mode, hwf_calib_lo_power_flow
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, abif__set_3bit_all_chains, abif__set_nibble_all_chains, calib_lo_power__save_level, rf__set_8894a0_field, rfc__write_field_484
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo_power__step
calib_lo_power__step:
	.global L_8d5f78
L_8d5f78:
	push_s blink
L_8d5f7a:
	bl L_8c01e0
L_8d5f7e:
	mov_s r15,r1
L_8d5f80:
	mov_s r14,r2
L_8d5f82:
	bl.d L_8d0228
L_8d5f86:
	mov_s r13,r3
L_8d5f88:
	bl.d L_8d01c8
L_8d5f8c:
	mov_s r0,r15
L_8d5f8e:
	bl.d L_8d3ef4
L_8d5f92:
	mov_s r0,r13
L_8d5f94:
	bl.d L_8d0198
L_8d5f98:
	mov_s r0,r13
L_8d5f9a:
	mov_s r0,0x0
L_8d5f9c:
	bl.d L_8d3f80
L_8d5fa0:
	mov_s r1,r14
L_8d5fa2:
	b L_8c024c
L_8d5fa6:
	nop_s
