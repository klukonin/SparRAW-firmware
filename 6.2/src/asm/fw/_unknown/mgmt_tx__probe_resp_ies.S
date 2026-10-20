/* mgmt_tx__probe_resp_ies @ 0x8d7f78, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__build_probe_req
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ie__push_dmg_capabilities, ie__push_raw, ie__push_ssid, mgmt_tx__copy_ie_max96
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__probe_resp_ies
mgmt_tx__probe_resp_ies:
	.global L_8d7f78
L_8d7f78:
	push_s blink
L_8d7f7a:
	bl.d L_8c01e0
L_8d7f7e:
	extb_s r3,r3
L_8d7f80:
	mov_s r14,r0
L_8d7f82:
	mov_s r13,r1
L_8d7f84:
	mov_s r1,r2
L_8d7f86:
	bl.d L_8e2028
L_8d7f8a:
	mov_s r2,r3
L_8d7f8c:
	extw_s r15,r0
L_8d7f8e:
	add_s r14,r14,r15
L_8d7f90:
	add3 r1,r13,0x30
L_8d7f94:
	bl.d L_8e1ff0
L_8d7f98:
	mov_s r0,r14
L_8d7f9a:
	extw_s r0,r0
L_8d7f9c:
	add_s r15,r15,r0
L_8d7f9e:
	extw_s r15,r15
L_8d7fa0:
	add_s r14,r14,r0
L_8d7fa2:
	add1 r1,r13,0x2f
L_8d7fa6:
	mov_s r0,r14
L_8d7fa8:
	bl.d L_8e1fd4
L_8d7fac:
	mov_s r2,0x0
L_8d7fae:
	extw_s r0,r0
L_8d7fb0:
	add_s r15,r15,r0
L_8d7fb2:
	extw_s r15,r15
L_8d7fb4:
	add_s r0,r0,r14
L_8d7fb6:
	mov_s r1,r13
L_8d7fb8:
	ldb r2,[r13,0x17a]
L_8d7fc0:
	bl.d L_8e2048
L_8d7fc4:
	add r1,r1,0x11a
L_8d7fc8:
	extw_s r0,r0
L_8d7fca:
	add_s r0,r0,r15
L_8d7fcc:
	b.d L_8c024c
L_8d7fd0:
	extw_s r0,r0
L_8d7fd2:
	nop_s
