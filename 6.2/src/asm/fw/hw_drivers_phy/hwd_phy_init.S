/* hwd_phy_init @ 0x8d1ccc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main, hwd_phy__power_up_seq
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_init
hwd_phy_init:
	.global L_8d1ccc
L_8d1ccc:
	push_s blink
L_8d1cce:
	push_s r13
L_8d1cd0:
	mov_s r13,0x0
L_8d1cd2:
	b_s L_8d1ce0
	.global L_8d1cd4
L_8d1cd4:
	ld_s r2,[r1]
L_8d1cd6:
	ld_s r0,[r0,0x4]
L_8d1cd8:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d1cda:
	st_s r0,[r1]
L_8d1cdc:
	brhs r13,0x28,L_8d1cf6
	.global L_8d1ce0
L_8d1ce0:
	mov_s r0,0x8067dc
L_8d1ce6:
	add3_s r0,r0,r13
L_8d1ce8:
	ld_s r1,[r0]
L_8d1cea:
	brne r1,0xe0d0e0d,L_8d1cd4
L_8d1cf2:
	b L_8c025c
	.global L_8d1cf6
L_8d1cf6:
	mov_s r0,blink
L_8d1cf8:
	mov_s r1,0x133f
L_8d1cfe:
	bl L_8c9b28
L_8d1d02:
	b_s L_8d1ce0
