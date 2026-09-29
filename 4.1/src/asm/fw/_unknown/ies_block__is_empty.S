/* ies_block__is_empty @ 0x8d70f0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp, tx_mgmt_srvs__build_dmg_beacon
 */
	.section .text.ies_block__is_empty,"ax",@progbits
	.global ies_block__is_empty
ies_block__is_empty:
	.global L_8d70f0
L_8d70f0:
	ldw_s r0,[r0,0x4]
L_8d70f2:
	cmp_s r0,0x0
L_8d70f4:
	mov_s r0,0x1
L_8d70f6:
	j_s.d [blink]
L_8d70f8:
	sub_s.ne r0,r0,r0
L_8d70fa:
	nop_s
