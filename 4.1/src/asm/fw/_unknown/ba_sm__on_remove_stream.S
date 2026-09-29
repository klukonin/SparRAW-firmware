/* ba_sm__on_remove_stream @ 0x8c39d8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.ba_sm__on_remove_stream,"ax",@progbits
	.global ba_sm__on_remove_stream
ba_sm__on_remove_stream:
L_8c39d8:
	add_s r0,r0,0x2c
L_8c39da:
	mov_s r1,0xb
L_8c39dc:
	mov_s r2,0x0
L_8c39de:
	mov_s r3,r2
L_8c39e0:
	b.d L_8d6a1c
