/* radio_manager_main_sm__on_primary_set__rm_st_idle @ 0x8e4a1c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, radio_manager_main_sm__on_primary_set__rm_st_prim_locked, radio_manager_main_sm__on_switch_2_primary
 */
	.section .text.radio_manager_main_sm__on_primary_set__rm_st_idle,"ax",@progbits
	.global radio_manager_main_sm__on_primary_set__rm_st_idle
radio_manager_main_sm__on_primary_set__rm_st_idle:
L_8e4a1c:
	push_s blink
L_8e4a1e:
	push_s r13
L_8e4a20:
	bl.d L_8e1f24
L_8e4a24:
	mov_s r13,r0
L_8e4a26:
	bl.d L_8e32d0
L_8e4a2a:
	mov_s r0,r13
L_8e4a2c:
	b L_8c033c
