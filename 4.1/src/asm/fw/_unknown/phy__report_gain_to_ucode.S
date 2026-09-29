/* phy__report_gain_to_ucode @ 0x8d1964, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi__vt1c, hwf_if_gain_fin_est
 * Зовёт сам: __ld_r13_ret, hwd_phy__get_883100, lmac_if_send_cmd_0x11
 */
	.section .text.phy__report_gain_to_ucode,"ax",@progbits
	.global phy__report_gain_to_ucode
phy__report_gain_to_ucode:
	.global L_8d1964
L_8d1964:
	push_s blink
L_8d1966:
	push_s r13
L_8d1968:
	mov_s r13,r0
L_8d196a:
	mov_s r3,0x800d08
L_8d1970:
	ldb r4,[r3, 0x6]
L_8d1974:
	stb r0,[gp, 0xb9]
L_8d1978:
	ldb_s r1,[r3,0x3]
L_8d197a:
	ldb_s r2,[r3,0x4]
L_8d197c:
	bl.d L_8cfc1c
L_8d1980:
	ldb_s r3,[r3,0x5]
L_8d1982:
	mov_s r1,0x8004d8
L_8d1988:
	ldb_s r2,[r1,0x8]
L_8d198a:
	st.as r0,[gp,-0x5a]
L_8d198e:
	sub r0,r13,r2
L_8d1992:
	max r0,r0,0x1
L_8d1996:
	stb_s r0,[r1,0xa]
L_8d1998:
	ldb_s r0,[r1,0x9]
L_8d199a:
	add_s r0,r0,r13
L_8d199c:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d199e:
	min r0,r0,0x3f
L_8d19a2:
	stb_s r0,[r1,0xb]
L_8d19a4:
	mov_s r0,0x1
L_8d19a6:
	bl.d L_8d8b40
L_8d19aa:
	st_s r0,[r1,0xc]
L_8d19ac:
	b L_8c033c
