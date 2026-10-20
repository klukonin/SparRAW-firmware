/* mlme_sm__disconnect_log @ 0x8ee7cc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MLME DISCONNECT: reason %d, protocol_reason %d
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn__disconnect, fw_log__emit2
 */
	.section .text.mlme_sm__disconnect_log,"ax",@progbits
	.global mlme_sm__disconnect_log
mlme_sm__disconnect_log:
L_8ee7cc:
	push_s blink
L_8ee7ce:
	bl L_8c02c0
L_8ee7d2:
	mov_s r13,r0
L_8ee7d4:
	mov_s r15,r1
L_8ee7d6:
	mov_s r14,r2
L_8ee7d8:
	mov_s r2,0x100f998
L_8ee7de:
	mov_s r0,0xb
L_8ee7e0:
	mov_s r1,0x2
L_8ee7e2:
	mov_s r3,r15
L_8ee7e4:
	bl.d L_8edff8
L_8ee7e8:
	mov_s r4,r14
L_8ee7ea:
	ld_s r0,[r13,0x2c]
L_8ee7ec:
	mov_s r1,r15
L_8ee7ee:
	ld_s r0,[r0,0x2c]
L_8ee7f0:
	bl.d L_8eb190
L_8ee7f4:
	mov_s r2,r14
L_8ee7f6:
	b L_8c032c
L_8ee7fa:
	nop_s
