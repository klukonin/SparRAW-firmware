/* uc_tx__is_idle @ 0x936b2c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__background_step, bi__decide_beacon_kind, bi_tx_initiator_wrap, ucode_cmd_trigger_bf
 * Зовёт сам: __ld_r13_ret_uc, qset1_mask__any_pending
 * Глобалы (через gp): 0x80058c, 0x8005d6
 */
	.section .text.uc_tx__is_idle,"ax",@progbits
	.global uc_tx__is_idle
uc_tx__is_idle:
	.global L_936b2c
L_936b2c:
	push_s blink
L_936b2e:
	push_s r13
L_936b30:
	ldw_s r0,[gp,0xae]
L_936b32:
	brne_s r0,0,L_936b38
	.global L_936b34
L_936b34:
	mov_s r0,0x0
L_936b36:
	b_s L_936b46
	.global L_936b38
L_936b38:
	ld_s r0,[gp,0x64]
L_936b3a:
	brne_s r0,0,L_936b34
L_936b3c:
	mov_s r13,0x1
L_936b3e:
	bl.d L_936b4c
L_936b42:
	mov_s r0,r13
L_936b44:
	mov_s r0,r13
	.global L_936b46
L_936b46:
	b L_92028c
L_936b4a:
	nop_s
