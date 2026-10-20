/* radio_mgr__copy_tune_params @ 0x8e59f4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_manager_main_sm__on_sec_tune, switch_2_secondary
 */
	.section .text.radio_mgr__copy_tune_params,"ax",@progbits
	.global radio_mgr__copy_tune_params
radio_mgr__copy_tune_params:
	.global L_8e59f4
L_8e59f4:
	ld_s r2,[r1,0x18]
L_8e59f6:
	add3 r3,r0,0x10
L_8e59fa:
	st_s r2,[r3,0x1c]
L_8e59fc:
	ld_s r2,[r1,0x1c]
L_8e59fe:
	st_s r2,[r3,0x20]
L_8e5a00:
	mov_s r2,0x1
L_8e5a02:
	st_s r2,[r3,0x24]
L_8e5a04:
	mov_s r2,0x0
L_8e5a06:
	st_s r2,[r3,0x30]
L_8e5a08:
	st_s r2,[r3,0x28]
L_8e5a0a:
	ldb r1,[r1, 0x20]
L_8e5a0e:
	j_s.d [blink]
L_8e5a10:
	stb r1,[r0, 0xc0]
