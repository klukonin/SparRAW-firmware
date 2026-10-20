/* rx_mgmt__action_no_ack @ 0x8c1d5c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   action no ack - action 0x%x, category_code 0x%x
 *   action no ack - Ignore action 0x%x, category_code 0x%x
 * Зовут его: rx_mgmt_srvs__distribute
 * Зовёт сам: __ld_r13_ret, fw_log__emit2, log_hexdump, mgmt_buf__free, stream_mgr__rx_action
 */
	.section .text.rx_mgmt__action_no_ack,"ax",@progbits
	.global rx_mgmt__action_no_ack
rx_mgmt__action_no_ack:
	.global L_8c1d5c
L_8c1d5c:
	push_s blink
L_8c1d5e:
	push_s r13
L_8c1d60:
	mov_s r13,r0
L_8c1d62:
	ld_s r0,[r0,0x14]
L_8c1d64:
	ldb.a r4,[r0,0x18]
L_8c1d68:
	ldb_s r3,[r0,0x1]
L_8c1d6a:
	cmp r4,0x10
L_8c1d6e:
	cmp.eq r3,0x3
L_8c1d72:
	bne_s L_8c1d8a
L_8c1d74:
	mov_s r2,0x100e6e4
L_8c1d7a:
	mov_s r0,0xb
L_8c1d7c:
	bl.d L_8edff8
L_8c1d80:
	mov_s r1,0x2
L_8c1d82:
	bl.d L_8c1b44
L_8c1d86:
	mov_s r0,r13
L_8c1d88:
	b_s L_8c1da6
	.global L_8c1d8a
L_8c1d8a:
	mov_s r2,0x100e718
L_8c1d90:
	mov_s r0,0xb
L_8c1d92:
	bl.d L_8edff8
L_8c1d96:
	mov_s r1,0x2
L_8c1d98:
	ld_s r0,[r13,0x14]
L_8c1d9a:
	bl.d L_8c7f90
L_8c1d9e:
	ld_s r1,[r13,0x30]
L_8c1da0:
	bl.d L_8c9538
L_8c1da4:
	mov_s r0,r13
	.global L_8c1da6
L_8c1da6:
	b L_8c033c
L_8c1daa:
	nop_s
