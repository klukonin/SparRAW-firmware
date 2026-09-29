/* radio_manager_main_sm__on_primary_unset__rm_st_idle @ 0x8e559c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked
 */
	.section .text.radio_manager_main_sm__on_primary_unset__rm_st_idle,"ax",@progbits
	.global radio_manager_main_sm__on_primary_unset__rm_st_idle
radio_manager_main_sm__on_primary_unset__rm_st_idle:
	.global L_8e559c
L_8e559c:
	st 0xffff,[r0, 0x74]
L_8e55a4:
	mov_s r1,0x0
L_8e55a6:
	j_s.d [blink]
L_8e55a8:
	st_s r1,[r0,0x78]
L_8e55aa:
	nop_s
