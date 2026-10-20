/* conn_mgr__alloc_cid @ 0x8c3290, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__link_acquisition_action, pbss__alloc_sta_entry
 * Зовёт сам: __ld_r13_to_r13_ret, conn_mgr__find_reusable_cid, fw_sysassert_fatal, mem_pool__allocate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__alloc_cid
conn_mgr__alloc_cid:
	.global L_8c3290
L_8c3290:
	push_s blink
L_8c3292:
	push_s r13
L_8c3294:
	mov_s r13,0x8540c0
L_8c329a:
	ld_s r1,[r13,0xc]
L_8c329c:
	ld_s r0,[r13,0x10]
L_8c329e:
	cmp_s r1,r0
L_8c32a0:
	mov_s r0,0x1
L_8c32a2:
	sub.cs r0,r0,r0
L_8c32a6:
	breq_s r0,0,L_8c32ce
L_8c32a8:
	bl L_8c656c
L_8c32ac:
	brne_s r0,0,L_8c32ce
L_8c32ae:
	ld_s r1,[r13,0xc]
L_8c32b0:
	ld_s r0,[r13,0x10]
L_8c32b2:
	cmp_s r1,r0
L_8c32b4:
	mov_s r0,0x1
L_8c32b6:
	sub.cs r0,r0,r0
L_8c32ba:
	breq_s r0,0,L_8c32c0
	.global L_8c32bc
L_8c32bc:
	mov_s r0,0x0
L_8c32be:
	b_s L_8c32d4
	.global L_8c32c0
L_8c32c0:
	mov_s r0,blink
L_8c32c2:
	mov_s r1,0x11ca
L_8c32c8:
	bl L_8c9b28
L_8c32cc:
	b_s L_8c32bc
	.global L_8c32ce
L_8c32ce:
	bl.d L_8c354c
L_8c32d2:
	mov_s r0,r13
	.global L_8c32d4
L_8c32d4:
	b L_8c025c
