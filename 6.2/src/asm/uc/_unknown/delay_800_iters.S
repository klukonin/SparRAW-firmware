/* delay_800_iters @ 0x938a64, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_sta_sm
 * Зовёт сам: fixed_sched__run_tx_slot, mac__set_sector_arg_and_select_all
 * Глобалы (через gp): 0x8005c0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global delay_800_iters
delay_800_iters:
	.global L_938a64
L_938a64:
	push_s blink
L_938a66:
	mov r0,0x320
L_938a6a:
	mov lp_count,r0
L_938a6e:
	nop_s
L_938a70:
	lp L_938a78
L_938a74:
	nop_s
L_938a76:
	nop_s
	.global L_938a78
L_938a78:
	bl.d L_9351ec
L_938a7c:
	ldw_s r0,[gp,0x98]
L_938a7e:
	bl L_93768c
L_938a82:
	mov_s r0,0x0
L_938a84:
	pop_s blink
L_938a86:
	j_s [blink]
