/* lm_main_sm__on_linkup_req__lm_state_configured @ 0x8d7dd0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: lm_if__get_cid, lmac_if_trigger_bf
 */
	.section .text.lm_main_sm__on_linkup_req__lm_state_configured,"ax",@progbits
	.global lm_main_sm__on_linkup_req__lm_state_configured
lm_main_sm__on_linkup_req__lm_state_configured:
L_8d7dd0:
	push_s blink
L_8d7dd2:
	bl.d L_8c9d8c
L_8d7dd6:
	ld_s r0,[r0,0x2c]
L_8d7dd8:
	extb_s r0,r0
L_8d7dda:
	bl.d L_8d8cb0
L_8d7dde:
	mov_s r1,0x0
L_8d7de0:
	pop_s blink
L_8d7de2:
	j_s [blink]
