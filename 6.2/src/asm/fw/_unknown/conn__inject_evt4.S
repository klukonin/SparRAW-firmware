/* conn__inject_evt4 @ 0x8cb69c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie_serdes__init_seq
 * Зовёт сам: conn__sm_handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__inject_evt4
conn__inject_evt4:
	.global L_8cb69c
L_8cb69c:
	mov_s r1,0x4
L_8cb69e:
	mov_s r2,0x0
L_8cb6a0:
	mov_s r3,r2
L_8cb6a2:
	b.d L_8d9cc0
L_8cb6a6:
	mov_s r4,r2
