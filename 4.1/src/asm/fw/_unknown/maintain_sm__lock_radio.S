/* maintain_sm__lock_radio @ 0x8de58c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__FBF_DELAYED, maintain_sm__on_start_maintain, rs__need_long_term
 * Зовёт сам: RADIO_MGR__lock_primary, __ld_r13_ret, lm__get_mid_id
 */
	.section .text.maintain_sm__lock_radio,"ax",@progbits
	.global maintain_sm__lock_radio
maintain_sm__lock_radio:
	.global L_8de58c
L_8de58c:
	push_s blink
L_8de58e:
	push_s r13
L_8de590:
	mov_s r13,r0
L_8de592:
	ld_s r0,[r0,0x48]
L_8de594:
	brne_s r0,0,L_8de5b0
L_8de596:
	bl.d L_8ca1a8
L_8de59a:
	ld_s r0,[r13,0x2c]
L_8de59c:
	extb_s r2,r0
L_8de59e:
	mov_s r0,0x5018
L_8de5a4:
	bl.d L_8d9288
L_8de5a8:
	mov_s r1,r13
L_8de5aa:
	st_s r0,[r13,0x48]
L_8de5ac:
	mov_s r0,0x0
L_8de5ae:
	st_s r0,[r13,0x4c]
	.global L_8de5b0
L_8de5b0:
	b L_8c033c
