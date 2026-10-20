/* radio_manager_main_sm__on_switch_2_primary @ 0x8e32d0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_manager_main_sm__on_primary_set__rm_st_idle, radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked
 * Зовёт сам: __ld_r13_ret, memcpy_fw, rm_main_sm__kick_channel_switch_sm
 */
	.section .text.radio_manager_main_sm__on_switch_2_primary,"ax",@progbits
	.global radio_manager_main_sm__on_switch_2_primary
radio_manager_main_sm__on_switch_2_primary:
	.global L_8e32d0
L_8e32d0:
	push_s blink
L_8e32d2:
	push_s r13
L_8e32d4:
	mov_s r13,r0
L_8e32d6:
	add r0,r0,0x9c
L_8e32da:
	add2 r1,r13,0x1d
L_8e32de:
	bl.d L_8c0460
L_8e32e2:
	mov_s r2,0x28
L_8e32e4:
	bl.d L_8d75dc
L_8e32e8:
	mov_s r0,r13
L_8e32ea:
	mov_s r0,0x0
L_8e32ec:
	b.d L_8c033c
L_8e32f0:
	st r0,[r13, 0x88]
