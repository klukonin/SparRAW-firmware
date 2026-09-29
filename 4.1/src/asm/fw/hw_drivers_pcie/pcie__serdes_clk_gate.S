/* pcie__serdes_clk_gate @ 0x8ced44, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, pcie__serdes_init
 */
	.section .text.pcie__serdes_clk_gate,"ax",@progbits
	.global pcie__serdes_clk_gate
pcie__serdes_clk_gate:
	.global L_8ced44
L_8ced44:
	mov_s r2,0x880b00
L_8ced4a:
	mov_s r1,0x882200
L_8ced50:
	cmp_s r0,0x0
L_8ced52:
	ld_s r0,[r2,0x8]
L_8ced54:
	beq_s L_8ced66
L_8ced56:
	bset_s r0,r0,0xb
L_8ced58:
	st_s r0,[r2,0x8]
L_8ced5a:
	ld_s r0,[r2,0x4]
L_8ced5c:
	st_s r0,[r2,0x4]
L_8ced5e:
	ld_s r0,[r1,0x24]
L_8ced60:
	bic r0,r0,0x6
L_8ced64:
	b_s L_8ced74
	.global L_8ced66
L_8ced66:
	bclr_s r0,r0,0xb
L_8ced68:
	st_s r0,[r2,0x8]
L_8ced6a:
	ld_s r0,[r2,0x4]
L_8ced6c:
	st_s r0,[r2,0x4]
L_8ced6e:
	ld_s r0,[r1,0x24]
L_8ced70:
	or r0,r0,0x6
	.global L_8ced74
L_8ced74:
	st_s r0,[r1,0x24]
L_8ced76:
	j_s [blink]
