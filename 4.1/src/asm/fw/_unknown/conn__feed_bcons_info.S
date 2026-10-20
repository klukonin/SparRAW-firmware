/* conn__feed_bcons_info @ 0x8cb4a4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__foreach_on_boot_done
 * Зовёт сам: bad_beacons_detector__handle_bcons_info
 */
	.section .text.conn__feed_bcons_info,"ax",@progbits
	.global conn__feed_bcons_info
conn__feed_bcons_info:
	.global L_8cb4a4
L_8cb4a4:
	b.d L_8cb4ac
L_8cb4a8:
	add_s r0,r0,0x64
L_8cb4aa:
	nop_s
	.global L_8cb4ac
L_8cb4ac:
	push_s blink
L_8cb4ae:
	ld_s r0,[r0,0x48]
L_8cb4b0:
	cmp_s r0,0x0
L_8cb4b2:
	bl.ne.d L_8caeb4
L_8cb4b6:
	add3.ne r0,r0,0x13
L_8cb4ba:
	pop_s blink
L_8cb4bc:
	j_s [blink]
L_8cb4be:
	nop_s
