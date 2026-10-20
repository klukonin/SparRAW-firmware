/* hwd_pcie_config_lnkctl @ 0x8ceb10, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_config_lnkctl:: EP under SWITCH Not supported!!!
 * Зовут его: pcie__pm_host_config
 * Зовёт сам: fw_log__emit0, get_reg8825bc_bit3_inv, pcie_serdes_step
 */
	.section .text.hwd_pcie_config_lnkctl,"ax",@progbits
	.global hwd_pcie_config_lnkctl
hwd_pcie_config_lnkctl:
	.global L_8ceb10
L_8ceb10:
	push_s blink
L_8ceb12:
	bl.d L_8ce774
L_8ceb16:
	mov_s r6,r0
L_8ceb18:
	breq_s r0,0,L_8ceb2e
L_8ceb1a:
	mov_s r0,0x80
L_8ceb1c:
	mov_s r1,0x0
L_8ceb1e:
	mov_s r2,0x1
L_8ceb20:
	mov_s r3,r1
L_8ceb22:
	mov_s r4,r1
L_8ceb24:
	bl.d L_8eaa64
L_8ceb28:
	mov r5,0x1
L_8ceb2c:
	b_s L_8ceb3c
	.global L_8ceb2e
L_8ceb2e:
	mov_s r2,0x1018ca0
L_8ceb34:
	mov_s r0,0x1
L_8ceb36:
	bl.d L_8edfb0
L_8ceb3a:
	mov_s r1,0x0
	.global L_8ceb3c
L_8ceb3c:
	pop_s blink
L_8ceb3e:
	j_s [blink]
