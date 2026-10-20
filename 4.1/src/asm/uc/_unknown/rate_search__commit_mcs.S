/* rate_search__commit_mcs @ 0x92c034, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rate_search__pick_tx_params, tx_flow_substep
 * Зовёт сам: __ld_r13_ret_uc, memset0_words_uc
 */
	.section .text.rate_search__commit_mcs,"ax",@progbits
	.global rate_search__commit_mcs
rate_search__commit_mcs:
	.global L_92c034
L_92c034:
	push_s blink
L_92c036:
	push_s r13
L_92c038:
	ldb_s r0,[r0]
L_92c03a:
	mul64 r0,0x2c
L_92c03e:
	add r13,mlo,0x801738
L_92c046:
	add r0,r13,0x24
L_92c04a:
	bl.d L_92166c
L_92c04e:
	mov_s r1,0x8
L_92c050:
	ldb_s r0,[r13,0x1a]
L_92c052:
	breq_s r0,0,L_92c056
L_92c054:
	stb_s r0,[r13,0x1c]
	.global L_92c056
L_92c056:
	b L_92028c
L_92c05a:
	nop_s
