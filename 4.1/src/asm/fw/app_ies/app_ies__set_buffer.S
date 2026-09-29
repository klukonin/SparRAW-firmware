/* app_ies__set_buffer @ 0x8e1afc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   app_ies.cpp
 * Зовут его: find_main_sm__probe_req, find_main_sm__probe_req_in_search, mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, mid__apply_app_ies, set_app_ie
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.app_ies__set_buffer,"ax",@progbits
	.global app_ies__set_buffer
app_ies__set_buffer:
	.global L_8e1afc
L_8e1afc:
	push_s blink
L_8e1afe:
	bl L_8c02bc
L_8e1b02:
	mov_s r13,r0
L_8e1b04:
	mov.f r15,r2
L_8e1b08:
	mov_s r14,r1
L_8e1b0a:
	mov_s r16,r3
L_8e1b0c:
	beq_s L_8e1b10
L_8e1b0e:
	breq_s r14,0,L_8e1b1e
	.global L_8e1b10
L_8e1b10:
	ld_s r0,[r13]
L_8e1b12:
	st_s r14,[r13]
L_8e1b14:
	stw_s r15,[r13,0x4]
L_8e1b16:
	b.d L_8c0324
L_8e1b1a:
	st r16,[r13, 0x8]
	.global L_8e1b1e
L_8e1b1e:
	mov_s r0,blink
L_8e1b20:
	mov_s r2,0x100ee8c
L_8e1b26:
	mov_s r1,0x121b
L_8e1b2c:
	bl.d L_8c82c0
L_8e1b30:
	mov_s r3,0x14
L_8e1b32:
	b_s L_8e1b10
