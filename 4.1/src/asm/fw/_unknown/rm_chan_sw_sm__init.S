/* rm_chan_sw_sm__init @ 0x8d5d48, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_manager_main_sm__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__setup
 * Глобалы (через gp): 0x8001d4
 */
	.section .text.rm_chan_sw_sm__init,"ax",@progbits
	.global rm_chan_sw_sm__init
rm_chan_sw_sm__init:
	.global L_8d5d48
L_8d5d48:
	push_s blink
L_8d5d4a:
	bl.d L_8c02c4
L_8d5d4e:
	mov r6,0x7
L_8d5d52:
	mov_s r13,r0
L_8d5d54:
	st_s r1,[r0,0x2c]
L_8d5d56:
	mov r4,0x8015dc
L_8d5d5e:
	mov r5,0x8015f8
L_8d5d66:
	ld.as r1,[gp,0x19]
L_8d5d6a:
	mov_s r14,0x0
L_8d5d6c:
	mov_s r2,r14
L_8d5d6e:
	mov_s r3,0x802c8c
L_8d5d74:
	bl.d L_8d6478
L_8d5d78:
	mov r7,0x3
L_8d5d7c:
	b.d L_8c0334
L_8d5d80:
	st_s r14,[r13,0x28]
L_8d5d82:
	nop_s
