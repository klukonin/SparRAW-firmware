/* bitmap__expand_byte4_to_list @ 0x8ccafc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__run_calibration_fragment
 * Зовёт сам: sm_pring__bind_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bitmap__expand_byte4_to_list
bitmap__expand_byte4_to_list:
	.global L_8ccafc
L_8ccafc:
	mov_s r2,r1
L_8ccafe:
	b.d L_8c4bb4
L_8ccb02:
	ldb_s r1,[r0,0x4]
