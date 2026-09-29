/* lmac_if__ucode_init @ 0x8edc94, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Initializing uCode interface
 *   Reseting the uCode
 *   Unmask the uCode interrupts
 *   lmac_if.cpp
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: fw_log__emit0, fw_sysassert_fatal, lmac_if__build_cmd_rings
 * Глобалы (через gp): 0x8003a8
 */
	.section .text.lmac_if__ucode_init,"ax",@progbits
	.global lmac_if__ucode_init
lmac_if__ucode_init:
	.global L_8edc94
L_8edc94:
	push_s blink
L_8edc96:
	mov_s r2,0x1004c10
L_8edc9c:
	mov_s r0,0x0
L_8edc9e:
	bl.d L_8edfb0
L_8edca2:
	mov_s r1,0x2
L_8edca4:
	ld_s r0,[gp,0x238]
L_8edca6:
	brne_s r0,0,L_8edcf0
	.global L_8edca8
L_8edca8:
	mov_s r0,0x803e3c
L_8edcae:
	bl L_8f11b4
L_8edcb2:
	mov_s r2,0x1004c30
L_8edcb8:
	mov_s r0,0x0
L_8edcba:
	bl.d L_8edfb0
L_8edcbe:
	mov_s r1,0x2
L_8edcc0:
	mov_s r1,0x31
L_8edcc2:
	mov_s r0,0x880180
L_8edcc8:
	st_s r1,[r0,0x7c]
L_8edcca:
	sync
L_8edcce:
	mov_s r2,0x1004c44
L_8edcd4:
	mov_s r0,0x0
L_8edcd6:
	bl.d L_8edfb0
L_8edcda:
	mov_s r1,0x2
L_8edcdc:
	mov r1,0x200
L_8edce0:
	mov_s r0,0x880b00
L_8edce6:
	st_s r1,[r0,0x64]
L_8edce8:
	sync
L_8edcec:
	pop_s blink
L_8edcee:
	j_s [blink]
	.global L_8edcf0
L_8edcf0:
	mov_s r0,blink
L_8edcf2:
	mov_s r2,0x1003e50
L_8edcf8:
	mov_s r1,0x45
L_8edcfa:
	bset_s r1,r1,0xc
L_8edcfc:
	bl.d L_8c82c0
L_8edd00:
	mov r3,0x105
L_8edd04:
	b_s L_8edca8
L_8edd06:
	nop_s
