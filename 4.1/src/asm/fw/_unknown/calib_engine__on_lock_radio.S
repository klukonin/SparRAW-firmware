/* calib_engine__on_lock_radio @ 0x8d92b8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_engine.cpp
 * Зовёт сам: RADIO_MGR__lock_secondary, __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.calib_engine__on_lock_radio,"ax",@progbits
	.global calib_engine__on_lock_radio
calib_engine__on_lock_radio:
L_8d92b8:
	push_s blink
L_8d92ba:
	push_s r13
L_8d92bc:
	mov_s r13,r0
L_8d92be:
	ld_s r0,[r0,0x38]
L_8d92c0:
	brne r0,0x1,L_8d92e4
	.global L_8d92c4
L_8d92c4:
	ld_s r0,[r13,0x48]
L_8d92c6:
	brne_s r0,0,L_8d92fc
	.global L_8d92c8
L_8d92c8:
	mov_s r0,0x2031c
L_8d92ce:
	mov_s r1,r13
L_8d92d0:
	mov_s r2,0x0
L_8d92d2:
	mov_s r3,0xffff
L_8d92d8:
	bl.d L_8d938c
L_8d92dc:
	mov_s r4,r2
L_8d92de:
	b.d L_8c033c
L_8d92e2:
	st_s r0,[r13,0x48]
	.global L_8d92e4
L_8d92e4:
	mov_s r0,blink
L_8d92e6:
	mov_s r2,0x1008a58
L_8d92ec:
	mov_s r1,0x1205
L_8d92f2:
	bl.d L_8c82c0
L_8d92f6:
	mov r3,0x131
L_8d92fa:
	b_s L_8d92c4
	.global L_8d92fc
L_8d92fc:
	mov_s r0,blink
L_8d92fe:
	mov_s r2,0x1008a58
L_8d9304:
	mov_s r1,0x11bc
L_8d930a:
	bl.d L_8c82c0
L_8d930e:
	mov r3,0x132
L_8d9312:
	b_s L_8d92c8
