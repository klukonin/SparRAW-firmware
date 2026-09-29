/* radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked @ 0x8e4a08, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: radio_manager_main_sm__on_primary_unset__rm_st_idle, radio_manager_main_sm__on_switch_2_primary
 */
	.section .text.radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked,"ax",@progbits
	.global radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked
radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked:
L_8e4a08:
	push_s blink
L_8e4a0a:
	bl.d L_8e559c
L_8e4a0e:
	mov_s r2,r0
L_8e4a10:
	bl.d L_8e32d0
L_8e4a14:
	mov_s r0,r2
L_8e4a16:
	pop_s blink
