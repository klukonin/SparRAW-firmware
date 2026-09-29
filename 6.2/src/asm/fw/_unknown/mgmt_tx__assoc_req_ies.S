/* mgmt_tx__assoc_req_ies @ 0x8f4ec0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_assoc_req
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ie__push_dmg_capabilities, ie__push_qos_capability, ie__push_raw, ie__push_ssid, mid__copy_ssid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__assoc_req_ies
mgmt_tx__assoc_req_ies:
	.global L_8f4ec0
L_8f4ec0:
	push_s blink
L_8f4ec2:
	bl L_8c01e0
L_8f4ec6:
	sub_s sp,sp,0x20
L_8f4ec8:
	mov_s r14,r0
L_8f4eca:
	mov_s r15,r1
L_8f4ecc:
	mov_s r13,sp
L_8f4ece:
	mov_s r0,r1
L_8f4ed0:
	bl.d L_8ccc98
L_8f4ed4:
	mov_s r1,r13
L_8f4ed6:
	extb_s r2,r0
L_8f4ed8:
	mov_s r0,r14
L_8f4eda:
	bl.d L_8e2028
L_8f4ede:
	mov_s r1,r13
L_8f4ee0:
	extw_s r13,r0
L_8f4ee2:
	add_s r14,r14,r13
L_8f4ee4:
	add3 r1,r15,0x30
L_8f4ee8:
	bl.d L_8e1ff0
L_8f4eec:
	mov_s r0,r14
L_8f4eee:
	extw.f r0,r0
L_8f4ef2:
	beq_s L_8f4efa
L_8f4ef4:
	add_s r14,r14,r0
L_8f4ef6:
	add_s r13,r13,r0
L_8f4ef8:
	extw_s r13,r13
	.global L_8f4efa
L_8f4efa:
	bl.d L_8e1f4c
L_8f4efe:
	mov_s r0,r14
L_8f4f00:
	extw_s r0,r0
L_8f4f02:
	add_s r14,r14,r0
L_8f4f04:
	add_s r13,r13,r0
L_8f4f06:
	extw_s r13,r13
L_8f4f08:
	add1 r1,r15,0x2f
L_8f4f0c:
	mov_s r0,r14
L_8f4f0e:
	bl.d L_8e1fd4
L_8f4f12:
	mov_s r2,0x0
L_8f4f14:
	extw_s r0,r0
L_8f4f16:
	add_s r0,r0,r13
L_8f4f18:
	extw_s r0,r0
L_8f4f1a:
	b.d L_8c024c
L_8f4f1e:
	add_s sp,sp,0x20
