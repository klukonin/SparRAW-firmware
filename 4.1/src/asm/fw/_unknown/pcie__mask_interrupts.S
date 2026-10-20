/* pcie__mask_interrupts @ 0x8cedcc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Clear and mask PCIe interrupts
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: fw_log__emit0
 */
	.section .text.pcie__mask_interrupts,"ax",@progbits
	.global pcie__mask_interrupts
pcie__mask_interrupts:
	.global L_8cedcc
L_8cedcc:
	push_s blink
L_8cedce:
	mov_s r2,0x1018b60
L_8cedd4:
	mov_s r0,0x0
L_8cedd6:
	bl.d L_8edfb0
L_8cedda:
	mov_s r1,0x2
L_8ceddc:
	mov r1,-0x1
L_8cede0:
	mov_s r0,0x882f80
L_8cede6:
	st_s r1,[r0,0x5c]
L_8cede8:
	st_s r1,[r0,0x50]
L_8cedea:
	pop_s blink
L_8cedec:
	j_s [blink]
L_8cedee:
	nop_s
