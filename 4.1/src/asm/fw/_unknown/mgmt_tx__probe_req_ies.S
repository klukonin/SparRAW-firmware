/* mgmt_tx__probe_req_ies @ 0x8eca28, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_probe_req
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ie__push_dmg_capabilities, ie__push_raw, ie__push_ssid, memcpy_fw, mid__copy_ssid
 */
	.section .text.mgmt_tx__probe_req_ies,"ax",@progbits
	.global mgmt_tx__probe_req_ies
mgmt_tx__probe_req_ies:
	.global L_8eca28
L_8eca28:
	push_s blink
L_8eca2a:
	bl.d L_8c02c0
L_8eca2e:
	mov_s r2,0x20
L_8eca30:
	sub_s sp,sp,0x20
L_8eca32:
	mov_s r15,r0
L_8eca34:
	mov_s r13,r1
L_8eca36:
	mov_s r14,sp
L_8eca38:
	mov_s r1,0x801e98
L_8eca3e:
	bl.d L_8c0460
L_8eca42:
	mov_s r0,r14
L_8eca44:
	mov_s r0,r13
L_8eca46:
	bl.d L_8ca928
L_8eca4a:
	mov_s r1,r14
L_8eca4c:
	extb_s r2,r0
L_8eca4e:
	mov_s r0,r15
L_8eca50:
	bl.d L_8ef8dc
L_8eca54:
	mov_s r1,r14
L_8eca56:
	extw_s r14,r0
L_8eca58:
	add_s r15,r15,r14
L_8eca5a:
	add3 r1,r13,0x30
L_8eca5e:
	bl.d L_8ef898
L_8eca62:
	mov_s r0,r15
L_8eca64:
	extw_s r0,r0
L_8eca66:
	add_s r14,r14,r0
L_8eca68:
	extw_s r14,r14
L_8eca6a:
	add_s r0,r0,r15
L_8eca6c:
	add1 r1,r13,0x2f
L_8eca70:
	bl.d L_8ef87c
L_8eca74:
	mov_s r2,0x0
L_8eca76:
	extw_s r0,r0
L_8eca78:
	add_s r0,r0,r14
L_8eca7a:
	extw_s r0,r0
L_8eca7c:
	b.d L_8c032c
L_8eca80:
	add_s sp,sp,0x20
L_8eca82:
	nop_s
