/* boot__install_diag_magic @ 0x8d8ec0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: __ld_r13_to_r13_ret, boot_diag__fw_stats_blk_addr, boot_diag__reg_8802bc_addr, boot_diag__reg_8803e8_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__install_diag_magic
boot__install_diag_magic:
	.global L_8d8ec0
L_8d8ec0:
	push_s blink
L_8d8ec2:
	push_s r13
L_8d8ec4:
	mov_s r1,0x880a3c
L_8d8eca:
	st 0xbacacafe,[r1, 0x44]
L_8d8ed2:
	mov_s r13,0x803b70
L_8d8ed8:
	mov_s r0,r13
L_8d8eda:
	st_s r0,[r1,0x48]
L_8d8edc:
	mov_s r0,0x0
L_8d8ede:
	bl.d L_8cc6b4
L_8d8ee2:
	st_s r0,[r13]
L_8d8ee4:
	bl.d L_8cc168
L_8d8ee8:
	st_s r0,[r13,0x4]
L_8d8eea:
	bl.d L_8cc160
L_8d8eee:
	st_s r0,[r13,0x8]
L_8d8ef0:
	b.d L_8c025c
L_8d8ef4:
	st_s r0,[r13,0xc]
L_8d8ef6:
	nop_s
