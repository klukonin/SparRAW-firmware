/* ie__push_wfa_vendor @ 0x8ef740, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, mgmt_tx__probe_resp_ies
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_fw
 */
	.section .text.ie__push_wfa_vendor,"ax",@progbits
	.global ie__push_wfa_vendor
ie__push_wfa_vendor:
	.global L_8ef740
L_8ef740:
	push_s blink
L_8ef742:
	bl L_8c02c4
L_8ef746:
	mov_s r13,r0
L_8ef748:
	mov_s r14,r2
L_8ef74a:
	mov_s r0,0xdd
L_8ef74c:
	stb_s r0,[r13]
L_8ef74e:
	mov_s r0,0xf
L_8ef750:
	stb_s r0,[r13,0x1]
L_8ef752:
	mov_s r0,0x50
L_8ef754:
	stb_s r0,[r13,0x2]
L_8ef756:
	mov_s r0,0x6f
L_8ef758:
	stb_s r0,[r13,0x3]
L_8ef75a:
	mov_s r0,0x9a
L_8ef75c:
	stb_s r0,[r13,0x4]
L_8ef75e:
	mov_s r0,0x17
L_8ef760:
	stb_s r0,[r13,0x5]
L_8ef762:
	mov_s r0,0x1
L_8ef764:
	stb_s r0,[r13,0x6]
L_8ef766:
	mov_s r0,0x9
L_8ef768:
	stb_s r0,[r13,0x7]
L_8ef76a:
	mov_s r0,0x0
L_8ef76c:
	stb_s r0,[r13,0x8]
L_8ef76e:
	mov_s r0,0x7
L_8ef770:
	stb_s r0,[r13,0x9]
L_8ef772:
	add r0,r13,0xa
L_8ef776:
	bl.d L_8c0460
L_8ef77a:
	mov_s r2,0x6
L_8ef77c:
	stb_s r14,[r13,0x10]
L_8ef77e:
	b.d L_8c0334
L_8ef782:
	mov_s r0,0x11
