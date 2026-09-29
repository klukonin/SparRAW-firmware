/* lmac_if_send_cmd_0x00 @ 0x8db8cc, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__send_init_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, lmac_if__post_cmd, mem_pool__alloc_locked, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x00
lmac_if_send_cmd_0x00:
	.global L_8db8cc
L_8db8cc:
	push_s blink
L_8db8ce:
	bl L_8c01dc
L_8db8d2:
	mov_s r14,r0
L_8db8d4:
	mov_s r15,r1
L_8db8d6:
	mov_s r0,0x804280
L_8db8dc:
	bl.d L_8c33d0
L_8db8e0:
	mov_s r16,r2
L_8db8e2:
	mov.f r13,r0
L_8db8e6:
	beq_s L_8db944
L_8db8e8:
	mov_s r0,0x8042c8
L_8db8ee:
	ldb_s r0,[r0]
L_8db8f0:
	stw_s r15,[r13,0x30]
L_8db8f2:
	st_s r0,[r13,0x40]
L_8db8f4:
	mov_s r0,0xa5
L_8db8f6:
	stw_s r0,[r13,0x36]
L_8db8f8:
	stw_s r0,[r13,0x38]
L_8db8fa:
	mov r0,0x339
L_8db8fe:
	stw_s r0,[r13,0x34]
L_8db900:
	stw r16,[r13, 0x32]
L_8db904:
	mov_s r0,r13
L_8db906:
	mov_s r1,r14
L_8db908:
	bl.d L_8c0380
L_8db90c:
	mov_s r2,0xc
L_8db90e:
	ld_s r0,[r14,0x10]
L_8db910:
	ld_s r1,[r14,0xc]
L_8db912:
	st_s r0,[r13,0x10]
L_8db914:
	st_s r1,[r13,0xc]
L_8db916:
	ld_s r0,[r14,0x18]
L_8db918:
	ld_s r1,[r14,0x14]
L_8db91a:
	st_s r0,[r13,0x20]
L_8db91c:
	st_s r1,[r13,0x1c]
L_8db91e:
	ld_s r0,[r14,0x20]
L_8db920:
	ld_s r1,[r14,0x1c]
L_8db922:
	st_s r0,[r13,0x28]
L_8db924:
	ld_s r0,[r13,0x2c]
L_8db926:
	st_s r1,[r13,0x24]
L_8db928:
	bic r0,r0,0xf
L_8db92c:
	bset_s r0,r0,0x3
L_8db92e:
	st_s r0,[r13,0x2c]
L_8db930:
	mov_s r0,0x4
L_8db932:
	stw_s r0,[r13,0x3c]
L_8db934:
	mov_s r0,0x2
L_8db936:
	stw_s r0,[r13,0x3e]
L_8db938:
	mov_s r0,r13
L_8db93a:
	mov_s r1,0x0
L_8db93c:
	mov_s r2,0x44
L_8db93e:
	bl.d L_8e5204
L_8db942:
	mov_s r3,r1
	.global L_8db944
L_8db944:
	b L_8c0244
