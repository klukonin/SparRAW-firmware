/* hwf__rf_lo_setup @ 0x8d190c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, rf_lo__refresh_periodic
 * Зовёт сам: __ld_r13_ret, hwd_abif__rgf_889300_8ccb7c, hwd_abif__rgf_889300_8ccc78, hwd_abif__rgf_889480_8ccad8, hwf__rladder_calibrate
 * Глобалы (через gp): 0x8002b8
 */
	.section .text.hwf__rf_lo_setup,"ax",@progbits
	.global hwf__rf_lo_setup
hwf__rf_lo_setup:
	.global L_8d190c
L_8d190c:
	push_s blink
L_8d190e:
	push_s r13
L_8d1910:
	bl.d L_8ccad8
L_8d1914:
	mov_s r0,0x1
L_8d1916:
	bl.d L_8ccb7c
L_8d191a:
	mov_s r0,0x1
L_8d191c:
	bl.d L_8ccc78
L_8d1920:
	mov_s r0,0x1
L_8d1922:
	bl.d L_8d1898
L_8d1926:
	mov_s r0,0x0
L_8d1928:
	ld.as r1,[gp,-0x59]
L_8d192c:
	mul64_s r1,r0
L_8d192e:
	ld.as r1,[gp,0x52]
L_8d1932:
	sub r13,mlo,0x3e666
L_8d193a:
	add_s r13,r13,r1
L_8d193c:
	cmp_s r13,0x0
L_8d193e:
	add.ge r13,r13,0x10
L_8d1942:
	asr.ge r13,r13,0x5
L_8d1946:
	bge_s L_8d1950
L_8d1948:
	rsub r0,r13,0x10
L_8d194c:
	/* asr_s r0,r0,0x5 */
	.byte 0x45,0xb8
L_8d194e:
	neg_s r13,r0
	.global L_8d1950
L_8d1950:
	bl.d L_8ccad8
L_8d1954:
	mov_s r0,0x0
L_8d1956:
	bl.d L_8ccb7c
L_8d195a:
	mov_s r0,0x0
L_8d195c:
	b.d L_8c033c
L_8d1960:
	mov_s r0,r13
L_8d1962:
	nop_s
