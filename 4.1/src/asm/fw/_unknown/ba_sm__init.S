/* ba_sm__init @ 0x8d61f0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__init_bcast_ctx
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ba_setup_sm__init, ba_td_subsm__init, basic_sm__setup
 * Глобалы (через gp): 0x8001bc
 */
	.section .text.ba_sm__init,"ax",@progbits
	.global ba_sm__init
ba_sm__init:
	.global L_8d61f0
L_8d61f0:
	push_s blink
L_8d61f2:
	bl L_8c02c4
L_8d61f6:
	mov_s r13,r0
L_8d61f8:
	mov_s r14,r1
L_8d61fa:
	add_s r0,r0,0x2c
L_8d61fc:
	bl.d L_8ed0d0
L_8d6200:
	mov_s r1,r13
L_8d6202:
	add2 r0,r13,0x1d
L_8d6206:
	bl.d L_8d5c4c
L_8d620a:
	mov_s r1,r13
L_8d620c:
	st r14,[r13, 0xac]
L_8d6210:
	mov r4,0x8010bc
L_8d6218:
	mov r5,0x8010ec
L_8d6220:
	mov_s r0,r13
L_8d6222:
	ld.as r1,[gp,0x13]
L_8d6226:
	mov_s r2,0x0
L_8d6228:
	mov_s r3,0x8022cc
L_8d622e:
	mov r6,0xc
L_8d6232:
	bl.d L_8d6478
L_8d6236:
	mov r7,0x5
L_8d623a:
	mov_s r0,0x1
L_8d623c:
	b.d L_8c0334
L_8d6240:
	st_s r0,[r13,0x28]
L_8d6242:
	nop_s
