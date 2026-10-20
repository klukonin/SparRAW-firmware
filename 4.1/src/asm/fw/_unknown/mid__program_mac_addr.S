/* mid__program_mac_addr @ 0x8d5e64, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open
 * Зовёт сам: mac__pack_addr_word, set_reg_88c048_x2
 */
	.section .text.mid__program_mac_addr,"ax",@progbits
	.global mid__program_mac_addr
mid__program_mac_addr:
	.global L_8d5e64
L_8d5e64:
	push_s blink
L_8d5e66:
	st_s r1,[r0]
L_8d5e68:
	mov_s r1,0x0
L_8d5e6a:
	mov_s r0,0x857260
L_8d5e70:
	bl.d L_8ce0fc
L_8d5e74:
	stb_s r1,[r0,0xc]
L_8d5e76:
	bl L_8ce0c8
L_8d5e7a:
	pop_s blink
L_8d5e7c:
	j_s [blink]
L_8d5e7e:
	nop_s
