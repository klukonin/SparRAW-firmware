/* set_reg_880a44 @ 0x8e35cc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init, fw_sysassert_fatal, l2_mgr__connect, l2mgr__data_port_open, l2mgr__disconnect_done, l2mgr__publish_assoc_done
 */
	.section .text.set_reg_880a44,"ax",@progbits
	.global set_reg_880a44
set_reg_880a44:
	.global L_8e35cc
L_8e35cc:
	mov_s r1,0x880a3c
L_8e35d2:
	j_s.d [blink]
L_8e35d4:
	st_s r0,[r1,0x8]
L_8e35d6:
	nop_s
