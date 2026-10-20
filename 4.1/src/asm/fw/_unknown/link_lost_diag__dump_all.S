/* link_lost_diag__dump_all @ 0x8eac24, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: link_lost_diag__dump_dma, link_lost_diag__dump_false_alarms, link_lost_diag__dump_mac_rx, link_lost_diag__dump_pcie, link_lost_diag__dump_rf, stub_ret_8c7160
 */
	.section .text.link_lost_diag__dump_all,"ax",@progbits
	.global link_lost_diag__dump_all
link_lost_diag__dump_all:
	.global L_8eac24
L_8eac24:
	push_s blink
L_8eac26:
	bl L_8eae1c
L_8eac2a:
	bl L_8eac08
L_8eac2e:
	bl L_8ead38
L_8eac32:
	bl L_8eae60
L_8eac36:
	mov_s r0,0x803e84
L_8eac3c:
	bl L_8eaea4
L_8eac40:
	bl L_8c7160
L_8eac44:
	pop_s blink
L_8eac46:
	j_s [blink]
