/* pring__on_eop @ 0x8dcbc8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: sm_pring__eop_evt
 */
	.section .text.pring__on_eop,"ax",@progbits
	.global pring__on_eop
pring__on_eop:
L_8dcbc8:
	mul64 r0,0x38
L_8dcbcc:
	add r0,mlo,0x8045a4
L_8dcbd4:
	b L_8c810c
