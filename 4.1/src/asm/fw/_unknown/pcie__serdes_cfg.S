/* pcie__serdes_cfg @ 0x8eec58, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIe serdes configuration shlicht
 * Зовут его: pcie__serdes_init
 * Зовёт сам: __ld_r13_ret, fw_log__emit0
 */
	.section .text.pcie__serdes_cfg,"ax",@progbits
	.global pcie__serdes_cfg
pcie__serdes_cfg:
	.global L_8eec58
L_8eec58:
	push_s blink
L_8eec5a:
	push_s r13
L_8eec5c:
	mov_s r13,0x882f80
L_8eec62:
	ld_s r0,[r13,0xc]
L_8eec64:
	and.f 0x0,r0,0x7f0000
L_8eec6c:
	bne_s L_8eecc4
L_8eec6e:
	mov_s r2,0x1003df0
L_8eec74:
	mov_s r0,0xf
L_8eec76:
	bl.d L_8edfb0
L_8eec7a:
	mov_s r1,0x2
L_8eec7c:
	mov_s r1,0x880b00
L_8eec82:
	ld_s r0,[r1,0x8]
L_8eec84:
	mov_s r2,0x0
L_8eec86:
	bset_s r0,r0,0xb
L_8eec88:
	st_s r0,[r1,0x8]
L_8eec8a:
	ld_s r0,[r1,0xc]
L_8eec8c:
	mov_s r3,0x882580
L_8eec92:
	bset_s r0,r0,0xd
L_8eec94:
	st_s r0,[r1,0xc]
L_8eec96:
	st_s r2,[r1,0x4]
L_8eec98:
	ld_s r0,[r13,0xc]
L_8eec9a:
	or r0,r0,0x7f7f0000
L_8eeca2:
	st_s r0,[r13,0xc]
L_8eeca4:
	ld_s r0,[r13,0x10]
L_8eeca6:
	and r0,r0,0xc0c0c0ff
L_8eecae:
	or r0,r0,0x23181800
L_8eecb6:
	st_s r0,[r13,0x10]
L_8eecb8:
	ld_s r0,[r3,0x3c]
L_8eecba:
	bclr_s r0,r0,0x0
L_8eecbc:
	st_s r0,[r3,0x3c]
L_8eecbe:
	st_s r2,[r1,0xc]
L_8eecc0:
	st_s r2,[r1,0x8]
L_8eecc2:
	st_s r2,[r1,0x4]
	.global L_8eecc4
L_8eecc4:
	b L_8c033c
