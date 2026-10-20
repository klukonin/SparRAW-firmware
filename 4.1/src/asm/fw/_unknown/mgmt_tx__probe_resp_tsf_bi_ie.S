/* mgmt_tx__probe_resp_tsf_bi_ie @ 0x8eca84, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MGMT TX Probe resp TSF length %d total %d
 *   MGMT TX Probe resp BI length %d total %d
 *   MGMT TX Probe resp <<<<<<<<< PRIVACY %d >>>>>>>>>>>>> Capabilities length %d total %d
 * Зовут его: mgmt_tx__build_fixed_probe_resp, mgmt_tx__build_probe_resp
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, fw_log__emit3, memset0_words, push_cap_info
 */
	.section .text.mgmt_tx__probe_resp_tsf_bi_ie,"ax",@progbits
	.global mgmt_tx__probe_resp_tsf_bi_ie
mgmt_tx__probe_resp_tsf_bi_ie:
	.global L_8eca84
L_8eca84:
	push_s blink
L_8eca86:
	bl L_8c02c0
L_8eca8a:
	mov_s r13,r0
L_8eca8c:
	mov_s r14,r1
L_8eca8e:
	bl.d L_8c1a78
L_8eca92:
	mov_s r1,0x8
L_8eca94:
	mov_s r2,0x100bbc4
L_8eca9a:
	mov_s r0,0xd
L_8eca9c:
	mov_s r1,0x2
L_8eca9e:
	mov_s r3,0x8
L_8ecaa0:
	bl.d L_8edff8
L_8ecaa4:
	mov_s r4,r3
L_8ecaa6:
	ldw r0,[r14, 0x4e]
L_8ecaaa:
	mov_s r2,0x100bbf0
L_8ecab0:
	stw_s r0,[r13,0x8]
L_8ecab2:
	add_s r13,r13,0xa
L_8ecab4:
	mov_s r0,0xd
L_8ecab6:
	mov_s r1,0x2
L_8ecab8:
	mov_s r3,r1
L_8ecaba:
	bl.d L_8edff8
L_8ecabe:
	mov r4,0xa
L_8ecac2:
	add2 r1,r14,0x17
L_8ecac6:
	bl.d L_8ef784
L_8ecaca:
	mov_s r0,r13
L_8ecacc:
	mov_s r4,r0
L_8ecace:
	add r15,r0,0xa
L_8ecad2:
	ld_s r3,[r14]
L_8ecad4:
	mov_s r2,0x100bc1c
L_8ecada:
	ld_s r3,[r3,0x3c]
L_8ecadc:
	mov_s r0,0xd
L_8ecade:
	mov_s r1,0x2
L_8ecae0:
	bl.d L_8ee034
L_8ecae4:
	mov_s r5,r15
L_8ecae6:
	b.d L_8c032c
L_8ecaea:
	extw_s r0,r15
