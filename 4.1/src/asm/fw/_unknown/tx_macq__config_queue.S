/* tx_macq__config_queue @ 0x8c29cc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__setup_macq, tx_macq__setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, tx_macq__set_ba_win, tx_queue__config_by_mode
 */
	.section .text.tx_macq__config_queue,"ax",@progbits
	.global tx_macq__config_queue
tx_macq__config_queue:
	.global L_8c29cc
L_8c29cc:
	push_s blink
L_8c29ce:
	bl L_8c02c4
L_8c29d2:
	sub_s sp,sp,0x10
L_8c29d4:
	mov_s r14,r0
L_8c29d6:
	mov_s r13,sp
L_8c29d8:
	mov_s r0,r13
L_8c29da:
	bl.d L_8f2074
L_8c29de:
	ldb_s r1,[r14,0x1]
L_8c29e0:
	mov_s r0,r14
L_8c29e2:
	bl.d L_8c29b4
L_8c29e6:
	mov_s r1,r13
L_8c29e8:
	b.d L_8c0334
