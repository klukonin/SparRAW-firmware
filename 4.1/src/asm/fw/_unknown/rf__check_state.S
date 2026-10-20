/* rf__check_state @ 0x8c64bc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Checking RF state: com_test=%d, RX_GAIN_RTYPE_TBL_[13]=0x%x (expected 0xc45)
 * Зовут его: agc_start_index
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, rf_comm_test, tail_hwd_rfc_read_rgf
 */
	.section .text.rf__check_state,"ax",@progbits
	.global rf__check_state
rf__check_state:
	.global L_8c64bc
L_8c64bc:
	push_s blink
L_8c64be:
	bl L_8c02c4
L_8c64c2:
	mov_s r13,0x803e84
L_8c64c8:
	mov_s r0,r13
L_8c64ca:
	bl.d L_8c5cac
L_8c64ce:
	ldb_s r1,[r13]
L_8c64d0:
	mov_s r14,r0
L_8c64d2:
	ldb_s r1,[r13]
L_8c64d4:
	mov_s r0,r13
L_8c64d6:
	bl.d L_8ddd74
L_8c64da:
	mov r2,0x1b4
L_8c64de:
	mov_s r4,r0
L_8c64e0:
	mov_s r2,0x1008870
L_8c64e6:
	mov_s r0,0x6
L_8c64e8:
	mov_s r1,0x0
L_8c64ea:
	bl.d L_8edff8
L_8c64ee:
	mov_s r3,r14
L_8c64f0:
	b L_8c0334
