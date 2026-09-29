/* agc__get_table_pair @ 0x8cb804, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: if_gain, phy_stats__dump, silent_rssi__report_agc_tables
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global agc__get_table_pair
agc__get_table_pair:
	.global L_8cb804
L_8cb804:
	breq_s r1,0,L_8cb80e
L_8cb806:
	ld_s r1,[r0,0x38]
L_8cb808:
	st_s r1,[r2]
L_8cb80a:
	ld_s r0,[r0,0x40]
L_8cb80c:
	b_s L_8cb814
	.global L_8cb80e
L_8cb80e:
	ld_s r1,[r0,0x3c]
L_8cb810:
	st_s r1,[r2]
L_8cb812:
	ld_s r0,[r0,0x44]
	.global L_8cb814
L_8cb814:
	j_s.d [blink]
L_8cb816:
	st_s r0,[r3]
