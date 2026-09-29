/* disassoc_done @ 0x8eaff0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   disassoc_done() Stop DISCONNECT WD if running
 *   DISC SM - spurious Disassoc Done notification.
 * Зовёт сам: TX_CTRL_API__flush_connection, __ld_r13_ret, fw_log__emit0, lmac_if_send_cmd_0x0f, u_schd__cancel
 */
	.section .text.disassoc_done,"ax",@progbits
	.global disassoc_done
disassoc_done:
L_8eaff0:
	push_s blink
L_8eaff2:
	push_s r13
L_8eaff4:
	mov_s r13,r0
L_8eaff6:
	ld_s r0,[r0,0x40]
L_8eaff8:
	breq_s r0,0,L_8eb012
L_8eaffa:
	mov_s r2,0x100f8b8
L_8eb000:
	mov_s r0,0xb
L_8eb002:
	bl.d L_8edfb0
L_8eb006:
	mov_s r1,0x1
L_8eb008:
	bl.d L_8c7794
L_8eb00c:
	ld_s r0,[r13,0x40]
L_8eb00e:
	mov_s r0,0x0
L_8eb010:
	st_s r0,[r13,0x40]
	.global L_8eb012
L_8eb012:
	ld_s r0,[r13,0x30]
L_8eb014:
	bbit0 r0,0x3,L_8eb038
L_8eb018:
	bic r0,r0,0x9
L_8eb01c:
	bset_s r0,r0,0x0
L_8eb01e:
	st_s r0,[r13,0x30]
L_8eb020:
	ld_s r0,[r13,0x2c]
L_8eb022:
	ld_s r0,[r0,0x2c]
L_8eb024:
	bl.d L_8c8ebc
L_8eb028:
	ldb_s r0,[r0,0x8]
L_8eb02a:
	ld_s r0,[r13,0x2c]
L_8eb02c:
	ld_s r0,[r0,0x2c]
L_8eb02e:
	ldb_s r0,[r0,0x8]
L_8eb030:
	bl.d L_8d8a5c
L_8eb034:
	mov_s r1,0x0
L_8eb036:
	b_s L_8eb046
	.global L_8eb038
L_8eb038:
	mov_s r2,0x100f8e8
L_8eb03e:
	mov_s r0,0xb
L_8eb040:
	bl.d L_8edfb0
L_8eb044:
	mov_s r1,0x2
	.global L_8eb046
L_8eb046:
	.byte 0xf9,0x02
