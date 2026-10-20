/* vring__reg_write_locked_28 @ 0x8d0538, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pring__isr_dispatch, rm_main_sm__enter_primary_non_locked, sm_pring__bind_vring, sm_pring__state_step, vring__stop_hw, vring_schd__move_to_ready
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__reg_write_locked_28
vring__reg_write_locked_28:
	.global L_8d0538
L_8d0538:
	push_s blink
L_8d053a:
	push_s r13
L_8d053c:
	lr r13,[0xa]
L_8d0540:
	bclr r2,r13,0x1
L_8d0544:
	flag r2
L_8d0548:
	mov_s r2,0x881c00
L_8d054e:
	st_s r0,[r2,0x28]
L_8d0550:
	breq_s r1,0,L_8d0556
L_8d0552:
	sync
	.global L_8d0556
L_8d0556:
	lr r0,[0xa]
L_8d055a:
	bic r13,r13,-0x3
L_8d055e:
	or_s r13,r13,r0
L_8d0560:
	flag r13
L_8d0564:
	b L_8c025c
