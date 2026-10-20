/* hwd_pcie__port1_serdes_reset @ 0x8d1a00, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, pcie__serdes_init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__port1_serdes_reset
hwd_pcie__port1_serdes_reset:
	.global L_8d1a00
L_8d1a00:
	mov_s r2,0x880b00
L_8d1a06:
	mov_s r1,0x882200
L_8d1a0c:
	cmp_s r0,0x0
L_8d1a0e:
	ld_s r0,[r2,0x8]
L_8d1a10:
	beq_s L_8d1a22
L_8d1a12:
	bset_s r0,r0,0xb
L_8d1a14:
	st_s r0,[r2,0x8]
L_8d1a16:
	ld_s r0,[r2,0x4]
L_8d1a18:
	st_s r0,[r2,0x4]
L_8d1a1a:
	ld_s r0,[r1,0x24]
L_8d1a1c:
	bic r0,r0,0x6
L_8d1a20:
	b_s L_8d1a30
	.global L_8d1a22
L_8d1a22:
	bclr_s r0,r0,0xb
L_8d1a24:
	st_s r0,[r2,0x8]
L_8d1a26:
	ld_s r0,[r2,0x4]
L_8d1a28:
	st_s r0,[r2,0x4]
L_8d1a2a:
	ld_s r0,[r1,0x24]
L_8d1a2c:
	or r0,r0,0x6
	.global L_8d1a30
L_8d1a30:
	st_s r0,[r1,0x24]
L_8d1a32:
	j_s [blink]
