/* l2mgr__send_ready_evt @ 0x8ed87c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HOST EVENT (WMI_READY_EVENTID=0x1001): Notify FW ready (is OOB = %d) Local MAC: ADDR-%04X%08X
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit3, memcpy_fw, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_ready_evt,"ax",@progbits
	.global l2mgr__send_ready_evt
l2mgr__send_ready_evt:
	.global L_8ed87c
L_8ed87c:
	push_s blink
L_8ed87e:
	bl L_8c02c0
L_8ed882:
	mov_s r14,r0
L_8ed884:
	bl.d L_8c2b68
L_8ed888:
	mov_s r15,r1
L_8ed88a:
	mov_s r13,r0
L_8ed88c:
	add_s r0,r0,0x8
L_8ed88e:
	mov_s r1,r14
L_8ed890:
	bl.d L_8c0460
L_8ed894:
	mov_s r2,0x6
L_8ed896:
	mov r0,0x3e8
L_8ed89a:
	st_s r0,[r13]
L_8ed89c:
	mov_s r0,0x0
L_8ed89e:
	stb_s r0,[r13,0xf]
L_8ed8a0:
	ldw r4,[r14, 0x4]
L_8ed8a4:
	mov_s r2,0x100e0c8
L_8ed8aa:
	ld r5,[r14]
L_8ed8ae:
	mov_s r3,0x80345c
L_8ed8b4:
	mov_s r0,0xb
L_8ed8b6:
	mov_s r1,0x2
L_8ed8b8:
	bl.d L_8ee034
L_8ed8bc:
	ld_s r3,[r3,0xc]
L_8ed8be:
	mov_s r0,r13
L_8ed8c0:
	mov_s r1,0x1
L_8ed8c2:
	bset_s r1,r1,0xc
L_8ed8c4:
	mov_s r2,0x10
L_8ed8c6:
	mov_s r3,r15
L_8ed8c8:
	mov r4,0x0
L_8ed8cc:
	bl.d L_8e0874
L_8ed8d0:
	mov r5,r4
L_8ed8d4:
	b L_8c032c
