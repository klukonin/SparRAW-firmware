/* ba_setup_sm__on_ready_to_run @ 0x8f169c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm.cpp
 * Зовёт сам: __ld_r13_ret, ba__retry_flow, fw_sysassert_fatal, u_schd__schedule
 * Глобалы (через gp): 0x8002a4
 */
	.section .text.ba_setup_sm__on_ready_to_run,"ax",@progbits
	.global ba_setup_sm__on_ready_to_run
ba_setup_sm__on_ready_to_run:
L_8f169c:
	push_s blink
L_8f169e:
	push_s r13
L_8f16a0:
	mov_s r13,r0
L_8f16a2:
	ld_s r0,[r0,0x38]
L_8f16a4:
	brne_s r0,0,L_8f16ca
	.global L_8f16a6
L_8f16a6:
	mov_s r0,0x29cf8
L_8f16ac:
	ld.as r4,[gp,0x4d]
L_8f16b0:
	mov_s r1,r13
L_8f16b2:
	mov_s r2,0x0
L_8f16b4:
	mov_s r3,r2
L_8f16b6:
	mov_s r5,r2
L_8f16b8:
	bl.d L_8dc92c
L_8f16bc:
	mov_s r6,r2
L_8f16be:
	st_s r0,[r13,0x38]
L_8f16c0:
	bl.d L_8ea2c8
L_8f16c4:
	mov_s r0,r13
L_8f16c6:
	b L_8c033c
	.global L_8f16ca
L_8f16ca:
	mov_s r0,blink
L_8f16cc:
	mov_s r2,0x10102c4
L_8f16d2:
	mov_s r1,0x129a
L_8f16d8:
	bl.d L_8c82c0
L_8f16dc:
	mov_s r3,0xc2
L_8f16de:
	b_s L_8f16a6
