/* hwd_phy__rgf_885000_8cf198 @ 0x8cf198, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, phy_ber__read_counters, ut_hw_flows_cmd_0x408
 */
	.section .text.hwd_phy__rgf_885000_8cf198,"ax",@progbits
	.global hwd_phy__rgf_885000_8cf198
hwd_phy__rgf_885000_8cf198:
	.global L_8cf198
L_8cf198:
	mov_s r1,0x885000
L_8cf19e:
	ld_s r0,[r1]
L_8cf1a0:
	bclr_s r0,r0,0x0
L_8cf1a2:
	st_s r0,[r1]
L_8cf1a4:
	j_s [blink]
L_8cf1a6:
	nop_s
