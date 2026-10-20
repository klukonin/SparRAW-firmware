/* tx_macq__set_ba_win @ 0x8c29b4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_macq__config_queue
 * Зовёт сам: mac_indirect__write_entry
 */
	.section .text.tx_macq__set_ba_win,"ax",@progbits
	.global tx_macq__set_ba_win
tx_macq__set_ba_win:
	.global L_8c29b4
L_8c29b4:
	ldb_s r2,[r0]
L_8c29b6:
	mov_s r0,r1
L_8c29b8:
	mov_s r1,r2
L_8c29ba:
	mov_s r2,0x2
L_8c29bc:
	mov_s r3,0x0
L_8c29be:
	mov_s r4,r3
L_8c29c0:
	mov_s r5,r3
L_8c29c2:
	mov_s r6,r2
L_8c29c4:
	b.d L_8c46a4
L_8c29c8:
	mov r7,0x1
