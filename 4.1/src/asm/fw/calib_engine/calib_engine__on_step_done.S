/* calib_engine__on_step_done @ 0x8e0318, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_engine.cpp
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.calib_engine__on_step_done,"ax",@progbits
	.global calib_engine__on_step_done
calib_engine__on_step_done:
	.byte 0x0f
	.byte 0xf0
	.global sub_8e031a
sub_8e031a:
L_8e031a:
	nop_s
L_8e031c:
	push_s blink
L_8e031e:
	push_s r13
L_8e0320:
	mov_s r13,r1
L_8e0322:
	ld_s r1,[r1,0x48]
L_8e0324:
	brne r0,r1,L_8e033a
	.global L_8e0328
L_8e0328:
	mov_s r0,r13
L_8e032a:
	mov_s r1,0x1
L_8e032c:
	mov_s r2,0x0
L_8e032e:
	mov_s r3,r2
L_8e0330:
	bl.d L_8d6a1c
L_8e0334:
	mov_s r4,r2
L_8e0336:
	b L_8c033c
	.global L_8e033a
L_8e033a:
	mov_s r0,blink
L_8e033c:
	mov_s r2,0x1008a58
L_8e0342:
	mov_s r1,0x8b
L_8e0344:
	bset_s r1,r1,0xc
L_8e0346:
	bl.d L_8c82c0
L_8e034a:
	mov r3,0x15f
L_8e034e:
	b_s L_8e0328
