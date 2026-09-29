/* hwd_phy__rgf_885000_8cf184 @ 0x8cf184, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, phy_ber__read_counters, ut_hw_flows_cmd_0x407, ut_hw_flows_cmd_0x408
 */
	.section .text.hwd_phy__rgf_885000_8cf184,"ax",@progbits
	.global hwd_phy__rgf_885000_8cf184
hwd_phy__rgf_885000_8cf184:
	.global L_8cf184
L_8cf184:
	mov_s r1,0x885000
L_8cf18a:
	ld_s r0,[r1]
L_8cf18c:
	bclr_s r0,r0,0x0
L_8cf18e:
	bclr_s r0,r0,0x6
L_8cf190:
	or r0,r0,0x41
L_8cf194:
	st_s r0,[r1]
L_8cf196:
	j_s [blink]
