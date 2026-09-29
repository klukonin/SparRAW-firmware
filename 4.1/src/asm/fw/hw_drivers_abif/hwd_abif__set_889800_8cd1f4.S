/* hwd_abif__set_889800_8cd1f4 @ 0x8cd1f4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: hwm__reset_analog_block
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, get_reg88afec_s3_w32
 */
	.section .text.hwd_abif__set_889800_8cd1f4,"ax",@progbits
	.global hwd_abif__set_889800_8cd1f4
hwd_abif__set_889800_8cd1f4:
	.global L_8cd1f4
L_8cd1f4:
	push_s blink
L_8cd1f6:
	bl L_8c02c4
L_8cd1fa:
	mov_s r14,0x4
L_8cd1fc:
	mov_s r13,0x889800
L_8cd202:
	st.as r14,[r13,-0xe4]
L_8cd206:
	bl L_8cd27c
L_8cd20a:
	brne r0,0x1,L_8cd216
	.global L_8cd20e
L_8cd20e:
	st.as r14,[r13,-0xdf]
L_8cd212:
	b L_8c0334
	.global L_8cd216
L_8cd216:
	mov_s r0,blink
L_8cd218:
	mov_s r2,0x1019954
L_8cd21e:
	mov_s r1,0x1417
L_8cd224:
	bl.d L_8c82c0
L_8cd228:
	mov r3,0x7b1
L_8cd22c:
	b_s L_8cd20e
L_8cd22e:
	nop_s
