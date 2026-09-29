/* rfc_read_calib_get_min_failures @ 0x8f8060, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rfc_read_calib_get_min_failures: min_failures = %d
 * Зовут его: get_min_failures_mid_biggest_range_index
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc_read_calib_get_min_failures
rfc_read_calib_get_min_failures:
	.global L_8f8060
L_8f8060:
	push_s blink
L_8f8062:
	push_s r13
L_8f8064:
	mov r13,-0x1
L_8f8068:
	mov lp_count,0xa
L_8f806c:
	mov_s r2,0x0
L_8f806e:
	lp L_8f8080
L_8f8072:
	ld.as r1,[r0,r2]
L_8f8076:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8f8078:
	cmp_s r13,r1
L_8f807a:
	mov.cc r13,r1
L_8f807e:
	extb_s r2,r2
	.global L_8f8080
L_8f8080:
	mov_s r1,0x101ea30
L_8f8086:
	mov_s r0,0x20
L_8f8088:
	bl.d L_8dcc10
L_8f808c:
	mov_s r2,r13
L_8f808e:
	b.d L_8c025c
L_8f8092:
	mov_s r0,r13
