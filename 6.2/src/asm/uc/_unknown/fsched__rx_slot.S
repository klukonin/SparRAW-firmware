/* fsched__rx_slot @ 0x92843c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap_sm
 * Зовёт сам: __ld_r13_to_r13_ret, fsched__arm_slot_timer, rx_flow__run_and_check_bf_abort
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__rx_slot
fsched__rx_slot:
	.global L_92843c
L_92843c:
	push_s blink
L_92843e:
	push_s r13
L_928440:
	mov_s r0,0x1
L_928442:
	mov_s r13,0x80064c
L_928448:
	bl.d L_926310
L_92844c:
	stb_s r0,[r13,0x4]
L_92844e:
	mov_s r0,0x0
L_928450:
	stb_s r0,[r13,0x4]
L_928452:
	bl.d L_925014
L_928456:
	mov_s r0,0xf
L_928458:
	b L_9202ac
