/* rm_main_sm__inject_lock_evt @ 0x8cd288, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bits__set_s8_w5, lmac_if__ucode_event_dispatch, rm_ch_switch_sm__fwtx_channel_stopped
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__inject_lock_evt
rm_main_sm__inject_lock_evt:
	.global L_8cd288
L_8cd288:
	mov_s r1,r0
L_8cd28a:
	ld_s r0,[gp,-0x40]
L_8cd28c:
	ld_s r2,[r0]
L_8cd28e:
	ld_s r2,[r2,0x28]
L_8cd290:
	j_s [r2]
L_8cd292:
	nop_s
	.global L_8cd294
L_8cd294:
	push_s blink
L_8cd296:
	bl L_8c01e4
L_8cd29a:
	mov_s r14,r0
L_8cd29c:
	mov_s r13,0x7
L_8cd29e:
	breq_s r1,0,L_8cd2bc
L_8cd2a0:
	breq r1,0x1,L_8cd2c0
L_8cd2a4:
	breq r1,0x2,L_8cd2c4
L_8cd2a8:
	breq r1,0x3,L_8cd2c8
L_8cd2ac:
	mov_s r0,blink
L_8cd2ae:
	mov_s r1,0x1179
L_8cd2b4:
	bl L_8c9b28
L_8cd2b8:
	mov_s r1,r13
L_8cd2ba:
	b_s L_8cd2ca
	.global L_8cd2bc
L_8cd2bc:
	mov_s r1,0x5
L_8cd2be:
	b_s L_8cd2ca
	.global L_8cd2c0
L_8cd2c0:
	mov_s r1,0x3
L_8cd2c2:
	b_s L_8cd2ca
	.global L_8cd2c4
L_8cd2c4:
	mov_s r1,0x2
L_8cd2c6:
	b_s L_8cd2ca
	.global L_8cd2c8
L_8cd2c8:
	mov_s r1,0x1
	.global L_8cd2ca
L_8cd2ca:
	add r0,r14,0x10
L_8cd2ce:
	mov_s r2,0x0
L_8cd2d0:
	mov_s r3,r2
L_8cd2d2:
	bl.d L_8d9b6c
L_8cd2d6:
	mov_s r4,r2
L_8cd2d8:
	b L_8c0254
