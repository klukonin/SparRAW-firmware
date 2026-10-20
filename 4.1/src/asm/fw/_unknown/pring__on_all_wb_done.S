/* pring__on_all_wb_done @ 0x8dcbb8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: sm_pring__all_wb_done_evt
 */
	.section .text.pring__on_all_wb_done,"ax",@progbits
	.global pring__on_all_wb_done
pring__on_all_wb_done:
L_8dcbb8:
	mul64 r0,0x38
L_8dcbbc:
	add r0,mlo,0x8045a4
L_8dcbc4:
	b L_8c29f8
