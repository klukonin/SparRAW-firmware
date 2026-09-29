/* calib_sar__vt1c @ 0x8c66f8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwf_calib_sar_alg
 */
	.section .text.calib_sar__vt1c,"ax",@progbits
	.global calib_sar__vt1c
calib_sar__vt1c:
L_8c66f8:
	sub_s sp,sp,0x4
L_8c66fa:
	push_s blink
L_8c66fc:
	mov_s r2,0x8004e8
L_8c6702:
	ldb_s r0,[r2,0x2]
L_8c6704:
	ldb_s r1,[r2,0x1]
L_8c6706:
	bl.d L_8d31ac
L_8c670a:
	ldb_s r2,[r2]
L_8c670c:
	pop_s blink
L_8c670e:
	j_s.d [blink]
