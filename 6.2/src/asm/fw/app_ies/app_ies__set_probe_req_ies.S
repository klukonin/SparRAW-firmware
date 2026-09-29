/* app_ies__set_probe_req_ies @ 0x8e6908, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__probe_req_in_search, state_sm_8030f4__action_8f76d8
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, app_ies__bind_buffer, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global app_ies__set_probe_req_ies
app_ies__set_probe_req_ies:
	.global L_8e6908
L_8e6908:
	push_s blink
L_8e690a:
	bl L_8c01e0
L_8e690e:
	mov.f r15,r2
L_8e6912:
	mov_s r14,r0
L_8e6914:
	mov_s r13,r1
L_8e6916:
	beq_s L_8e691a
L_8e6918:
	breq_s r13,0,L_8e692e
	.global L_8e691a
L_8e691a:
	ld_s r2,[r14,0xc]
L_8e691c:
	st_s r13,[r14,0xc]
L_8e691e:
	stw_s r15,[r14,0x10]
L_8e6920:
	mov_s r0,r14
L_8e6922:
	bl.d L_8e6108
L_8e6926:
	mov_s r1,r14
L_8e6928:
	b.d L_8c024c
L_8e692c:
	mov_s r0,r2
	.global L_8e692e
L_8e692e:
	mov_s r0,blink
L_8e6930:
	mov_s r1,0x121c
L_8e6936:
	bl L_8c9b28
L_8e693a:
	b_s L_8e691a
