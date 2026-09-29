/* app_ies__set_buffer @ 0x8e693c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__probe_req_in_search, mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_assoc_resp_8f9e88, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, mid__apply_app_ies, set_app_ie, state_sm_8030f4__action_8f76d8
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global app_ies__set_buffer
app_ies__set_buffer:
	.global L_8e693c
L_8e693c:
	push_s blink
L_8e693e:
	bl L_8c01dc
L_8e6942:
	mov_s r13,r0
L_8e6944:
	mov.f r15,r2
L_8e6948:
	mov_s r14,r1
L_8e694a:
	mov_s r16,r3
L_8e694c:
	beq_s L_8e6950
L_8e694e:
	breq_s r14,0,L_8e695e
	.global L_8e6950
L_8e6950:
	ld_s r0,[r13]
L_8e6952:
	st_s r14,[r13]
L_8e6954:
	stw_s r15,[r13,0x4]
L_8e6956:
	b.d L_8c0244
L_8e695a:
	st r16,[r13, 0x8]
	.global L_8e695e
L_8e695e:
	mov_s r0,blink
L_8e6960:
	mov_s r1,0x121b
L_8e6966:
	bl L_8c9b28
L_8e696a:
	b_s L_8e6950
