/* fw_log__emit3_nonl @ 0x8ee0e8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: L2MGR__system_state_evt_handler, basic_sm__error_handler, basic_sm__inject_event
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__commit
 */
	.section .text.fw_log__emit3_nonl,"ax",@progbits
	.global fw_log__emit3_nonl
fw_log__emit3_nonl:
	.global L_8ee0e8
L_8ee0e8:
	push_s blink
L_8ee0ea:
	bl.d L_8c02c0
L_8ee0ee:
	mov_s r6,r2
L_8ee0f0:
	mov_s r15,0x843900
L_8ee0f6:
	add_s r2,r15,0x4
L_8ee0f8:
	ldb_s r2,[r2,r0]
L_8ee0fa:
	mov_s r13,r4
L_8ee0fc:
	mov r4,r5
L_8ee100:
	bbit0 r2,r1,L_8ee130
L_8ee104:
	ld_s r14,[r15]
L_8ee106:
	add_s r2,r14,0x3
L_8ee108:
	bmsk_s r2,r2,0x9
L_8ee10a:
	add2 r2,r15,r2
L_8ee10e:
	st r4,[r2, 0x14]
L_8ee112:
	add_s r2,r14,0x2
L_8ee114:
	bmsk_s r2,r2,0x9
L_8ee116:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8ee118:
	add2 r2,r15,r2
L_8ee11c:
	bmsk_s r14,r14,0x9
L_8ee11e:
	st_s r13,[r2,0x14]
L_8ee120:
	add2_s r15,r15,r14
L_8ee122:
	st_s r3,[r15,0x14]
L_8ee124:
	mov_s r2,r6
L_8ee126:
	mov_s r3,0x3
L_8ee128:
	bl.d L_8ee134
L_8ee12c:
	mov r4,0x1
	.global L_8ee130
L_8ee130:
	b L_8c032c
