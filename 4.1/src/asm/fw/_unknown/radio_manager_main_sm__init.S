/* radio_manager_main_sm__init @ 0x8d59b8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_mgr__init_pool_and_sm
 * Зовёт сам: __ld_r13_ret, basic_sm__setup, rm_chan_sw_sm__init
 * Глобалы (через gp): 0x8001d0
 */
	.section .text.radio_manager_main_sm__init,"ax",@progbits
	.global radio_manager_main_sm__init
radio_manager_main_sm__init:
	.global L_8d59b8
L_8d59b8:
	push_s blink
L_8d59ba:
	push_s r13
L_8d59bc:
	mov_s r13,r0
L_8d59be:
	st_s r1,[r0,0x30]
L_8d59c0:
	st_s r2,[r0,0x2c]
L_8d59c2:
	st 0xffff,[r0, 0xd0]
L_8d59ca:
	mov_s r0,0x0
L_8d59cc:
	st r0,[r13, 0xd4]
L_8d59d0:
	add r0,r13,0x34
L_8d59d4:
	bl.d L_8d5d48
L_8d59d8:
	mov_s r1,r13
L_8d59da:
	mov r4,0x801594
L_8d59e2:
	mov r5,0x8015c4
L_8d59ea:
	mov_s r0,r13
L_8d59ec:
	ld.as r1,[gp,0x18]
L_8d59f0:
	mov_s r2,0x0
L_8d59f2:
	mov_s r3,0x802b24
L_8d59f8:
	mov r6,0xc
L_8d59fc:
	bl.d L_8d6478
L_8d5a00:
	mov r7,0x6
L_8d5a04:
	mov_s r0,0x1
L_8d5a06:
	b.d L_8c033c
L_8d5a0a:
	st_s r0,[r13,0x28]
