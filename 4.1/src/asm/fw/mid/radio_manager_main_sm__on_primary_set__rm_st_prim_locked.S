/* radio_manager_main_sm__on_primary_set__rm_st_prim_locked @ 0x8e1f24, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_manager_main_sm__on_primary_set__rm_st_idle
 * Зовёт сам: __ld_r13_ret, memcpy_fw
 */
	.section .text.radio_manager_main_sm__on_primary_set__rm_st_prim_locked,"ax",@progbits
	.global radio_manager_main_sm__on_primary_set__rm_st_prim_locked
radio_manager_main_sm__on_primary_set__rm_st_prim_locked:
	.global L_8e1f24
L_8e1f24:
	push_s blink
L_8e1f26:
	push_s r13
L_8e1f28:
	mov_s r13,r0
L_8e1f2a:
	add_s r0,r0,0x74
L_8e1f2c:
	bl.d L_8c0460
L_8e1f30:
	mov_s r2,0x28
L_8e1f32:
	mov_s r0,0x1
L_8e1f34:
	b.d L_8c033c
L_8e1f38:
	st r0,[r13, 0x88]
