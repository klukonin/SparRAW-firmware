/* discovery_is_ssid_approved @ 0x8f2a90, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery_is_ssid_approved()
 *   DIRECT-
 *   discovery_is_ssid_approved() SSID analysis: ssid approved- wildcard
 *   discovery_is_ssid_approved() SSID analysis: ssid not approved- bad content
 *   discovery_is_ssid_approved() SSID analysis: ssid approved- expected content
 *   discovery_is_ssid_approved() SSID analysis: ssid not approved- bad length
 * Зовут его: discovery_handle_probe_req
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, discovery__ssid_matches, fw_log_emit0, mid__copy_ssid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery_is_ssid_approved
discovery_is_ssid_approved:
	.global L_8f2a90
L_8f2a90:
	push_s blink
L_8f2a92:
	bl L_8c01d4
L_8f2a96:
	sub_s sp,sp,0x20
L_8f2a98:
	mov_s r14,r0
L_8f2a9a:
	mov_s r13,r1
L_8f2a9c:
	mov_s r1,0x10167a0
L_8f2aa2:
	bl.d L_8dcba8
L_8f2aa6:
	mov_s r0,0x2c
L_8f2aa8:
	ld_s r0,[r14,0x4]
L_8f2aaa:
	mov_s r1,sp
L_8f2aac:
	add_s r0,r0,0x48
L_8f2aae:
	bl.d L_8ccc98
L_8f2ab2:
	mov_s r16,r1
L_8f2ab4:
	extb r17,r0
L_8f2ab8:
	ld_s r0,[r13,0xc]
L_8f2aba:
	mov r18,0x1
L_8f2abe:
	ldb_s r13,[r0,0x9]
L_8f2ac0:
	ld_s r15,[r0,0xc]
L_8f2ac2:
	cmp_s r13,0x0
L_8f2ac4:
	ld_s r0,[r14,0x4]
L_8f2ac6:
	sub.ne r18,r18,r18
L_8f2aca:
	ldb r0,[r0, 0x9c]
L_8f2ace:
	breq_s r0,0,L_8f2ae8
L_8f2ad0:
	brne r13,0x7,L_8f2ae8
L_8f2ad4:
	mov_s r1,0x10167c0
L_8f2ada:
	mov_s r0,r15
L_8f2adc:
	bl.d L_8e82e0
L_8f2ae0:
	mov_s r2,0x7
L_8f2ae2:
	cmp_s r0,0x0
L_8f2ae4:
	mov.ne r18,0x1
	.global L_8f2ae8
L_8f2ae8:
	ld_s r0,[r14,0x4]
L_8f2aea:
	ld r0,[r0, 0xa0]
L_8f2aee:
	brne_s r0,0,L_8f2b04
L_8f2af0:
	breq r18,0x0,L_8f2b04
L_8f2af4:
	mov_s r1,0x10167c8
L_8f2afa:
	bl.d L_8dcba8
L_8f2afe:
	mov_s r0,0x2c
L_8f2b00:
	mov_s r13,0x1
L_8f2b02:
	b_s L_8f2b38
	.global L_8f2b04
L_8f2b04:
	brne r13,r17,L_8f2b2a
L_8f2b08:
	mov_s r0,r15
L_8f2b0a:
	mov_s r1,r16
L_8f2b0c:
	bl.d L_8e82e0
L_8f2b10:
	mov_s r2,r13
L_8f2b12:
	breq_s r0,0,L_8f2b20
L_8f2b14:
	mov_s r1,0x101680c
L_8f2b1a:
	mov_s r0,0x2c
L_8f2b1c:
	mov_s r13,0x0
L_8f2b1e:
	b_s L_8f2b34
	.global L_8f2b20
L_8f2b20:
	mov_s r1,0x1016858
L_8f2b26:
	mov_s r13,0x1
L_8f2b28:
	b_s L_8f2b32
	.global L_8f2b2a
L_8f2b2a:
	mov_s r13,0x0
L_8f2b2c:
	mov_s r1,0x10168a4
	.global L_8f2b32
L_8f2b32:
	mov_s r0,0x2c
	.global L_8f2b34
L_8f2b34:
	bl L_8dcba8
	.global L_8f2b38
L_8f2b38:
	mov_s r0,r13
L_8f2b3a:
	b.d L_8c0234
L_8f2b3e:
	add_s sp,sp,0x20
