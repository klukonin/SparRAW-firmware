/* link_lost_ntf__disconnect @ 0x8d79f0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LINK LOST NTF -> DISCONNECT
 * Зовёт сам: __ld_r13_ret, conn__disconnect, fw_log__emit0
 */
	.section .text.link_lost_ntf__disconnect,"ax",@progbits
	.global link_lost_ntf__disconnect
link_lost_ntf__disconnect:
	.byte 0x4f
	.byte 0xf4
	.global fwlog_LINK_LOST_NTF_DISCONNECT
fwlog_LINK_LOST_NTF_DISCONNECT:
L_8d79f2:
	nop_s
L_8d79f4:
	b.d L_8d79fc
L_8d79f8:
	ld_s r0,[r0,0x2c]
L_8d79fa:
	nop_s
	.global L_8d79fc
L_8d79fc:
	push_s blink
L_8d79fe:
	push_s r13
L_8d7a00:
	mov_s r13,r0
L_8d7a02:
	mov_s r2,0x1010e1c
L_8d7a08:
	mov_s r0,0xb
L_8d7a0a:
	bl.d L_8edfb0
L_8d7a0e:
	mov_s r1,0x2
L_8d7a10:
	ld_s r0,[r13,0x4]
L_8d7a12:
	mov_s r1,0x1
L_8d7a14:
	bl.d L_8eb190
L_8d7a18:
	mov_s r2,r1
L_8d7a1a:
	b L_8c033c
L_8d7a1e:
	nop_s
