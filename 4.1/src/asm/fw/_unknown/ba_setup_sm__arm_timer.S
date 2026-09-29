/* ba_setup_sm__arm_timer @ 0x8e91f8, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm.cpp
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, u_schd__schedule
 * Глобалы (через gp): 0x800298
 */
	.section .text.ba_setup_sm__arm_timer,"ax",@progbits
	.global ba_setup_sm__arm_timer
ba_setup_sm__arm_timer:
L_8e91f8:
	push_s blink
L_8e91fa:
	push_s r13
L_8e91fc:
	mov_s r13,r0
L_8e91fe:
	ld_s r0,[r0,0x30]
L_8e9200:
	brne_s r0,0,L_8e9220
	.global L_8e9202
L_8e9202:
	mov_s r0,0x29238
L_8e9208:
	ld.as r4,[gp,0x4a]
L_8e920c:
	mov_s r1,r13
L_8e920e:
	mov_s r2,0x0
L_8e9210:
	mov_s r3,r2
L_8e9212:
	mov_s r5,r2
L_8e9214:
	bl.d L_8dc92c
L_8e9218:
	mov_s r6,r2
L_8e921a:
	b.d L_8c033c
L_8e921e:
	st_s r0,[r13,0x34]
	.global L_8e9220
L_8e9220:
	mov_s r0,blink
L_8e9222:
	mov_s r2,0x10102c4
L_8e9228:
	mov_s r1,0x1431
L_8e922e:
	bl.d L_8c82c0
L_8e9232:
	mov r3,0x12d
L_8e9236:
	b_s L_8e9202
