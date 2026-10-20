/* ftm_main_sm__radio_args @ 0x8e4e18, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channels_switch_sm__action_pop_ch_and_tune, ftm_main_sm__action_pop_ch_and_tune, ftm_main_sm__radio_allocated_cb
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm_main_sm__radio_args
ftm_main_sm__radio_args:
	.global L_8e4e18
L_8e4e18:
	push_s blink
L_8e4e1a:
	push_s r13
L_8e4e1c:
	mov_s r11,r0
L_8e4e1e:
	mov_s r10,r1
L_8e4e20:
	mov_s r9,r2
L_8e4e22:
	mov_s r8,r3
L_8e4e24:
	ld_s r0,[gp,-0x40]
L_8e4e26:
	mov r6,r5
L_8e4e2a:
	ld_s r1,[r0]
L_8e4e2c:
	mov r7,r4
L_8e4e30:
	ld_s r13,[r1,0x14]
L_8e4e32:
	mov_s r1,r11
L_8e4e34:
	mov_s r2,r10
L_8e4e36:
	mov_s r3,r9
L_8e4e38:
	mov r4,r8
L_8e4e3c:
	jl_s.d [r13]
L_8e4e3e:
	mov r5,r7
L_8e4e42:
	b L_8c025c
L_8e4e46:
	nop_s
