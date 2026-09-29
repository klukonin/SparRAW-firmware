/* radio_vtbl__call_tune @ 0x8e0274, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channels_switch__tune_current, channels_switch_sm__action_pop_ch_and_tune
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.radio_vtbl__call_tune,"ax",@progbits
	.global radio_vtbl__call_tune
radio_vtbl__call_tune:
	.global L_8e0274
L_8e0274:
	push_s blink
L_8e0276:
	push_s r13
L_8e0278:
	mov_s r11,r0
L_8e027a:
	mov_s r10,r1
L_8e027c:
	mov_s r9,r2
L_8e027e:
	mov_s r8,r3
L_8e0280:
	ld_s r0,[gp,-0x30]
L_8e0282:
	mov r6,r5
L_8e0286:
	ld_s r1,[r0]
L_8e0288:
	mov r7,r4
L_8e028c:
	ld_s r13,[r1,0x14]
L_8e028e:
	mov_s r1,r11
L_8e0290:
	mov_s r2,r10
L_8e0292:
	mov_s r3,r9
L_8e0294:
	mov r4,r8
L_8e0298:
	jl_s.d [r13]
L_8e029a:
	mov r5,r7
L_8e029e:
	.byte 0xa1,0x00
