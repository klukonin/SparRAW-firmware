/* radio_mgr__set_tune_result @ 0x8e49f8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_manager_main_sm__on_ch_switch_done, rm_main_sm__secondary_tune_done
 */
	.section .text.radio_mgr__set_tune_result,"ax",@progbits
	.global radio_mgr__set_tune_result
radio_mgr__set_tune_result:
	.global L_8e49f8
L_8e49f8:
	st r2,[r0, 0xd0]
L_8e49fc:
	st r1,[r0, 0xd4]
L_8e4a00:
	j_s.d [blink]
L_8e4a02:
	.byte 0xd8,0x18
