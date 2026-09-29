/* mid__update_aw_ie @ 0x8c30fc, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mid.cpp
 *   PCP AP Update AW IE - TBTT: %x. Current AW: %d, Next AW: %d
 * Зовут его: power_mngr__recalc_aw
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit3, fw_sysassert_fatal, mac__mul_886fc4_by_886d64, mid__get_awake_window, mid__set_awake_window, tx_bcon__update_bcon
 */
	.section .text.mid__update_aw_ie,"ax",@progbits
	.global mid__update_aw_ie
mid__update_aw_ie:
	.global L_8c30fc
L_8c30fc:
	push_s blink
L_8c30fe:
	bl L_8c02b8
L_8c3102:
	cmp r1,0x9d
L_8c3106:
	mov_s r13,r0
L_8c3108:
	mov_s r16,r2
L_8c310a:
	beq_s L_8c3124
L_8c310c:
	mov_s r0,blink
L_8c310e:
	mov_s r2,0x100aedc
L_8c3114:
	mov_s r1,0x1229
L_8c311a:
	bl.d L_8c82c0
L_8c311e:
	mov r3,0x382
L_8c3122:
	b_s L_8c315a
	.global L_8c3124
L_8c3124:
	bl.d L_8e47b4
L_8c3128:
	mov_s r0,0x0
L_8c312a:
	mov_s r17,r0
L_8c312c:
	bl.d L_8c989c
L_8c3130:
	mov_s r0,r13
L_8c3132:
	mov_s r4,r0
L_8c3134:
	mov_s r2,0x100afb8
L_8c313a:
	mov_s r0,0xb
L_8c313c:
	mov_s r1,0x2
L_8c313e:
	mov_s r3,r17
L_8c3140:
	bl.d L_8ee034
L_8c3144:
	mov r5,r16
L_8c3148:
	extw r1,r16
L_8c314c:
	mov_s r0,r13
L_8c314e:
	bl.d L_8e1590
L_8c3152:
	mov_s r2,r17
L_8c3154:
	bl.d L_8c2190
L_8c3158:
	ld_s r0,[r13]
	.global L_8c315a
L_8c315a:
	b L_8c031c
L_8c315e:
	nop_s
