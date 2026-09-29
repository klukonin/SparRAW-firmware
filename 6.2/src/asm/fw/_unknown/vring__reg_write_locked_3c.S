/* vring__reg_write_locked_3c @ 0x8d0568, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__enter_primary_non_locked, sm_pring__bind_vring, sm_pring__state_step, vring__reset_pair_b, vring_schd__flush_response, vring_schd__move_to_ready
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__reg_write_locked_3c
vring__reg_write_locked_3c:
	.global L_8d0568
L_8d0568:
	push_s blink
L_8d056a:
	push_s r13
L_8d056c:
	lr r13,[0xa]
L_8d0570:
	bclr r2,r13,0x1
L_8d0574:
	flag r2
L_8d0578:
	mov_s r2,0x881c00
L_8d057e:
	st_s r0,[r2,0x3c]
L_8d0580:
	breq_s r1,0,L_8d0586
L_8d0582:
	sync
	.global L_8d0586
L_8d0586:
	lr r0,[0xa]
L_8d058a:
	bic r13,r13,-0x3
L_8d058e:
	or_s r13,r13,r0
L_8d0590:
	flag r13
L_8d0594:
	b L_8c025c
