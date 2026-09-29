/* ba_sm__addba_at_08 @ 0x8c4540, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__build_addba_params, tx_macq__setup
 * Зовёт сам: __ld_r13_to_r13_ret, qdesc__build_by_type
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__addba_at_08
ba_sm__addba_at_08:
	.global L_8c4540
L_8c4540:
	push_s blink
L_8c4542:
	push_s r13
L_8c4544:
	mov_s r13,r0
L_8c4546:
	add3 r0,r1,0x8
L_8c454a:
	bl.d L_8fa224
L_8c454e:
	ldb_s r1,[r13,0xb]
L_8c4550:
	b L_8c025c
