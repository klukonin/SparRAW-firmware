/* rm__inject_lock_evt_at28 @ 0x8e85a8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: rm_main_sm__inject_lock_evt
 */
	.section .text.rm__inject_lock_evt_at28,"ax",@progbits
	.global rm__inject_lock_evt_at28
rm__inject_lock_evt_at28:
L_8e85a8:
	b.d L_8caf9c
L_8e85ac:
	add_s r0,r0,0x28
L_8e85ae:
	nop_s
