/* tail_memcpy_fw @ 0x8e1aa4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lo_power_gc_ctrl
 * Зовёт сам: memcpy_fw
 */
	.section .text.tail_memcpy_fw,"ax",@progbits
	.global tail_memcpy_fw
tail_memcpy_fw:
	.global L_8e1aa4
L_8e1aa4:
	mov_s r1,r0
L_8e1aa6:
	mov_s r0,0x80047c
L_8e1aac:
	b.d L_8c0460
L_8e1ab0:
	mov_s r2,0x6
L_8e1ab2:
	nop_s
