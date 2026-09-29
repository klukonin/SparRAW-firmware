/* calib_engine__on_lock_radio @ 0x8dca54, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r19_to_r13_ret, __st_r19_to_r13, fw_sysassert_fatal, mem_pool__allocate, radio_mgr__enqueue_request, radio_mgr__request
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__on_lock_radio
calib_engine__on_lock_radio:
	.global L_8dca54
L_8dca54:
	push_s blink
L_8dca56:
	push_s r13
L_8dca58:
	mov_s r13,r0
L_8dca5a:
	ld_s r0,[r0,0x14]
L_8dca5c:
	brne r0,0x1,L_8dca80
	.global L_8dca60
L_8dca60:
	ld_s r0,[r13,0x24]
L_8dca62:
	brne_s r0,0,L_8dca8e
	.global L_8dca64
L_8dca64:
	mov_s r0,0x24eb8
L_8dca6a:
	mov_s r1,r13
L_8dca6c:
	mov_s r2,0x0
L_8dca6e:
	mov_s r3,0xffff
L_8dca74:
	bl.d L_8dcaf4
L_8dca78:
	mov_s r4,r2
L_8dca7a:
	b.d L_8c025c
L_8dca7e:
	st_s r0,[r13,0x24]
	.global L_8dca80
L_8dca80:
	mov_s r0,blink
L_8dca82:
	mov_s r1,0x1205
L_8dca88:
	bl L_8c9b28
L_8dca8c:
	b_s L_8dca60
	.global L_8dca8e
L_8dca8e:
	mov_s r0,blink
L_8dca90:
	mov_s r1,0x11bc
L_8dca96:
	bl L_8c9b28
L_8dca9a:
	b_s L_8dca64
L_8dca9c:
	push_s blink
L_8dca9e:
	bl L_8c01d0
L_8dcaa2:
	mov_s r13,r0
L_8dcaa4:
	mov_s r15,r1
L_8dcaa6:
	mov_s r17,r2
L_8dcaa8:
	mov_s r16,r3
L_8dcaaa:
	mov r19,r4
L_8dcaae:
	mov r18,r5
L_8dcab2:
	bl.d L_8c354c
L_8dcab6:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8dcab8:
	mov.f r14,r0
L_8dcabc:
	beq_s L_8dcae6
	.global L_8dcabe
L_8dcabe:
	mov_s r1,0x1
L_8dcac0:
	st_s r1,[r14,0x14]
L_8dcac2:
	st r16,[r14, 0x1c]
L_8dcac6:
	st r19,[r14, 0x18]
L_8dcaca:
	st_s r15,[r14,0xc]
L_8dcacc:
	st r17,[r14, 0x10]
L_8dcad0:
	st_s r1,[r14,0x8]
L_8dcad2:
	stb r18,[r14, 0x20]
L_8dcad6:
	add r0,r13,0x18
L_8dcada:
	bl.d L_8e1f70
L_8dcade:
	mov_s r1,r14
L_8dcae0:
	b.d L_8c022c
L_8dcae4:
	mov_s r0,r14
	.global L_8dcae6
L_8dcae6:
	mov_s r0,blink
L_8dcae8:
	mov_s r1,0x115e
L_8dcaee:
	bl L_8c9b28
L_8dcaf2:
	b_s L_8dcabe
