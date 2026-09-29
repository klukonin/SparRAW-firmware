/* pcie_serdes__shlicht_wa @ 0x8f6f7c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIe serdes configuration shlicht
 * Зовут его: pcie__serdes_init
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_serdes__shlicht_wa
pcie_serdes__shlicht_wa:
	.global L_8f6f7c
L_8f6f7c:
	push_s blink
L_8f6f7e:
	push_s r13
L_8f6f80:
	mov_s r13,0x882f80
L_8f6f86:
	ld_s r0,[r13,0xc]
L_8f6f88:
	and.f 0x0,r0,0x7f0000
L_8f6f90:
	bne_s L_8f6fe6
L_8f6f92:
	mov_s r1,0x1003a2c
L_8f6f98:
	bl.d L_8dcba8
L_8f6f9c:
	mov_s r0,0x2f
L_8f6f9e:
	mov_s r1,0x880b00
L_8f6fa4:
	ld_s r0,[r1,0x8]
L_8f6fa6:
	mov_s r2,0x0
L_8f6fa8:
	bset_s r0,r0,0xb
L_8f6faa:
	st_s r0,[r1,0x8]
L_8f6fac:
	ld_s r0,[r1,0xc]
L_8f6fae:
	mov_s r3,0x882580
L_8f6fb4:
	bset_s r0,r0,0xd
L_8f6fb6:
	st_s r0,[r1,0xc]
L_8f6fb8:
	st_s r2,[r1,0x4]
L_8f6fba:
	ld_s r0,[r13,0xc]
L_8f6fbc:
	or r0,r0,0x7f7f0000
L_8f6fc4:
	st_s r0,[r13,0xc]
L_8f6fc6:
	ld_s r0,[r13,0x10]
L_8f6fc8:
	and r0,r0,0xc0c0c0ff
L_8f6fd0:
	or r0,r0,0x23181800
L_8f6fd8:
	st_s r0,[r13,0x10]
L_8f6fda:
	ld_s r0,[r3,0x3c]
L_8f6fdc:
	bclr_s r0,r0,0x0
L_8f6fde:
	st_s r0,[r3,0x3c]
L_8f6fe0:
	st_s r2,[r1,0xc]
L_8f6fe2:
	st_s r2,[r1,0x8]
L_8f6fe4:
	st_s r2,[r1,0x4]
	.global L_8f6fe6
L_8f6fe6:
	b L_8c025c
L_8f6fea:
	nop_s
