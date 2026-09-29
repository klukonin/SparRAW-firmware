/* bf_sm__state_failure_path @ 0x922718, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bf_sm__check_sta_timeout, bf_sm__process_request_fifo, mid_vring_mask_update
 * Глобалы (через gp): 0x8005d0, 0x8005ec
 */
	.section .text.bf_sm__state_failure_path,"ax",@progbits
	.global bf_sm__state_failure_path
bf_sm__state_failure_path:
L_922718:
	/* b_s 0x00922824 */
	.byte 0x86,0xf0
	.global sub_92271a
sub_92271a:
L_92271a:
	mov_s r0,r14
L_92271c:
	bl.d L_922500
L_922720:
	mov_s r1,0x0
L_922722:
	/* b_s 0x00922824 */
	.byte 0x82,0xf0
L_922724:
	mov_s r0,0x1
	.global L_922726
L_922726:
	mov_s r16,r0
L_922728:
	mov_s r17,r0
L_92272a:
	ld_s r0,[r13]
L_92272c:
	/* brne r0,0x11,0x009227c4 */
	.byte 0x99,0x08,0x51,0x04
L_922730:
	ld_s r0,[gp,0xc4]
L_922732:
	cmp_s r0,0x1
L_922734:
	mov.eq r0,0x3
L_922738:
	bl.eq.d L_928cb4
L_92273c:
	mov.eq r1,r14
L_922740:
	mov_s r2,0x0
L_922742:
	ldw_s r0,[gp,0xa8]
L_922744:
	bset r2,r2,r14
