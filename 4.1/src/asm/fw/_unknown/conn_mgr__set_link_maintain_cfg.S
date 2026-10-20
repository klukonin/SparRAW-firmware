/* conn_mgr__set_link_maintain_cfg @ 0x8e1978, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::set_link_maintain_cfg(): cfg_type = %d, cid = %d
 *   conn_mgr::set_link_maintain_cfg(): Configuration failed due to bad destination cid = %d
 *   conn_mgr::set_link_maintain_cfg(): Configuration failed due to unknown cfg_type=%d
 * Зовут его: wmi_handler_link_maintain_cfg_write
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, conn__stop_link_loss_monitoring, conn_mgr__by_cid, conn_mgr__print_link_maintain_cfg, fw_log__emit1, fw_log__emit2, link_maintain_cfg__copy, lm_if__start_link_loss_monitoring, memcpy_fw
 */
	.section .text.conn_mgr__set_link_maintain_cfg,"ax",@progbits
	.global conn_mgr__set_link_maintain_cfg
conn_mgr__set_link_maintain_cfg:
	.global L_8e1978
L_8e1978:
	push_s blink
L_8e197a:
	bl L_8c02b4
L_8e197e:
	sub_s sp,sp,0x24
L_8e1980:
	mov_s r13,r0
L_8e1982:
	mov_s r17,r1
L_8e1984:
	mov_s r16,r2
L_8e1986:
	mov_s r2,0x100ad8c
L_8e198c:
	mov_s r0,0xb
L_8e198e:
	mov_s r1,0x2
L_8e1990:
	mov_s r3,r13
L_8e1992:
	bl.d L_8edff8
L_8e1996:
	mov r4,r17
L_8e199a:
	mov r18,-0x1
L_8e199e:
	breq r17,r18,L_8e19ba
L_8e19a2:
	brlo r17,0x8,L_8e19ba
L_8e19a6:
	mov_s r2,0x100adc8
L_8e19ac:
	mov_s r0,0xb
L_8e19ae:
	mov_s r1,0x0
L_8e19b0:
	mov_s r3,r17
	.global L_8e19b2
L_8e19b2:
	bl L_8edfcc
L_8e19b6:
	mov_s r0,0x1
L_8e19b8:
	b_s L_8e1a4a
	.global L_8e19ba
L_8e19ba:
	breq r13,0x4,L_8e19cc
L_8e19be:
	mov_s r14,sp
L_8e19c0:
	mov_s r0,r13
L_8e19c2:
	bl.d L_8c9fcc
L_8e19c6:
	mov_s r1,r14
L_8e19c8:
	breq_s r0,0,L_8e19da
L_8e19ca:
	mov_s r16,r14
	.global L_8e19cc
L_8e19cc:
	bl.d L_8dcea4
L_8e19d0:
	mov_s r0,r16
L_8e19d2:
	breq r17,r18,L_8e19e8
L_8e19d6:
	mov_s r0,r17
L_8e19d8:
	b_s L_8e19ee
	.global L_8e19da
L_8e19da:
	mov_s r2,0x100ae20
L_8e19e0:
	mov_s r0,0xb
L_8e19e2:
	mov_s r1,0x0
L_8e19e4:
	mov_s r3,r13
L_8e19e6:
	b_s L_8e19b2
	.global L_8e19e8
L_8e19e8:
	mov r17,0x0
L_8e19ec:
	mov_s r0,0x7
	.global L_8e19ee
L_8e19ee:
	brlo r0,r17,L_8e1a48
L_8e19f2:
	sub r0,r0,r17
L_8e19f6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e19f8:
	mov_s r15,r17
	.global L_8e19fa
L_8e19fa:
	mov_s r17,r0
L_8e19fc:
	bl.d L_8c9e44
L_8e1a00:
	mov_s r0,r15
L_8e1a02:
	mov.f r14,r0
L_8e1a06:
	mov.eq r13,0x0
L_8e1a0a:
	beq_s L_8e1a16
L_8e1a0c:
	ldb r0,[r14, 0xb0]
L_8e1a10:
	mov_s r13,0x1
L_8e1a12:
	cmp_s r0,0x2
L_8e1a14:
	sub_s.ne r13,r13,r13
	.global L_8e1a16
L_8e1a16:
	cmp_s r13,0x0
L_8e1a18:
	bl.ne.d L_8e2ec8
L_8e1a1c:
	mov.ne r0,r14
L_8e1a20:
	asl_s r0,r15,0x2
L_8e1a22:
	add3_s r0,r0,r0
L_8e1a24:
	add_s r0,r0,0x857060
L_8e1a2a:
	add_s r0,r0,0x1c
L_8e1a2c:
	mov_s r1,r16
L_8e1a2e:
	bl.d L_8c0460
L_8e1a32:
	mov_s r2,0x24
L_8e1a34:
	cmp_s r13,0x0
L_8e1a36:
	bl.ne.d L_8e2874
L_8e1a3a:
	mov.ne r0,r14
L_8e1a3e:
	sub r0,r17,0x1
L_8e1a42:
	/* brhs.d r0,0x1,0x008e19fa */
	.byte 0xbb,0x08,0x75,0x80
L_8e1a46:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8e1a48
L_8e1a48:
	mov_s r0,0x0
	.global L_8e1a4a
L_8e1a4a:
	b.d L_8c0314
L_8e1a4e:
	add_s sp,sp,0x24
