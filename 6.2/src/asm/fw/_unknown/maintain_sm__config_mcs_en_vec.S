/* maintain_sm__config_mcs_en_vec @ 0x8c7000, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   maintain_sm::config_mcs_en_vec mcs_is_restricted=%d
 * Зовут его: maintain_sm__action_8cab64, maintain_sm__reset_rate_params
 * Зовёт сам: fw_log_emit1, mcs__is_restricted
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__config_mcs_en_vec
maintain_sm__config_mcs_en_vec:
	.global L_8c7000
L_8c7000:
	push_s blink
L_8c7002:
	bl L_8da568
L_8c7006:
	mov.f r2,r0
L_8c700a:
	mov r0,0x1de
L_8c700e:
	mov.eq r0,0x1dde
L_8c7016:
	mov_s r3,0x80147c
L_8c701c:
	stw_s r0,[r3,0x22]
L_8c701e:
	lsr_s r0,r0,0x10
L_8c7020:
	stw_s r0,[r3,0x24]
L_8c7022:
	mov_s r0,0x803c00
L_8c7028:
	ld_s r0,[r0,0x10]
L_8c702a:
	breq_s r0,0,L_8c7034
L_8c702c:
	mov_s r1,0x10
L_8c702e:
	stw_s r1,[r3,0x22]
L_8c7030:
	lsr_s r1,r1,0x10
L_8c7032:
	stw_s r1,[r3,0x24]
	.global L_8c7034
L_8c7034:
	mov_s r1,0x1014634
L_8c703a:
	bl.d L_8dcc10
L_8c703e:
	mov_s r0,0x20
L_8c7040:
	pop_s blink
L_8c7042:
	j_s [blink]
