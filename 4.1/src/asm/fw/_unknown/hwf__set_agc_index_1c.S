/* hwf__set_agc_index_1c @ 0x8e1940, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, ber_test__measure, calib_lo_leakage_run
 * Зовёт сам: __ld_r13_ret, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_agc004_w7
 */
	.section .text.hwf__set_agc_index_1c,"ax",@progbits
	.global hwf__set_agc_index_1c
hwf__set_agc_index_1c:
	.global L_8e1940
L_8e1940:
	push_s blink
L_8e1942:
	push_s r13
L_8e1944:
	mov_s r13,r1
L_8e1946:
	extb_s r2,r2
L_8e1948:
	mov_s r0,0x1c
L_8e194a:
	bl.d L_8ccdac
L_8e194e:
	mov_s r1,0x1
L_8e1950:
	extb_s r2,r13
L_8e1952:
	mov_s r0,0x1c
L_8e1954:
	bl.d L_8ccdac
L_8e1958:
	mov_s r1,0x0
L_8e195a:
	bl.d L_8cb8d8
L_8e195e:
	mov_s r0,0x0
L_8e1960:
	bl.d L_8cb8d8
L_8e1964:
	mov_s r0,0x1
L_8e1966:
	b L_8c033c
L_8e196a:
	nop_s
