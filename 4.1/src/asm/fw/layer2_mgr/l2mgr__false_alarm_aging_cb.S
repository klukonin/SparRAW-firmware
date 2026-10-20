/* l2mgr__false_alarm_aging_cb @ 0x8ea1d8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   check_high_false_alarm_aging_cb g_high_false_alarm_cnt=%d prev_cnt=%d
 *   layer2_mgr.cpp
 * Зовёт сам: fw_log__emit2, fw_sysassert_fatal
 * Глобалы (через gp): 0x80034c
 */
	.section .text.l2mgr__false_alarm_aging_cb,"ax",@progbits
	.global l2mgr__false_alarm_aging_cb
l2mgr__false_alarm_aging_cb:
L_8ea1d8:
	st.a r16,[sp,-0x4]
L_8ea1dc:
	push_s blink
L_8ea1de:
	mov_s r16,r0
L_8ea1e0:
	ld.as r3,[gp,0x77]
L_8ea1e4:
	mov_s r2,0x100ddcc
L_8ea1ea:
	mov_s r0,0xb
L_8ea1ec:
	mov_s r1,0x2
L_8ea1ee:
	bl.d L_8edff8
L_8ea1f2:
	mov r4,r16
L_8ea1f6:
	ld_s r0,[gp,0x1dc]
L_8ea1f8:
	sub r0,r0,r16
L_8ea1fc:
	brlo r0,0x8,L_8ea216
L_8ea200:
	mov_s r0,blink
L_8ea202:
	mov_s r2,0x100c474
L_8ea208:
	mov_s r1,0x142e
L_8ea20e:
	bl.d L_8c82c0
L_8ea212:
	mov r3,0x2fc
	.global L_8ea216
L_8ea216:
	mov_s r0,0x0
L_8ea218:
	st.as r0,[gp,-0x26]
L_8ea21c:
	pop_s blink
L_8ea21e:
	j_s.d [blink]
L_8ea220:
	ld.ab r16,[sp,0x4]
