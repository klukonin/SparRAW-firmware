/* rm_main_sm__inject_lock_evt @ 0x8caf98, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm.cpp
 * Зовут его: rm__inject_lock_evt_at28
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.rm_main_sm__inject_lock_evt,"ax",@progbits
	.global rm_main_sm__inject_lock_evt
rm_main_sm__inject_lock_evt:
L_8caf98:
	j_s [r2]
	.global sub_8caf9a
sub_8caf9a:
L_8caf9a:
	nop_s
	.global L_8caf9c
L_8caf9c:
	push_s blink
L_8caf9e:
	bl L_8c02c4
L_8cafa2:
	mov_s r14,r0
L_8cafa4:
	mov_s r13,0x7
L_8cafa6:
	breq_s r1,0,L_8cafce
L_8cafa8:
	breq r1,0x1,L_8cafd2
L_8cafac:
	breq r1,0x2,L_8cafd6
L_8cafb0:
	breq r1,0x3,L_8cafda
L_8cafb4:
	mov_s r0,blink
L_8cafb6:
	mov_s r2,0x1015d54
L_8cafbc:
	mov_s r1,0x1179
L_8cafc2:
	bl.d L_8c82c0
L_8cafc6:
	mov r3,0x27f
L_8cafca:
	mov_s r1,r13
L_8cafcc:
	b_s L_8cafdc
	.global L_8cafce
L_8cafce:
	mov_s r1,0x5
L_8cafd0:
	b_s L_8cafdc
	.global L_8cafd2
L_8cafd2:
	mov_s r1,0x3
L_8cafd4:
	b_s L_8cafdc
	.global L_8cafd6
L_8cafd6:
	mov_s r1,0x2
L_8cafd8:
	b_s L_8cafdc
	.global L_8cafda
L_8cafda:
	mov_s r1,0x1
	.global L_8cafdc
L_8cafdc:
	add r0,r14,0x34
L_8cafe0:
	mov_s r2,0x0
L_8cafe2:
	mov_s r3,r2
L_8cafe4:
	bl.d L_8d6a1c
L_8cafe8:
	mov_s r4,r2
L_8cafea:
	b L_8c0334
L_8cafee:
	nop_s
