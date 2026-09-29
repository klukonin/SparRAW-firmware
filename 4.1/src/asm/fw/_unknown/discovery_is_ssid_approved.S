/* discovery_is_ssid_approved @ 0x8eb76c, 184 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, discovery__ssid_matches, fw_log__emit0, mid__copy_ssid
 */
	.section .text.discovery_is_ssid_approved,"ax",@progbits
	.global discovery_is_ssid_approved
discovery_is_ssid_approved:
	.global L_8eb76c
L_8eb76c:
	push_s blink
L_8eb76e:
	bl L_8c02b4
L_8eb772:
	sub_s sp,sp,0x20
L_8eb774:
	mov_s r14,r0
L_8eb776:
	mov_s r13,r1
L_8eb778:
	mov_s r2,0x1012034
L_8eb77e:
	mov_s r0,0xc
L_8eb780:
	bl.d L_8edfb0
L_8eb784:
	mov_s r1,0x2
L_8eb786:
	ld_s r0,[r14,0x4]
L_8eb788:
	mov_s r1,sp
L_8eb78a:
	add_s r0,r0,0x48
L_8eb78c:
	bl.d L_8ca928
L_8eb790:
	mov_s r16,r1
L_8eb792:
	extb r17,r0
L_8eb796:
	ld_s r0,[r13,0xc]
L_8eb798:
	mov r18,0x1
L_8eb79c:
	ldb_s r13,[r0,0x9]
L_8eb79e:
	ld_s r15,[r0,0xc]
L_8eb7a0:
	cmp_s r13,0x0
L_8eb7a2:
	ld_s r0,[r14,0x4]
L_8eb7a4:
	sub.ne r18,r18,r18
L_8eb7a8:
	ldb r0,[r0, 0x9c]
L_8eb7ac:
	breq_s r0,0,L_8eb7c6
L_8eb7ae:
	brne r13,0x7,L_8eb7c6
L_8eb7b2:
	mov_s r1,0x1012054
L_8eb7b8:
	mov_s r0,r15
L_8eb7ba:
	bl.d L_8e3220
L_8eb7be:
	mov_s r2,0x7
L_8eb7c0:
	cmp_s r0,0x0
L_8eb7c2:
	mov.ne r18,0x1
	.global L_8eb7c6
L_8eb7c6:
	ld_s r0,[r14,0x4]
L_8eb7c8:
	ld r0,[r0, 0xa0]
L_8eb7cc:
	brne_s r0,0,L_8eb7e4
L_8eb7ce:
	breq r18,0x0,L_8eb7e4
L_8eb7d2:
	mov_s r2,0x101205c
L_8eb7d8:
	mov_s r0,0xc
L_8eb7da:
	bl.d L_8edfb0
L_8eb7de:
	mov_s r1,0x2
L_8eb7e0:
	mov_s r13,0x1
L_8eb7e2:
	b_s L_8eb81c
	.global L_8eb7e4
L_8eb7e4:
	brne r13,r17,L_8eb80c
L_8eb7e8:
	mov_s r0,r15
L_8eb7ea:
	mov_s r1,r16
L_8eb7ec:
	bl.d L_8e3220
L_8eb7f0:
	mov_s r2,r13
L_8eb7f2:
	breq_s r0,0,L_8eb802
L_8eb7f4:
	mov_s r2,0x10120a0
L_8eb7fa:
	mov_s r0,0xc
L_8eb7fc:
	mov_s r1,0x2
L_8eb7fe:
	mov_s r13,0x0
L_8eb800:
	b_s L_8eb818
	.global L_8eb802
L_8eb802:
	mov_s r2,0x10120ec
L_8eb808:
	mov_s r13,0x1
L_8eb80a:
	b_s L_8eb814
	.global L_8eb80c
L_8eb80c:
	mov_s r13,0x0
L_8eb80e:
	mov_s r2,0x1012138
	.global L_8eb814
L_8eb814:
	mov_s r0,0xc
L_8eb816:
	mov_s r1,0x2
	.global L_8eb818
L_8eb818:
	bl L_8edfb0
	.global L_8eb81c
L_8eb81c:
	mov_s r0,r13
L_8eb81e:
	b.d L_8c0314
L_8eb822:
	add_s sp,sp,0x20
