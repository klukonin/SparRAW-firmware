/* push_cap_info @ 0x8ef784, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   push_cap_info: >>>>>> with BSS TYPE = 0x%x and PRIVACY = 0x%x <<<<<
 * Зовут его: frame_builder__assoc_resp_fix_fields, mgmt_tx__assoc_req_fixed_fields, mgmt_tx__probe_resp_tsf_bi_ie
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, memcpy_fw
 */
	.section .text.push_cap_info,"ax",@progbits
	.global push_cap_info
push_cap_info:
	.global L_8ef784
L_8ef784:
	push_s blink
L_8ef786:
	bl L_8c02c0
L_8ef78a:
	mov_s r15,r0
L_8ef78c:
	mov_s r14,r1
L_8ef78e:
	ldb_s r3,[r1]
L_8ef790:
	mov_s r2,0x100bb7c
L_8ef796:
	lsr r13,r3,0x4
L_8ef79a:
	mov_s r0,0xd
L_8ef79c:
	mov_s r1,0x2
L_8ef79e:
	bmsk_s r3,r3,0x1
L_8ef7a0:
	bl.d L_8edff8
L_8ef7a4:
	bmsk r4,r13,0x0
L_8ef7a8:
	mov_s r0,r15
L_8ef7aa:
	mov_s r1,r14
L_8ef7ac:
	bl.d L_8c0460
L_8ef7b0:
	mov_s r2,0x2
L_8ef7b2:
	b.d L_8c032c
L_8ef7b6:
	mov_s r0,0x2
