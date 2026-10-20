/* ie__push_qos_capability @ 0x8ef804, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Pushed QoS Capability IE [%x] length 3
 * Зовут его: mgmt_tx__append_probe_resp_ies, mgmt_tx__assoc_req_ies, mgmt_tx__assoc_resp_tlv
 * Зовёт сам: fw_log__emit1
 */
	.section .text.ie__push_qos_capability,"ax",@progbits
	.global ie__push_qos_capability
ie__push_qos_capability:
	.global L_8ef804
L_8ef804:
	push_s blink
L_8ef806:
	mov_s r1,0x2e
L_8ef808:
	stb_s r1,[r0]
L_8ef80a:
	mov_s r1,0x1
L_8ef80c:
	stb_s r1,[r0,0x1]
L_8ef80e:
	ldb.a r3,[r0,0x2]
L_8ef812:
	mov_s r2,0x100bc90
L_8ef818:
	bset_s r3,r3,0x3
L_8ef81a:
	stb_s r3,[r0]
L_8ef81c:
	mov_s r0,0xd
L_8ef81e:
	bl.d L_8edfcc
L_8ef822:
	mov_s r1,0x2
L_8ef824:
	mov_s r0,0x3
L_8ef826:
	pop_s blink
L_8ef828:
	j_s [blink]
L_8ef82a:
	nop_s
