/* hw_sysapi_rx__alloc_and_store @ 0x8dbb04, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_sysapi_rx_omni_sector_set, lmac_if__lmac_ready_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_rx__alloc_and_store
hw_sysapi_rx__alloc_and_store:
	.global L_8dbb04
L_8dbb04:
	push_s blink
L_8dbb06:
	bl L_8c01e4
L_8dbb0a:
	mov_s r14,r0
L_8dbb0c:
	bl.d L_8c3284
L_8dbb10:
	mov_s r13,r1
L_8dbb12:
	stb_s r14,[r0]
L_8dbb14:
	stw_s r13,[r0,0x2]
L_8dbb16:
	mov_s r1,0x19
L_8dbb18:
	mov_s r2,0x4
L_8dbb1a:
	bl.d L_8e5204
L_8dbb1e:
	mov_s r3,0x0
L_8dbb20:
	b L_8c0254
