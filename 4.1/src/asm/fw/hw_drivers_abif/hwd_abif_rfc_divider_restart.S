/* hwd_abif_rfc_divider_restart @ 0x8cbce8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_abif_rfc_divider_restart: g_hwd_abif_rfc_divider_restart=%d
 * Зовут его: hwd_rfc_read_rgf, marlon_r_if_class__rf_write_with_block_retries
 * Зовёт сам: fw_log__emit1, hwd_abif__rgf_889380_8cbcd0, hwd_abif__rgf_889400
 * Глобалы (через gp): 0x800360
 */
	.section .text.hwd_abif_rfc_divider_restart,"ax",@progbits
	.global hwd_abif_rfc_divider_restart
hwd_abif_rfc_divider_restart:
	.global L_8cbce8
L_8cbce8:
	push_s blink
L_8cbcea:
	breq_s r0,0,L_8cbd02
L_8cbcec:
	ld_s r0,[gp,0x1f0]
L_8cbcee:
	mov_s r2,0x1019acc
L_8cbcf4:
	add_s r3,r0,0x1
L_8cbcf6:
	st.as r3,[gp,0x7c]
L_8cbcfa:
	mov_s r0,0x0
L_8cbcfc:
	bl.d L_8edfcc
L_8cbd00:
	mov_s r1,0x1
	.global L_8cbd02
L_8cbd02:
	bl.d L_8cbcd0
L_8cbd06:
	mov_s r0,0x1
L_8cbd08:
	bl.d L_8cbcb8
L_8cbd0c:
	mov_s r0,0x0
L_8cbd0e:
	bl.d L_8cbcb8
L_8cbd12:
	mov_s r0,0x1
L_8cbd14:
	mov_s r0,0x50
L_8cbd16:
	mov lp_count,r0
L_8cbd1a:
	nop_s
L_8cbd1c:
	lp L_8cbd24
L_8cbd20:
	nop_s
L_8cbd22:
	nop_s
	.global L_8cbd24
L_8cbd24:
	bl.d L_8cbcd0
L_8cbd28:
	mov_s r0,0x0
L_8cbd2a:
	pop_s blink
L_8cbd2c:
	j_s [blink]
L_8cbd2e:
	nop_s
