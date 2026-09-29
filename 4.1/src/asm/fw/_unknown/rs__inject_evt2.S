/* rs__inject_evt2 @ 0x8dbf14, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rs_done__snapshot_stats
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.rs__inject_evt2,"ax",@progbits
	.global rs__inject_evt2
rs__inject_evt2:
	.global L_8dbf14
L_8dbf14:
	mov_s r2,r1
L_8dbf16:
	add_s r0,r0,0x34
L_8dbf18:
	mov_s r1,0x2
L_8dbf1a:
	mov_s r3,0x0
L_8dbf1c:
	b.d L_8d6a1c
