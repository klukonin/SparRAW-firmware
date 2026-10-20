/* scan_mngr__set_rx_omni_sector @ 0x8f8f44, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: scan_mngr__start_scan
 * Зовёт сам: hw_sysapi_rx_omni_sector_set
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__set_rx_omni_sector
scan_mngr__set_rx_omni_sector:
	.global L_8f8f44
L_8f8f44:
	ldb r0,[r0,0x214]
L_8f8f4c:
	b L_8ce40c
