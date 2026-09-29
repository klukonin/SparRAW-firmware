/* uc_pm__enter_idle @ 0x936ca8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_bi_step, l1_bi_trigger_step, rx_funcs__set_rx_off
 * Зовёт сам: __ld_r13_ret_uc, mac_mode__enter_idle_seq, uc_read_tsf64
 * Глобалы (через gp): 0x80058c
 */
	.section .text.uc_pm__enter_idle,"ax",@progbits
	.global uc_pm__enter_idle
uc_pm__enter_idle:
	.global L_936ca8
L_936ca8:
	push_s blink
L_936caa:
	push_s r13
L_936cac:
	mov_s r13,r0
L_936cae:
	mov_s r0,0x8009cc
L_936cb4:
	bl L_930cb0
L_936cb8:
	mov_s r0,0x0
L_936cba:
	st.as r0,[gp,0x19]
L_936cbe:
	bl.d L_932644
L_936cc2:
	mov_s r0,r13
L_936cc4:
	mov_s r0,0x20c0010
L_936cca:
	mov_s r32,r0
L_936ccc:
	st.ab r0,[r25,0x4]
L_936cd0:
	bclr r25,r25,0xa
L_936cd4:
	mov_s r1,0x8009ec
L_936cda:
	ld_s r0,[r1]
L_936cdc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_936cde:
	st_s r0,[r1]
L_936ce0:
	mov_s r1,0x854880
L_936ce6:
	b.d L_92028c
L_936cea:
	st_s r0,[r1,0x7c]
