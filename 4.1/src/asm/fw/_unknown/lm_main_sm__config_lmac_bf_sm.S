/* lm_main_sm__config_lmac_bf_sm @ 0x8c625c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_main_sm::config_lmac_bf_sm CID=%d
 * Зовут его: lm_main_sm__on_linkup_req__lm_state_idle, lm_main_sm__on_maintain_started, lm_main_sm__set_bf_cfg
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, lm_if__get_cid, lmac_mbox__alloc_slot, memcpy_fw, send_cmd2_lmac
 */
	.section .text.lm_main_sm__config_lmac_bf_sm,"ax",@progbits
	.global lm_main_sm__config_lmac_bf_sm
lm_main_sm__config_lmac_bf_sm:
	.global L_8c625c
L_8c625c:
	push_s blink
L_8c625e:
	bl L_8c02c0
L_8c6262:
	mov_s r14,r0
L_8c6264:
	bl.d L_8c2b0c
L_8c6268:
	mov_s r15,r1
L_8c626a:
	mov_s r13,r0
L_8c626c:
	mov_s r1,0x80130c
L_8c6272:
	bl.d L_8c0460
L_8c6276:
	mov_s r2,0x30
L_8c6278:
	st_s r15,[r13,0x24]
L_8c627a:
	bl.d L_8c9d8c
L_8c627e:
	ld_s r0,[r14,0x2c]
L_8c6280:
	mov_s r2,0x1011aa0
L_8c6286:
	mov_s r3,r0
L_8c6288:
	st_s r0,[r13,0x28]
L_8c628a:
	mov_s r0,0x0
L_8c628c:
	bl.d L_8edfcc
L_8c6290:
	mov_s r1,0x2
L_8c6292:
	mov_s r0,r13
L_8c6294:
	mov_s r1,0x10
L_8c6296:
	mov_s r2,0x30
L_8c6298:
	bl.d L_8e0694
L_8c629c:
	mov_s r3,0x0
L_8c629e:
	b L_8c032c
L_8c62a2:
	nop_s
