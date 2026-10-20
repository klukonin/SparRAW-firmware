/* lmac_if_trigger_bf @ 0x8dc228, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_trigger_bf cid:%u bf_cmd_type:%u
 * Зовут его: lm_main_sm__linkup_failed, lm_sm__action_8daed8, lm_sm__action_8daf2c, maintain_sm__action_8c48f8, mlme_sm_802458__action_8c5cfc, wmi_trigger_beamforming_cmdid
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_trigger_bf
lmac_if_trigger_bf:
	.global L_8dc228
L_8dc228:
	push_s blink
L_8dc22a:
	bl L_8c01e4
L_8dc22e:
	mov_s r14,r0
L_8dc230:
	mov_s r13,r1
L_8dc232:
	mov_s r1,0x100498c
L_8dc238:
	mov_s r0,0x20
L_8dc23a:
	mov_s r2,r14
L_8dc23c:
	bl.d L_8dcc80
L_8dc240:
	mov_s r3,r13
L_8dc242:
	bl L_8c3284
L_8dc246:
	mov_s r1,0x1
L_8dc248:
	st_s r1,[r0]
L_8dc24a:
	st_s r13,[r0,0x4]
L_8dc24c:
	st_s r14,[r0,0x8]
L_8dc24e:
	mov_s r1,0x9
L_8dc250:
	mov_s r2,0xc
L_8dc252:
	bl.d L_8e5204
L_8dc256:
	mov_s r3,0x0
L_8dc258:
	b L_8c0254
