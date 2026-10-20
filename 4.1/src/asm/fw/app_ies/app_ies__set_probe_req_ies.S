/* app_ies__set_probe_req_ies @ 0x8e1abc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   app_ies.cpp
 * Зовут его: find_main_sm__probe_req, find_main_sm__probe_req_in_search
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, app_ies__bind_buffer, fw_sysassert_fatal
 */
	.section .text.app_ies__set_probe_req_ies,"ax",@progbits
	.global app_ies__set_probe_req_ies
app_ies__set_probe_req_ies:
	.global L_8e1abc
L_8e1abc:
	push_s blink
L_8e1abe:
	bl L_8c02c0
L_8e1ac2:
	mov.f r15,r2
L_8e1ac6:
	mov_s r14,r0
L_8e1ac8:
	mov_s r13,r1
L_8e1aca:
	beq_s L_8e1ace
L_8e1acc:
	breq_s r13,0,L_8e1ae2
	.global L_8e1ace
L_8e1ace:
	ld_s r2,[r14,0xc]
L_8e1ad0:
	st_s r13,[r14,0xc]
L_8e1ad2:
	stw_s r15,[r14,0x10]
L_8e1ad4:
	mov_s r0,r14
L_8e1ad6:
	bl.d L_8e1438
L_8e1ada:
	mov_s r1,r14
L_8e1adc:
	b.d L_8c032c
L_8e1ae0:
	mov_s r0,r2
	.global L_8e1ae2
L_8e1ae2:
	mov_s r0,blink
L_8e1ae4:
	mov_s r2,0x100ee8c
L_8e1aea:
	mov_s r1,0x121c
L_8e1af0:
	bl.d L_8c82c0
L_8e1af4:
	mov r3,0x15e
L_8e1af8:
	b_s L_8e1ace
L_8e1afa:
	nop_s
