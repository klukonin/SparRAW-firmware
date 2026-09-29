/* abif__agc_field_rmw @ 0x8cca00, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power_measure
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_abif__get_agc_field, hwd_abif__set_agc_field
 */
	.section .text.abif__agc_field_rmw,"ax",@progbits
	.global abif__agc_field_rmw
abif__agc_field_rmw:
	.global L_8cca00
L_8cca00:
	push_s blink
L_8cca02:
	bl L_8c02bc
L_8cca06:
	mov_s r16,r0
L_8cca08:
	mov_s r15,r1
L_8cca0a:
	mov_s r14,r2
L_8cca0c:
	bl.d L_8cc834
L_8cca10:
	mov_s r13,r3
L_8cca12:
	sub_s r0,r0,r13
L_8cca14:
	max r0,r0,0x0
L_8cca18:
	min r3,r0,0x1f
L_8cca1c:
	extb_s r3,r3
L_8cca1e:
	mov_s r0,r16
L_8cca20:
	mov_s r1,r15
L_8cca22:
	bl.d L_8cc3c8
L_8cca26:
	mov_s r2,r14
L_8cca28:
	b L_8c0324
