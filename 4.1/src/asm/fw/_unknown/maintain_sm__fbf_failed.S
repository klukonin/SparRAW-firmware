/* maintain_sm__fbf_failed @ 0x8eb890, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   maintain_sm::fbf_failed() - unlocking radio 0x%x
 * Зовёт сам: RADIO_MGR__unlock, __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit1, maintain_sm__reset_link_cfg, u_schd__cancel
 */
	.section .text.maintain_sm__fbf_failed,"ax",@progbits
	.global maintain_sm__fbf_failed
maintain_sm__fbf_failed:
	.byte 0x4f
	.byte 0xea
	.global fwlog_maintain_sm_fbf_failed_unlocking_radio_0
fwlog_maintain_sm_fbf_failed_unlocking_radio_0:
L_8eb892:
	nop_s
L_8eb894:
	push_s blink
L_8eb896:
	bl L_8c02c4
L_8eb89a:
	mov_s r13,r0
L_8eb89c:
	ld_s r0,[r0,0x40]
L_8eb89e:
	mov_s r14,0x0
L_8eb8a0:
	breq_s r0,0,L_8eb8a8
L_8eb8a2:
	bl L_8c7794
L_8eb8a6:
	st_s r14,[r13,0x40]
	.global L_8eb8a8
L_8eb8a8:
	bl.d L_8eaf88
L_8eb8ac:
	mov_s r0,r13
L_8eb8ae:
	ld_s r3,[r13,0x48]
L_8eb8b0:
	breq_s r3,0,L_8eb8c8
L_8eb8b2:
	mov_s r2,0x1011f7c
L_8eb8b8:
	mov_s r0,0xc
L_8eb8ba:
	bl.d L_8edfcc
L_8eb8be:
	mov_s r1,0x2
L_8eb8c0:
	bl.d L_8e54d8
L_8eb8c4:
	ld_s r0,[r13,0x48]
L_8eb8c6:
	st_s r14,[r13,0x48]
	.global L_8eb8c8
L_8eb8c8:
	ld_s r0,[r13,0x2c]
L_8eb8ca:
	mov_s r1,0x6
L_8eb8cc:
	mov_s r2,0x0
L_8eb8ce:
	mov_s r3,r2
L_8eb8d0:
	bl.d L_8d6a1c
L_8eb8d4:
	mov_s r4,r2
L_8eb8d6:
	.byte 0x61,0x02
