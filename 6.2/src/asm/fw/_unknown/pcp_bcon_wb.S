/* pcp_bcon_wb @ 0x8f6fec, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_bcon_wb()...free beacon memory status = %x
 * Зовёт сам: TX_API__free_memory, __ld_r13_to_r13_ret, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_bcon_wb
pcp_bcon_wb:
	.global L_8f6fec
L_8f6fec:
	push_s blink
L_8f6fee:
	push_s r13
L_8f6ff0:
	mov_s r13,r0
L_8f6ff2:
	mov_s r2,r1
L_8f6ff4:
	mov_s r1,0x1016f00
L_8f6ffa:
	bl.d L_8dcc10
L_8f6ffe:
	mov_s r0,0x1c
L_8f7000:
	mov_s r1,0x843158
L_8f7006:
	ld_s r0,[r1,0x24]
L_8f7008:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f700a:
	st_s r0,[r1,0x24]
L_8f700c:
	bl.d L_8cb10c
L_8f7010:
	mov_s r0,r13
L_8f7012:
	b L_8c025c
L_8f7016:
	nop_s
