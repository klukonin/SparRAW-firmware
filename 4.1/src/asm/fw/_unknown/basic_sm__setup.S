/* basic_sm__setup @ 0x8d6478, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_setup_sm__init, ba_sm__init, ba_td_subsm__init, calib_engine__init, channels_switch_sm__init, conn_msm__init, disconn_sm__init, find_main_sm__init, link_stats_sm__init, lm_main_sm__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.basic_sm__setup,"ax",@progbits
	.global basic_sm__setup
basic_sm__setup:
	.global L_8d6478
L_8d6478:
	push_s blink
L_8d647a:
	bl L_8c02c0
L_8d647e:
	stb_s r2,[r0]
L_8d6480:
	st_s r1,[r0,0x24]
L_8d6482:
	st_s r3,[r0,0x18]
L_8d6484:
	st r5,[r0, 0x1c]
L_8d6488:
	st r4,[r0, 0x20]
L_8d648c:
	stb r6,[r0, 0x1]
L_8d6490:
	stb r7,[r0, 0x2]
L_8d6494:
	mov_s r1,0x0
L_8d6496:
	st_s r1,[r0,0x4]
L_8d6498:
	b.d L_8c032c
L_8d649c:
	st_s r1,[r0,0x28]
L_8d649e:
	nop_s
