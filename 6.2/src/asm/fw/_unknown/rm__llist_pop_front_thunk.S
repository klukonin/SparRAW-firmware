/* rm__llist_pop_front_thunk @ 0x8e0bc8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__lock_primary, rm_sm__action_8e83f4
 * Зовёт сам: llist__pop_front
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm__llist_pop_front_thunk
rm__llist_pop_front_thunk:
	.global L_8e0bc8
L_8e0bc8:
	b L_8e2674
