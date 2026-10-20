/* link_lost_diag__dump_all @ 0x8c853c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: calib_obj4__reset_d4, link_lost_diag__dump_dma, link_lost_diag__dump_false_alarms, link_lost_diag__dump_mac_rx, link_lost_diag__dump_pcie, link_lost_diag__dump_rf, link_lost_diag__noop_dump_hook
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag__dump_all
link_lost_diag__dump_all:
	.global L_8c853c
L_8c853c:
	push_s blink
L_8c853e:
	bl L_8c8638
L_8c8542:
	bl L_8c84d4
L_8c8546:
	bl L_8c8568
L_8c854a:
	bl L_8c8678
L_8c854e:
	mov_s r0,0x8042c8
L_8c8554:
	bl L_8c86b4
L_8c8558:
	bl L_8cbb90
L_8c855c:
	bl L_8c8564
L_8c8560:
	pop_s blink
L_8c8562:
	j_s [blink]
