/* pcp_bcon_wb @ 0x8eee38, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_bcon_wb()...free beacon memory status = %x
 * Зовёт сам: TX_API__free_memory, __ld_r13_ret, fw_log__emit1
 */
	.section .text.pcp_bcon_wb,"ax",@progbits
	.global pcp_bcon_wb
pcp_bcon_wb:
L_8eee38:
	push_s blink
L_8eee3a:
	push_s r13
L_8eee3c:
	mov_s r13,r0
L_8eee3e:
	mov_s r3,r1
L_8eee40:
	mov_s r2,0x1012724
L_8eee46:
	mov_s r0,0xc
L_8eee48:
	bl.d L_8edfcc
L_8eee4c:
	mov_s r1,0x1
L_8eee4e:
	mov_s r1,0x843104
L_8eee54:
	ld_s r0,[r1,0x24]
L_8eee56:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eee58:
	st_s r0,[r1,0x24]
L_8eee5a:
	bl.d L_8c94c4
L_8eee5e:
	mov_s r0,r13
L_8eee60:
	b L_8c033c
