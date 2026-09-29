/* rx_chain__configure @ 0x8c3b48, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed, wmi_handler_cfg_rx_chain
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_indirect__write_entry, rx_queue__config_by_kind
 */
	.section .text.rx_chain__configure,"ax",@progbits
	.global rx_chain__configure
rx_chain__configure:
	.global L_8c3b48
L_8c3b48:
	push_s blink
L_8c3b4a:
	bl.d L_8c02c4
L_8c3b4e:
	mov_s r9,r1
L_8c3b50:
	mov_s r14,r0
L_8c3b52:
	mov_s r8,r2
L_8c3b54:
	mov_s r7,r3
L_8c3b56:
	mov r5,r4
L_8c3b5a:
	mov_s r13,0x84863c
L_8c3b60:
	ld r6,[r0, 0x8]
L_8c3b64:
	mov_s r0,r13
L_8c3b66:
	ldb_s r1,[r14,0x1]
L_8c3b68:
	mov_s r2,r9
L_8c3b6a:
	mov_s r3,r8
L_8c3b6c:
	bl.d L_8df50c
L_8c3b70:
	mov r4,r7
L_8c3b74:
	mov_s r0,r13
L_8c3b76:
	ldb_s r1,[r14]
L_8c3b78:
	mov_s r2,0x1
L_8c3b7a:
	mov_s r3,0x3
L_8c3b7c:
	mov r4,0x0
L_8c3b80:
	mov r5,r4
L_8c3b84:
	mov r6,r4
L_8c3b88:
	bl.d L_8c46a4
L_8c3b8c:
	mov_s r7,r3
L_8c3b8e:
	b L_8c0334
L_8c3b92:
	nop_s
