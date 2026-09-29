/* radio_manager__lock_primary @ 0x8d921c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   radio_manager::lock_primary() (m_allocated = %d) (free cellls = %d)
 *   radio_manager.cpp
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit2, fw_sysassert_fatal, mem_pool__allocate, radio_mgr__enqueue_request
 */
	.section .text.radio_manager__lock_primary,"ax",@progbits
	.global radio_manager__lock_primary
radio_manager__lock_primary:
L_8d921c:
	push_s blink
L_8d921e:
	bl L_8c02b8
L_8d9222:
	mov_s r14,r0
L_8d9224:
	mov_s r15,r1
L_8d9226:
	mov_s r16,r3
L_8d9228:
	add_s r13,r0,0x4
L_8d922a:
	ld_s r3,[r13,0xc]
L_8d922c:
	ld_s r0,[r13,0x10]
L_8d922e:
	mov_s r17,r2
L_8d9230:
	sub r4,r0,r3
L_8d9234:
	mov_s r2,0x1015c80
L_8d923a:
	mov_s r0,0x8
L_8d923c:
	bl.d L_8edff8
L_8d9240:
	mov_s r1,0x2
L_8d9242:
	bl.d L_8c2dc8
L_8d9246:
	mov_s r0,r13
L_8d9248:
	mov.f r13,r0
L_8d924c:
	beq_s L_8d9270
	.global L_8d924e
L_8d924e:
	mov_s r0,0x0
L_8d9250:
	st_s r0,[r13,0x14]
L_8d9252:
	st_s r15,[r13,0xc]
L_8d9254:
	st r17,[r13, 0x10]
L_8d9258:
	mov_s r0,0x1
L_8d925a:
	st_s r0,[r13,0x8]
L_8d925c:
	stb r16,[r13, 0x20]
L_8d9260:
	add r0,r14,0x18
L_8d9264:
	bl.d L_8ddc28
L_8d9268:
	mov_s r1,r13
L_8d926a:
	b.d L_8c031c
L_8d926e:
	mov_s r0,r13
	.global L_8d9270
L_8d9270:
	mov_s r0,blink
L_8d9272:
	mov_s r2,0x1015cc4
L_8d9278:
	mov_s r1,0x115d
L_8d927e:
	bl.d L_8c82c0
L_8d9282:
	mov_s r3,0x16
L_8d9284:
	b_s L_8d924e
L_8d9286:
	nop_s
