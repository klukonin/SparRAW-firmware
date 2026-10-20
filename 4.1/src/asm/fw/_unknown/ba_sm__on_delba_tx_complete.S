/* ba_sm__on_delba_tx_complete @ 0x8c770c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.ba_sm__on_delba_tx_complete,"ax",@progbits
	.global ba_sm__on_delba_tx_complete
ba_sm__on_delba_tx_complete:
L_8c770c:
	add_s r0,r0,0x74
L_8c770e:
	mov_s r1,0x2
L_8c7710:
	mov_s r2,0x0
L_8c7712:
	mov_s r3,r2
L_8c7714:
	b.d L_8d6a1c
L_8c7718:
	mov_s r4,r2
L_8c771a:
	nop_s
