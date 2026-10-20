/* tbl_8018b5__byte_by_index @ 0x92c320, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__release_sta, bf_sm__reset_sta_rate, bf_sm__start_request
 */
	.section .text.tbl_8018b5__byte_by_index,"ax",@progbits
	.global tbl_8018b5__byte_by_index
tbl_8018b5__byte_by_index:
	.global L_92c320
L_92c320:
	mov_s r1,0x8018b5
L_92c326:
	mul64 r0,0x26
L_92c32a:
	j_s.d [blink]
L_92c32c:
	ldb r0,[r1,mlo]
