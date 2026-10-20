/* ba_sm__addba_at_10 @ 0x8c7edc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__build_addba_params, tx_macq__setup_params, ut_hw_cmd_008__params
 * Зовёт сам: __ld_r13_to_r13_ret, rf_chain__program_sector_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__addba_at_10
ba_sm__addba_at_10:
	.global L_8c7edc
L_8c7edc:
	push_s blink
L_8c7ede:
	push_s r13
L_8c7ee0:
	mov_s r13,r0
L_8c7ee2:
	add r0,r1,0x10
L_8c7ee6:
	bl.d L_8fa398
L_8c7eea:
	ldb_s r1,[r13,0xb]
L_8c7eec:
	b L_8c025c
