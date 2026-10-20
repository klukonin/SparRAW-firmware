/* hwd_pcie_lnkctl_set @ 0x8ceb40, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_lnkctl_set:: EP under SWITCH Not supported yet!!!
 * Зовут его: pcie__pm_host_config
 * Зовёт сам: fw_log__emit0, get_reg8825bc_bit3_inv, hwd_pcie_dbi_write
 */
	.section .text.hwd_pcie_lnkctl_set,"ax",@progbits
	.global hwd_pcie_lnkctl_set
hwd_pcie_lnkctl_set:
	.global L_8ceb40
L_8ceb40:
	push_s blink
L_8ceb42:
	sub_s sp,sp,0x4
L_8ceb44:
	bl.d L_8ce774
L_8ceb48:
	mov_s r1,r0
L_8ceb4a:
	mov_s r2,0x0
L_8ceb4c:
	breq_s r0,0,L_8ceb68
L_8ceb4e:
	st_s r2,[sp,0x0]
L_8ceb50:
	mov_s r0,0x80
L_8ceb52:
	ld_s r1,[r1]
L_8ceb54:
	mov_s r3,0x1
L_8ceb56:
	mov_s r4,r2
L_8ceb58:
	mov_s r5,r2
L_8ceb5a:
	mov r6,0x1
L_8ceb5e:
	bl.d L_8eab94
L_8ceb62:
	mov r7,0x1
L_8ceb66:
	b_s L_8ceb78
	.global L_8ceb68
L_8ceb68:
	mov_s r3,0x1018cdc
L_8ceb6e:
	mov_s r0,0x1
L_8ceb70:
	mov_s r1,r2
L_8ceb72:
	bl.d L_8edfb0
L_8ceb76:
	mov_s r2,r3
	.global L_8ceb78
L_8ceb78:
	add_s sp,sp,0x4
L_8ceb7a:
	pop_s blink
L_8ceb7c:
	j_s [blink]
L_8ceb7e:
	nop_s
