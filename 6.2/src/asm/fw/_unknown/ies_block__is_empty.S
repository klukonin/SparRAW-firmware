/* ies_block__is_empty @ 0x8da1c0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp_8f9e88, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, tx_mgmt_srvs__build_dmg_beacon
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ies_block__is_empty
ies_block__is_empty:
	.global L_8da1c0
L_8da1c0:
	ldw_s r0,[r0,0x4]
L_8da1c2:
	cmp_s r0,0x0
L_8da1c4:
	mov_s r0,0x1
L_8da1c6:
	j_s.d [blink]
L_8da1c8:
	sub_s.ne r0,r0,r0
L_8da1ca:
	nop_s
