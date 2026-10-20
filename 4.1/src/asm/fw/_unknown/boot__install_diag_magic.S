/* boot__install_diag_magic @ 0x8d5d84, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r13_ret, stub_ret_8c9fbc, stub_ret_8c9fc4, stub_ret_8ca49c
 */
	.section .text.boot__install_diag_magic,"ax",@progbits
	.global boot__install_diag_magic
boot__install_diag_magic:
	.global L_8d5d84
L_8d5d84:
	push_s blink
L_8d5d86:
	push_s r13
L_8d5d88:
	mov_s r1,0x880a3c
L_8d5d8e:
	st 0xbacacafe,[r1, 0x44]
L_8d5d96:
	mov_s r13,0x8033cc
L_8d5d9c:
	mov_s r0,r13
L_8d5d9e:
	st_s r0,[r1,0x48]
L_8d5da0:
	mov_s r0,0x0
L_8d5da2:
	bl.d L_8ca49c
L_8d5da6:
	st_s r0,[r13]
L_8d5da8:
	bl.d L_8c9fc4
L_8d5dac:
	st_s r0,[r13,0x4]
L_8d5dae:
	bl.d L_8c9fbc
L_8d5db2:
	st_s r0,[r13,0x8]
L_8d5db4:
	b.d L_8c033c
L_8d5db8:
	st_s r0,[r13,0xc]
L_8d5dba:
	nop_s
