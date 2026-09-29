/* rate_search__commit_mcs @ 0x92fd8c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rate_search__pick_tx_params, tx_flow_substep
 * Зовёт сам: __ld_r13_to_r13_ret, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rate_search__commit_mcs
rate_search__commit_mcs:
	.global L_92fd8c
L_92fd8c:
	push_s blink
L_92fd8e:
	push_s r13
L_92fd90:
	ldb_s r0,[r0]
L_92fd92:
	mul64 r0,0x2c
L_92fd96:
	add r13,mlo,0x802670
L_92fd9e:
	add r0,r13,0x24
L_92fda2:
	bl.d L_920a84
L_92fda6:
	mov_s r1,0x8
L_92fda8:
	ldb_s r0,[r13,0x1a]
L_92fdaa:
	breq_s r0,0,L_92fdae
L_92fdac:
	stb_s r0,[r13,0x1c]
	.global L_92fdae
L_92fdae:
	b L_9202ac
L_92fdb2:
	nop_s
