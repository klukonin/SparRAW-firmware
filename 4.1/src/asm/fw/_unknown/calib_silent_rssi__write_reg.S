/* calib_silent_rssi__write_reg @ 0x8e1578, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow
 * Зовёт сам: __ld_r13_ret, marlon_r_if__write_reg
 */
	.section .text.calib_silent_rssi__write_reg,"ax",@progbits
	.global calib_silent_rssi__write_reg
calib_silent_rssi__write_reg:
	.global L_8e1578
L_8e1578:
	push_s blink
L_8e157a:
	push_s r13
L_8e157c:
	mov_s r13,r2
L_8e157e:
	asl_s r3,r1,0x4
L_8e1580:
	ldb_s r1,[r0]
L_8e1582:
	mov r2,0x504
L_8e1586:
	bl.d L_8e7f60
L_8e158a:
	or_s r3,r3,r13
L_8e158c:
	b L_8c033c
